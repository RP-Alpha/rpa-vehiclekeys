-- Server-side vehicle keys storage
-- Keys are stored per player identifier for persistence

local PlayerKeys = {} -- [identifier] = { [plate] = true }
local TempKeys = {} -- [source] = { [plate] = true } for temporary keys (given by other players)

-- Get player identifier
local function GetPlayerIdentifier(src)
    local Framework = exports['rpa-lib']:GetFramework()
    if Framework then
        local Player = Framework.Functions.GetPlayer(src)
        if Player then
            return Player.PlayerData.citizenid
        end
    end
    
    -- Fallback to license
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if string.find(id, 'license:') then
            return id
        end
    end
    return nil
end

-- Load player keys from database on connect
local function LoadPlayerKeys(src)
    local identifier = GetPlayerIdentifier(src)
    if not identifier then return end
    
    -- In a full implementation, this would query the database
    -- For now, we store keys in the player's metadata or a separate table
    local Framework = exports['rpa-lib']:GetFramework()
    if Framework then
        local Player = Framework.Functions.GetPlayer(src)
        if Player then
            local metadata = Player.PlayerData.metadata
            if metadata and metadata.vehiclekeys then
                PlayerKeys[identifier] = metadata.vehiclekeys
            else
                PlayerKeys[identifier] = {}
            end
        end
    end
    
    TempKeys[src] = {}
end

-- Save player keys to database
local function SavePlayerKeys(src)
    local identifier = GetPlayerIdentifier(src)
    if not identifier or not PlayerKeys[identifier] then return end
    
    local Framework = exports['rpa-lib']:GetFramework()
    if Framework then
        local Player = Framework.Functions.GetPlayer(src)
        if Player then
            Player.Functions.SetMetaData('vehiclekeys', PlayerKeys[identifier])
        end
    end
end

-- Check if player has keys
local function HasKeys(src, plate)
    local identifier = GetPlayerIdentifier(src)
    plate = string.gsub(plate, '%s+', '') -- Normalize plate
    
    -- Check permanent keys
    if identifier and PlayerKeys[identifier] and PlayerKeys[identifier][plate] then
        return true
    end
    
    -- Check temporary keys
    if TempKeys[src] and TempKeys[src][plate] then
        return true
    end
    
    return false
end

-- Give permanent keys to player
local function GiveKeys(src, plate)
    local identifier = GetPlayerIdentifier(src)
    if not identifier then return false end
    
    plate = string.gsub(plate, '%s+', '')
    
    if not PlayerKeys[identifier] then
        PlayerKeys[identifier] = {}
    end
    
    PlayerKeys[identifier][plate] = true
    SavePlayerKeys(src)
    
    -- Sync to client
    TriggerClientEvent('rpa-vehiclekeys:client:SetOwner', src, plate)
    return true
end

-- Give temporary keys (not persisted)
local function GiveTempKeys(src, plate)
    plate = string.gsub(plate, '%s+', '')
    
    if not TempKeys[src] then
        TempKeys[src] = {}
    end
    
    TempKeys[src][plate] = true
    TriggerClientEvent('rpa-vehiclekeys:client:SetOwner', src, plate)
    return true
end

-- Remove keys from player
local function RemoveKeys(src, plate)
    local identifier = GetPlayerIdentifier(src)
    plate = string.gsub(plate, '%s+', '')
    
    if identifier and PlayerKeys[identifier] then
        PlayerKeys[identifier][plate] = nil
        SavePlayerKeys(src)
    end
    
    if TempKeys[src] then
        TempKeys[src][plate] = nil
    end
    
    TriggerClientEvent('rpa-vehiclekeys:client:RemoveKeys', src, plate)
    return true
end

-- Events
RegisterNetEvent('rpa-vehiclekeys:server:giveKeys', function(plate)
    local src = source
    GiveKeys(src, plate)
end)

RegisterNetEvent('rpa-vehiclekeys:server:giveKeysToPlayer', function(targetId, plate)
    local src = source
    
    -- Verify source has keys
    if not HasKeys(src, plate) then
        exports['rpa-lib']:Notify(src, "You don't have keys for this vehicle", "error")
        return
    end
    
    -- Give temp keys to target
    GiveTempKeys(targetId, plate)
    exports['rpa-lib']:Notify(src, "Keys given", "success")
    exports['rpa-lib']:Notify(targetId, "You received vehicle keys", "success")
end)

RegisterNetEvent('rpa-vehiclekeys:server:checkKeys', function(plate)
    local src = source
    local hasKeys = HasKeys(src, plate)
    TriggerClientEvent('rpa-vehiclekeys:client:keyCheck', src, plate, hasKeys)
end)

-- Player loaded event (QB-Core)
RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    local src = source
    Wait(1000) -- Small delay to ensure player data is ready
    LoadPlayerKeys(src)
end)

-- Cleanup on disconnect
AddEventHandler('playerDropped', function()
    local src = source
    local identifier = GetPlayerIdentifier(src)
    
    -- Save before clearing
    if identifier then
        SavePlayerKeys(src)
    end
    
    TempKeys[src] = nil
end)

-- Exports
exports('GiveKeys', GiveKeys)
exports('GiveTempKeys', GiveTempKeys)
exports('RemoveKeys', RemoveKeys)
exports('HasKeys', HasKeys)
