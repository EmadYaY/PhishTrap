
$ErrorActionPreference= 'silentlycontinue'


# Function: Check local Windows credential using ADSI
function Test-Credential {
    param(
        [string]$Scope = "Local",
        [string]$CredentialUserName = $env:USERNAME,
        [string]$PlainPassword
    )

    $SecurePassword = $PlainPassword | ConvertTo-SecureString -AsPlainText -Force
    $Credential = New-Object System.Management.Automation.PSCredential($CredentialUserName, $SecurePassword)

    try {
        $UserCheck = [ADSI]"WinNT://$env:COMPUTERNAME/$($Credential.UserName)"
        $UserCheck.psbase.Invoke("ChangePassword", $Credential.GetNetworkCredential().Password, $Credential.GetNetworkCredential().Password)
        return $true
    } catch {
        return $false
    }
}
# Function: Check user have password set account

function Test-UserHasPassword {
    param (
        [string]$Username = $env:USERNAME,
        [string]$Domain = $env:COMPUTERNAME
    )

    Add-Type @"
using System;
using System.Runtime.InteropServices;
public class L {
    [DllImport("advapi32.dll", SetLastError = true)]
    public static extern bool LogonUser(string u, string d, string p, int t, int pr, out IntPtr tok);
}
"@ -ErrorAction SilentlyContinue

    $token = [IntPtr]::Zero
    if ([L]::LogonUser($Username, $Domain, "", 2, 0, [ref]$token)) {
        return $false  # No password
    } else {
        return $true   # Password is set
    }
}
# function to check if the current user is connected to the internet, and whether it's via Wi-Fi or Ethernet (LAN)
function Get-NetworkStatus {
    $adapters = Get-NetConnectionProfile | Where-Object { $_.IPv4Connectivity -ne "None" }

    if (-not $adapters) {
        return "❌ Not connected to internet"
    }

    foreach ($adapter in $adapters) {
        $interface = Get-NetAdapter -InterfaceIndex $adapter.InterfaceIndex
        $type = switch ($interface.InterfaceDescription) {
            {$_ -match "Wi-Fi"}     { "Wi-Fi" }
            {$_ -match "Wireless"}  { "Wi-Fi" }
            {$_ -match "Ethernet"}  { "Ethernet" }
            default                 { "Unknown" }
        }

        return "✅ Connected via $type"
    }
}
#  current active layout lang
function Get-InstalledKeyboardLayouts {
    $sid = ([System.Security.Principal.WindowsIdentity]::GetCurrent()).User.Value
    $regPath = "Registry::HKEY_USERS\$sid\Keyboard Layout\Preload"
    $preloads = Get-ItemProperty -Path $regPath

    $layouts = @()

    foreach ($prop in $preloads.PSObject.Properties) {
        if ($prop.Name -match '^\d+$') {
            $hexId = $prop.Value
            $lid = [int]("0x$hexId")
            try {
                $culture = [System.Globalization.CultureInfo]::GetCultureInfo($lid)
                $layouts += [PSCustomObject]@{
                    Id           = $lid
                    CultureName  = $culture.Name
                    DisplayName  = $culture.EnglishName
                }
            } catch {
                $layouts += [PSCustomObject]@{
                    Id           = $lid
                    CultureName  = "Unknown"
                    DisplayName  = "Unknown layout ($hexId)"
                }
            }
        }
    }

    return $layouts
}

#  function  returns the image path user login if it exists
function Get-UserLoginImagePath {
    $regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AccountPicture\Users"
    $sid = ([System.Security.Principal.WindowsIdentity]::GetCurrent()).User.Value
    $key = Get-Item "$regPath\$sid" -ErrorAction SilentlyContinue

    if ($key) {
        $imgPath = $key.GetValue("Image192")
        if (Test-Path $imgPath) {
            return $imgPath
        }
    }
    return $null
}


if(Test-UserHasPassword){
# Start listener
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:12345/")
$listener.Start()
$imagePath = Get-UserLoginImagePath


# Open Edge in Kiosk mode
$edge=Start-Process "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" `
    -ArgumentList "--kiosk", "--edge-kiosk-type=fullscreen", "http://localhost:12345/", "--disable-features=Translate,msWebOOUI,msPdfOOUI,AutofillServerCommunication,AutofillCreditCard,AutofillAddressProfileSavePrompt,PasswordSuggestions,HelpAppLauncher,QSE,EdgeFeedback" -PassThru

# Serve loop
while ($listener.IsListening) {
    $context  = $listener.GetContext()
    $request  = $context.Request
    $response = $context.Response
    $url      = $request.Url.AbsolutePath
    $method   = $request.HttpMethod

    switch ("$method $url") {
        "GET /" {
            $response.ContentType = "text/html"
            $body = Get-Content "res/login.html" -Raw -Encoding UTF8
            $buffer = [System.Text.Encoding]::UTF8.GetBytes($body)
        }

        "GET /user" {
            $response.ContentType = "text/plain"
            $buffer = [System.Text.Encoding]::UTF8.GetBytes($env:USERNAME)
        }

        "GET /output.css" {
            $response.ContentType = "text/css"
            $body = Get-Content "res/output.css" -Raw -Encoding UTF8
            $buffer = [System.Text.Encoding]::UTF8.GetBytes($body)
        }

        "GET /user.webp" {
            $response.ContentType = "image/webp"
            if ($imagePath) {
            $buffer = [System.IO.File]::ReadAllBytes($imagePath)

            } else {
            $buffer = [System.IO.File]::ReadAllBytes("res/user.webp")
            }
        }

        "GET /login.jpg" {
            $response.ContentType = "image/jpeg"
            $buffer = [System.IO.File]::ReadAllBytes("res/login.jpg")
        }

        "POST /run" {
            $reader = New-Object System.IO.StreamReader($request.InputStream)
            $formData = $reader.ReadToEnd()
            $reader.Close()

            $password = [System.Net.WebUtility]::UrlDecode($formData) -replace "^password=", ""

            if (Test-Credential -PlainPassword $password) {
                $buffer = [System.Text.Encoding]::UTF8.GetBytes("OK")
                $edge.Kill()
                exit
            } else {
                $buffer = [System.Text.Encoding]::UTF8.GetBytes("FAIL")
            }
        }

        default {
            $response.StatusCode = 404
            $response.ContentType = "text/plain"
            $buffer = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
        }
    }

    $response.ContentLength64 = $buffer.Length
    $response.OutputStream.Write($buffer, 0, $buffer.Length)
    $response.OutputStream.Close()
}
}
else{
    write-host "❌ User has NO password (empty password accepted)"
}