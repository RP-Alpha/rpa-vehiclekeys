# rpa-vehiclekeys

A standalone vehicle key system for FiveM, built as part of the RP-Alpha suite.

## Features
- **Key Management**: robust ownership system for vehicles.
- **Lock/Unlock**: Simple keybind (`L`) with visual and audio feedback.
- **Engine Toggle**: Command (`/engine`) to toggle engine state.
- **Integration**: Exports available for other resources (Garages, Jobs).
- **Security**: Prevents engine start without keys.

## Installation
1. Ensure `rpa-lib` is started.
2. Add `ensure rpa-vehiclekeys` to your `server.cfg`.

## Usage
- **Lock/Unlock**: Press `L` near or inside a vehicle you own.
- **Engine**: Type `/engine` inside a vehicle you own.

## Exports
```lua
-- Give keys to a player for a specific plate (Client Side)
exports['rpa-vehiclekeys']:GiveKeys(plate)

-- Check if player has keys (Client Side)
local hasKeys = exports['rpa-vehiclekeys']:HasKeys(plate)
```

## Credits
- RP-Alpha Development Team

## License
MIT
