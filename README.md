

![PowerShell](https://img.shields.io/badge/Built%20With-PowerShell-blue?logo=powershell)
![Platform](https://img.shields.io/badge/Platform-Windows_Server-lightgrey?logo=windows)
![License](https://img.shields.io/badge/Use%20at%20your%20own%20risk-critical?logo=skull)

---


# 🧠 PhishTrap

> Weaponized Windows Phishing Toolkit – Social Engineering with Pure PowerShell  
> ⚔️ Red Team tools for capturing credentials & planting payloads using native Windows features.

---

## 🎯 Project Objective

**PhishTrap** is a Red Team-oriented toolkit designed to **simulate phishing scenarios using legitimate Windows components**. Instead of using exploits or malware, it leverages trusted UI elements and built-in OS behaviors to **stealthily trick users into revealing credentials or enabling access vectors**.

### 👾 Key Features:
- Fully written in **PowerShell**
- No need for external tools or exploits
- Stealthy and highly customizable
- Built for **Red Team ops**, **Adversary Emulation**, and **Security Labs**

---

## 📦 Included Tools

### 1. 🪟 `Fake Windows Login` (Credential Harvester)
- Displays a **realistic Windows login screen**
- Captures the password typed by the user
- No LSASS dump or suspicious behavior
- Perfect for **post-exploitation** or **internal phishing**

📁 `WINDOWS_LOGIN/`

---

### 2. 🖥️ `RDP Phishing Kiosk` (Initial Access + Payload Drop)
- Weaponized `.rdp` file and a Windows Server setup
- Locks user inside a **kiosk-style session**
- Tricks them into enabling **Drive Sharing**
- When enabled, drops payload via `\\tsclient` to their local system

📁 `RDP/`

🔐 Includes:
- Key disabling (Alt+Tab, Ctrl+Alt+Del)
- Fake security prompt in fullscreen Edge
- Auto-drop into Startup folder
- Registry-based persistence & cleanup logic

## 🧠 Idea Behind the Tool

This tool simulates a **real-world initial access scenario** via a weaponized Windows Server and an `.rdp` file. It's made for **Red Team operations**, adversary emulation, or lab experiments.

> **Goal:** Trick users into enabling drive sharing through RDP and silently plant a payload for post-exploitation.





## 🛠️ How It Works

| Step | Action |
|------|--------|
| 1️⃣ | User opens an `.rdp` file or connects to server |
| 2️⃣ | A Kiosk session launches, disabling all key combos |
| 3️⃣ | User sees a **fake security popup** asking to enable drive sharing |
| 4️⃣ | If sharing is enabled, tool gains access to local system via `\\tsclient` |
| 5️⃣ | Payload is copied to `Startup` for future execution |
| 6️⃣ | Session exits Kiosk mode and restores real desktop |


## ▶️ Demo Video & Wiki


- **Video Setup:** [Watch the video](https://www.youtube.com/watch?v=dahuidcxS2U)
- [Watch Demo video](res/demo-video.mp4)
- setup:
  - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon` for run first process and first time
  - `use shell:startup` and `shell:commo` for deploy malware and re check fake security page every time user connect for recheck. 
  - `use sharpkeys tools` and `reg file` for disable keys and remove.



### 3. 🔒 `Credential Export via Social Lock Screen` (CREDWIZ_LOCKSCREEN)

- Displays a fake fullscreen security window instructing the user to press `Ctrl + Alt + Delete`
- User is told to enter a **"Secure Access Code"** (e.g. `1234`)
- Meanwhile, the script silently launches `credwiz.exe` and uses the same code (`1234`) to generate a `.crd` backup file
- Since the password was attacker-defined, the resulting credential export can be easily decrypted later

📁 `CREDWIZ_LOCKSCREEN/`

🧠 **This technique tricks the user into generating a credential export encrypted with a known password – without ever asking for their real system password.**

### 4. 🌀 Fake Windows Update Screen (User Delay + Distraction Trap)

Displays a realistic, full-screen **"Windows Update in Progress"** UI  
Blocks user interaction and disables key combos (Alt+Tab, Ctrl+Alt+Del)  
Used as a **diversion layer** during post-exploitation or payload deployment

📁 `WINDOWS_UPDATE/`

🧠 **Usage Scenario**

The fake update screen is used to:

-   Keep the user distracted while payloads are being deployed in the background
    
-   Prevent user input or investigation during sensitive operations
    
-   Give the illusion of a system update, increasing trust and delay

## 💡 Usage Ideas

- Combine with **C2 frameworks** for post-execution control  
- Deploy in **lab simulations** to train Blue Teams  
- Bypass AV by avoiding typical malware behavior  
- Use in **Red Team assessments** with stealth-first mindset  


<h2 id="contact">📧 Contact</h2>
<p >
<a href="https://t.me/amajax"><img title="Telegram" src="https://img.shields.io/badge/Telegram-black?style=for-the-badge&logo=Telegram"></a>
<a href="https://www.youtube.com/channel/UC0-QcOXgzRgSfcE3zerwu9w/?sub_confirmation=1"><img title="Youtube" src="https://img.shields.io/badge/Youtube-red?style=for-the-badge&logo=Youtube"></a>
<a href="https://www.instagram.com/sectoolfa"><img title="Instagram" src="https://img.shields.io/badge/Instagram-white?style=for-the-badge&logo=Instagram"></a>

## ⚠️ Legal & Ethical Disclaimer

🚨 This tool is developed strictly for educational and authorized security testing purposes only.

🔬 It is intended to help cybersecurity professionals, researchers, and enthusiasts understand post-exploitation, red teaming, and detection techniques in lab or controlled environments.

❌ Do NOT use this tool on any system or network without explicit permission. Unauthorized use may be illegal and unethical.

🛡 The author takes no responsibility for any misuse or damage caused by this project.

---
> Always hack responsibly. 💻🔐

