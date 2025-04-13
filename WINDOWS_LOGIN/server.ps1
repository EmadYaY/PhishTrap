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

# Start listener
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:12345/")
$listener.Start()

# Open Edge in Kiosk mode
Start-Process "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" `
    -ArgumentList "--kiosk", "--edge-kiosk-type=fullscreen", "http://localhost:12345/", "--disable-features=Translate,msWebOOUI,msPdfOOUI,AutofillServerCommunication,AutofillCreditCard,AutofillAddressProfileSavePrompt,PasswordSuggestions,HelpAppLauncher,QSE,EdgeFeedback"

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
            $buffer = [System.IO.File]::ReadAllBytes("res/user.webp")
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

            if (Test-Credential -CredentialUserName $($env:USERNAME) -PlainPassword $password) {
                $buffer = [System.Text.Encoding]::UTF8.GetBytes("OK")
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
