# rpa-vehiclekeys

<div align="center">

![GitHub Release](https://img.shields.io/github/v/release/RP-Alpha/rpa-vehiclekeys?style=for-the-badge&logo=github&color=blue)
![GitHub commits](https://img.shields.io/github/commits-since/RP-Alpha/rpa-vehiclekeys/latest?style=for-the-badge&logo=git&color=green)
![License](https://img.shields.io/github/license/RP-Alpha/rpa-vehiclekeys?style=for-the-badge&color=orange)
![Downloads](https://img.shields.io/github/downloads/RP-Alpha/rpa-vehiclekeys/total?style=for-the-badge&logo=github&color=purple)

**Standalone Vehicle Key System**

</div>

---

## ✨ Features

- 🔐 **Lock/Unlock** - Press `L` with visual & audio feedback
- 🚗 **Engine Control** - `/engine` command
- 🔗 **Integration** - Exports for garages and jobs
- 🛡️ **Anti-Theft** - Prevents engine start without keys

---

## 📥 Installation

1. Download the [latest release](https://github.com/RP-Alpha/rpa-vehiclekeys/releases/latest)
2. Extract to your `resources` folder
3. Add to `server.cfg`:
   ```cfg
   ensure rpa-vehiclekeys
   ```

---

## 📚 Exports

```lua
-- Give keys (Client)
exports['rpa-vehiclekeys']:GiveKeys(plate)

-- Check keys (Client)
local hasKeys = exports['rpa-vehiclekeys']:HasKeys(plate)
```

---

## ⌨️ Controls

| Key | Action |
|-----|--------|
| `L` | Lock/Unlock vehicle |
| `/engine` | Toggle engine |

---

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

<div align="center">
  <sub>Built with ❤️ by <a href="https://github.com/RP-Alpha">RP-Alpha</a></sub>
</div>
