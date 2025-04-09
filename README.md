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

1. **User connects** to a remote server using the provided `.rdp` file.
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



---

## ▶️ Demo Video & Wiki

- **Video Demo:** [YouTube Link Here](#) *(Coming soon)*
- **Setup Guide:** [Go to Wiki](#)

---

## 🛠️ Built With

- Pure **PowerShell** scripting (no external dependencies)
- Optional support for:
  - `PS2EXE` for compiling to `.exe`
  - `NirCmd`, `Resource Hacker`, or `Bat To Exe` for behavior masking

---


