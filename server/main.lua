QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("masterkey", function(source, item) TriggerClientEvent('masterkey:client:masterkey', source)
end)

RegisterNetEvent('masterkey:server:masterkey', function(player, veh)
    local src = source
    TriggerClientEvent("masterkey:client:breaklocks", source)
end)