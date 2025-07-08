# Natural-Scrolling-Fix

[![AutoHotkey](https://img.shields.io/badge/AutoHotkey-v2.0+-blue.svg)](https://www.autohotkey.com/)
[![License: MIT](https://img.shields.io/badge/License-GNU-yellow.svg)](LICENSE)

A natural scrolling Fix for windows. Act like MacOS, but left wheel zoom (ctrl+wheel) direction unchanged.
It‘s an AutoHotkey script that reverses your mouse wheel scrolling direction while preserving standard Ctrl+scroll zoom behavior. Perfect for users who prefer natural scrolling like macOS trackpads.

## Why This Exists

Windows lacks a native option for "natural" (reverse-direction) scrolling that doesn't interfere with Ctrl+scroll zooming. This script solves that by:
- Reversing scroll direction during normal use
- Preserving standard scroll direction when Ctrl is held
- Working system-wide for all applications

## How It Works

The script intelligently intercepts mouse wheel events:
```
When scrolling normally:
  ↑ WheelUp becomes ↓ WheelDown
  ↓ WheelDown becomes ↑ WheelUp

When holding Ctrl (zooming):
  ↑ WheelUp remains ↑ WheelUp
  ↓ WheelDown remains ↓ WheelDown
```
## Features

✅ System-wide natural scrolling  
✅ Preserves standard Ctrl+scroll zoom  
✅ Lightweight (uses <1MB RAM)  
✅ Compatible with Windows 10/11  
🚫 No admin rights required  

## Installation
### Use EXE
  - Go to Release and download the latest released version.
  - Run the .exe file. It may requires admin permission.
   
### Run as AutoHotKey Script
1. **[Install AutoHotkey](https://www.autohotkey.com/download/)**([v2.0+]required)
   _[click here](https://www.autohotkey.com/download/ahk-v2.exe)  to download autohotkey v.2.0_
3. **Save the script:**
   - fetch _Natural-Scrolling-Fix.ahk_ use **git pull** or directly download form web to perferred place.
   - **DO NOT DELETE OR MOVE THE SCRIPT.**
4. **Run the script:** Double-click the `.ahk` file

## Customization

Modify the script to add exceptions or change behavior:

```ahk
; Example: Add Alt key exception for graphic apps
WheelUp::
    If GetKeyState("Ctrl", "P") || GetKeyState("Alt", "P")
        Send {WheelUp}
    Else
        Send {WheelDown}
Return
```

## Troubleshooting

- **Script not running?** Right-click → "Run as Administrator"
- **Antivirus warning?** Add exception for AutoHotkey scripts
- **Need to pause?** Right-click system tray icon → Suspend Hotkeys
- **Conflicting apps?** Add exclusion rules to the script

## Known Limitations

⚠️ May require adjustments for some mouse utilities  
⚠️ Touchpad gestures not affected (use OS settings)  
⚠️ First run may trigger security warnings  

## Alternatives

For non-script solutions, consider:
- [Microsoft PowerToys](https://github.com/microsoft/PowerToys) (limited natural scroll options)
- [ReverseMouseWheel](https://www.softpedia.com/get/System/System-Miscellaneous/Reverse-Mouse-Wheel.shtml)

## Contributing

Found a bug? Have an improvement?  
1. Fork the repository  
2. Create your feature branch (`git checkout -b feature/improvement`)  
3. Commit your changes  
4. Push to the branch  
5. Open a pull request

## License

Distributed under the GNUv3 License. See `LICENSE` for more information.

---

##**Disclaimer**: 
  - This is an unofficial solution. Use at your own risk. Not responsible for system instability.
  - Copilot with DeepSeek.
