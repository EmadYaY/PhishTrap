Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form
$form.WindowState = 'Maximized'
$form.FormBorderStyle = 'None'
$form.BackColor = 'Black'
$form.TopMost = $true
$form.StartPosition = 'CenterScreen'
$form.KeyPreview = $true
$form.Add_KeyDown({ 
    if ($_.KeyCode -eq "F4" -and $_.Alt) { $_.Handled = $true }
})

$labelMiddle = New-Object Windows.Forms.Label
$labelMiddle.ForeColor = 'White'
$labelMiddle.Font = New-Object Drawing.Font 'Segoe UI', 18
$labelMiddle.AutoSize = $true
$labelMiddle.Text = 'Please keep your computer on.'
$labelMiddle.Location = New-Object Drawing.Point(0, 0)
$labelMiddle.TextAlign = 'MiddleCenter'
$form.Controls.Add($labelMiddle)

$labelBottom = New-Object Windows.Forms.Label
$labelBottom.ForeColor = 'White'
$labelBottom.Font = New-Object Drawing.Font 'Segoe UI', 14
$labelBottom.AutoSize = $true
$labelBottom.Text = 'Your computer may restart a few times.'
$labelBottom.Location = New-Object Drawing.Point(0, 0)
$labelBottom.TextAlign = 'MiddleCenter'
$form.Controls.Add($labelBottom)

$form.Add_Shown({
    $center = {
     

        $labelMiddle.Left = ($form.ClientSize.Width - $labelMiddle.Width) / 2
        $labelMiddle.Top  = ($form.ClientSize.Height / 2) - 30

        $labelBottom.Left = ($form.ClientSize.Width - $labelBottom.Width) / 2
        $labelBottom.Top  = $form.ClientSize.Height - 100
    }
    $center.Invoke()
    $form.Add_Resize($center)
})



[Windows.Forms.Application]::Run($form)
