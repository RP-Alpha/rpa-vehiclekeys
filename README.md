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
- � **Lockpicking** - Item-based with break chance
- 🔥 **Hotwiring** - Skill-check minigame
- 🔗 **Shared Keys** - Share with gang/job members
- 🛡️ **Anti-Theft** - Prevents engine start without keys

---

## 📦 Dependencies

- `rpa-lib` (Required)

---

## 📥 Installation

1. Download the [latest release](https://github.com/RP-Alpha/rpa-vehiclekeys/releases/latest)
2. Extract to your `resources` folder
3. Add to `server.cfg`:
   ```cfg
   ensure rpa-lib
   ensure rpa-vehiclekeys
   ```

---

## ⚙️ Configuration

```lua
Config.LockpickItem = 'lockpick'
Config.LockpickTime = 15000
Config.LockpickBreakChance = 25
Config.AlertPolice = true

Config.SharedKeys = {
    enabled = true,
    maxShares = 5,
    gangSharing = true,
    jobSharing = true
}
```

---

## 📚 Exports

### Client

```lua
exports['rpa-vehiclekeys']:GiveKeys(plate)
exports['rpa-vehiclekeys']:HasKeys(plate)
exports['rpa-vehiclekeys']:RemoveKeys(plate)
```

### Server

```lua
exports['rpa-vehiclekeys']:GiveKeys(source, plate)
exports['rpa-vehiclekeys']:GiveTempKeys(source, plate)
exports['rpa-vehiclekeys']:RemoveKeys(source, plate)
exports['rpa-vehiclekeys']:HasKeys(source, plate)
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
