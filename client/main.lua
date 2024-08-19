local QBCore = exports['qb-core']:GetCoreObject()
local cooldownTimer = 0

RegisterNetEvent('masterkey:client:masterkey', function()
local player = QBCore.Functions.GetPlayerData()
local ped = PlayerPedId()
local veh = QBCore.Functions.GetClosestVehicle()

if not veh or #(GetEntityCoords(ped) - GetEntityCoords(veh)) > Config.VehicleProximity then
QBCore.Functions.Notify(Config.Notifications.NoVehicle, "error")
return
end

local plate = GetVehicleNumberPlateText(veh)
local isAllowed = false

for i = 1, #Config.AllowedJobs do
if player.job.name == Config.AllowedJobs[i] and player.job.onduty then
isAllowed = true
break
end
end

if not isAllowed then
QBCore.Functions.Notify(Config.Notifications.Unauthorized, "error")
return
end

if Config.Cooldown.Enabled and cooldownTimer > GetGameTimer() then
QBCore.Functions.Notify("You must wait before using the masterkey again", "error")
return
end

if Config.RequireKeyItem then
local hasItem = QBCore.Functions.HasItem(Config.KeyItemName)
if not hasItem then
QBCore.Functions.Notify("You don't have a master key", "error")
return
end
end

-- Check if player already has the key
QBCore.Functions.TriggerCallback('qb-vehiclekeys:server:CheckHasKey', function(hasKey)
if hasKey then
QBCore.Functions.Notify(Config.Notifications.AlreadyHaveKey, "error")
return
end

-- Continue with the masterkey process if they don't have the key
UseMasterkey(ped, veh, plate)
end, plate)
end)

function UseMasterkey(ped, veh, plate)
    if not Config.WorkOnLockedVehicles and GetVehicleDoorLockStatus(veh) ~= 1 then
    QBCore.Functions.Notify("This vehicle is locked and cannot be unlocked with the masterkey", "error")
    return
    end
    
    local animToUse = math.random() > 0.5 and Config.Animation or Config.AlternativeAnimation

    RequestAnimDict(animToUse.Dict)
    while not HasAnimDictLoaded(animToUse.Dict) do
    Wait(10)
    end
    
    TaskPlayAnim(ped, animToUse.Dict, animToUse.Name, 8.0, -8.0, -1, 1, 0, false, false, false)
    
    if Config.UseSound then
    PlaySoundFrontend(-1, Config.UseSound.Name, "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end
    
    QBCore.Functions.Progressbar("using_masterkey", Config.Progressbar.Label, Config.Progressbar.Duration, false, true, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = false,
    disableCombat = true,
    }, {}, {}, {}, function() -- Done
    StopAnimTask(ped, Config.Animation.Dict, Config.Animation.Name, 1.0)
    TriggerServerEvent(Config.AcquireKeysEventName, plate)
    QBCore.Functions.Notify("You received keys for vehicle: " .. plate, "success") -- Modified notification
    print("Key acquired for plate: " .. plate) -- Debug log
    
    if Config.Cooldown.Enabled then
    cooldownTimer = GetGameTimer() + Config.Cooldown.Duration
    end
    
    if Config.RemoveKeyItemAfterUse and Config.RequireKeyItem then
    TriggerServerEvent('QBCore:Server:RemoveItem', Config.KeyItemName, 1)
    end
    
    if Config.BreakChance > 0 and math.random() < Config.BreakChance then
    QBCore.Functions.Notify("Your masterkey broke!", "error")
    TriggerServerEvent('QBCore:Server:RemoveItem', Config.KeyItemName, 1)
    end
    
    end, function() -- Cancel
    StopAnimTask(ped, Config.Animation.Dict, Config.Animation.Name, 1.0)
    QBCore.Functions.Notify(Config.Notifications.Cancelled, "error")
    end)
    
    if Config.Debug then
    print("Masterkey used on vehicle with plate: " .. plate)
    end
    end