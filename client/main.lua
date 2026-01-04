local Keys = {}

local function HasKeys(plate)
    return Keys[plate] == true
end

local function GiveKeys(plate)
    Keys[plate] = true
    exports['rpa-lib']:Notify("You received keys for plate: " .. plate, "success")
end

local function RemoveKeys(plate)
    Keys[plate] = nil
end

local function ToggleLock()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh == 0 then
        -- Check closest vehicle
        local coords = GetEntityCoords(ped)
        veh = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    end
    
    if veh ~= 0 then
        local plate = GetVehicleNumberPlateText(veh)
        if HasKeys(plate) then
            -- Initial lock status (1 = unlocked, 2 = locked)
            local status = GetVehicleDoorLockStatus(veh)
            if status == 1 then
                SetVehicleDoorsLocked(veh, 2)
                PlayVehicleDoorCloseSound(veh, 1)
                exports['rpa-lib']:Notify("Vehicle Locked", "error")
                -- Add animation / lights flash
                SetVehicleLights(veh, 2)
                Wait(200)
                SetVehicleLights(veh, 0)
                Wait(200)
                SetVehicleLights(veh, 2)
                Wait(200)
                SetVehicleLights(veh, 0)
            else
                SetVehicleDoorsLocked(veh, 1)
                PlayVehicleDoorOpenSound(veh, 0)
                exports['rpa-lib']:Notify("Vehicle Unlocked", "success")
                -- Add animation / lights flash
                SetVehicleLights(veh, 2)
                Wait(200)
                SetVehicleLights(veh, 0)
            end
        else
            exports['rpa-lib']:Notify("You don't have keys for this vehicle", "error")
        end
    end
end

local function ToggleEngine()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= 0 then
        local plate = GetVehicleNumberPlateText(veh)
        if HasKeys(plate) then
            local engine = GetIsVehicleEngineRunning(veh)
            SetVehicleEngineOn(veh, not engine, false, true)
            if not engine then
                exports['rpa-lib']:Notify("Engine Started", "success")
            else
                exports['rpa-lib']:Notify("Engine Stopped", "error")
            end
        else
            exports['rpa-lib']:Notify("No keys", "error")
            SetVehicleEngineOn(veh, false, false, true)
        end
    end
end

-- Keybinds
RegisterCommand('+toggleLock', ToggleLock, false)
RegisterKeyMapping('+toggleLock', 'Toggle Vehicle Lock', 'keyboard', 'L')

RegisterCommand('engine', ToggleEngine, false)
-- You might want to map engine too, e.g. Y or G? keeping command for now

-- Exports
exports('GiveKeys', GiveKeys)
exports('HasKeys', HasKeys)
exports('RemoveKeys', RemoveKeys)

-- Events from Server
RegisterNetEvent('rpa-vehiclekeys:client:SetOwner', function(plate)
    GiveKeys(plate)
end)

RegisterNetEvent('rpa-vehiclekeys:client:RemoveKeys', function(plate)
    RemoveKeys(plate)
end)

RegisterNetEvent('rpa-vehiclekeys:client:keyCheck', function(plate, hasKeys)
    if hasKeys then
        GiveKeys(plate)
    end
end)

-- Request keys from server on spawn (for owned vehicles)
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    -- Keys will be synced via server events when needed
end)

-- Give keys command (for testing and RP scenarios)
RegisterCommand('givekeys', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local closestPlayer, closestDistance = nil, 3.0
    
    -- Find closest player
    for _, playerId in ipairs(GetActivePlayers()) do
        if playerId ~= PlayerId() then
            local targetPed = GetPlayerPed(playerId)
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(coords - targetCoords)
            
            if distance < closestDistance then
                closestPlayer = GetPlayerServerId(playerId)
                closestDistance = distance
            end
        end
    end
    
    if not closestPlayer then
        exports['rpa-lib']:Notify("No player nearby", "error")
        return
    end
    
    -- Get closest vehicle or current vehicle
    local veh = GetVehiclePedIsIn(ped, true)
    if veh == 0 then
        veh = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    end
    
    if veh ~= 0 then
        local plate = GetVehicleNumberPlateText(veh)
        TriggerServerEvent('rpa-vehiclekeys:server:giveKeysToPlayer', closestPlayer, plate)
    else
        exports['rpa-lib']:Notify("No vehicle nearby", "error")
    end
end, false)

-- Prevent hotwiring if no keys (Simple enforcement loop)
CreateThread(function()
    while true do
        Wait(500)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then
            local veh = GetVehiclePedIsIn(ped, false)
            if GetPedInVehicleSeat(veh, -1) == ped then
                local plate = GetVehicleNumberPlateText(veh)
                if not HasKeys(plate) and GetIsVehicleEngineRunning(veh) then
                     -- Allow for hotwiring minigame later?
                     -- For now, just shut off engine if trying to drive without keys (unless NPC car stealing logic separate)
                     -- Actually, better to just not allow start. 
                     SetVehicleEngineOn(veh, false, false, true)
                end
            end
        end
    end
end)
