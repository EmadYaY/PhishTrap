# ⚔️ Weaponized Windows Server via RDP  
> A creative red team technique using pure PowerShell and social engineering over RDP.

![PowerShell](https://img.shields.io/badge/Built%20With-PowerShell-blue?logo=powershell)
![Platform](https://img.shields.io/badge/Platform-Windows_Server-lightgrey?logo=windows)
![License](https://img.shields.io/badge/Use%20at%20your%20own%20risk-critical?logo=skull)

---

## 🧠 Idea Behind the Tool

This tool simulates a **real-world initial access scenario** via a weaponized Windows Server and an `.rdp` file. It's made for **Red Team operations**, adversary emulation, or lab experiments.

> **Goal:** Trick users into enabling drive sharing through RDP and silently plant a payload for post-exploitation.

---

## ⚙️ How It Works

1. **User connects** to a remote server using the provided `.rdp` file. or `server_ip`
2. A **custom server-side application** launches and forces the Windows environment into a **kiosk-style lockdown**:
   - Disables all key combinations: `Alt+Tab`, `Ctrl+Alt+Del`, `Win key`, etc.
   - Prevents user from interacting with the real desktop.

3. A **fake security prompt** is displayed:
   - If **Drive Sharing** is already enabled, the tool moves to the next stage.
   - If **not**, the user is shown a warning suggesting a "security feature" must be enabled, tricking them into turning on sharing.

4. When sharing is enabled, the tool:
   - Gains access to the local user's system via `\\tsclient`
   - Plants a **payload in the Startup folder** for persistence or further execution


---
> This Tools Now Just Like POC You need Custom for self use for example after everything ok delete reg key and escape from kiosk-style and show somethings...You KNOW🤣

---
> This Tools Use edge open in kiosk mode and full screen open html tempalte generate by powershell dynamic for check with combine key user cant escape or exit🔒

---

## ▶️ Demo Video & Wiki

- **Video Demo:** [YouTube Link Here](#) *(Coming soon)*
- [Watch demo video](res/demo-video.mp4)

- setup:
  - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon` for run first process and first time
  - `use shell:startup` and `shell:commo` for deploy malware and re check fake security page every time user connect for recheck. 
  - `use sharpkeys tools` and `reg file` for disable keys and remove.

---

## 🛠️ Built With

- Pure **PowerShell** scripting (no external dependencies)
- Optional support for:
  - `PS2EXE` for compiling to `.exe`
  - `NirCmd`, `Resource Hacker`, or `Bat To Exe` for behavior masking

---



<h2 id="next-update">🔱 Next Update</h2>
<ul>
<li>add more template and shell access</li>
</ul>
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
