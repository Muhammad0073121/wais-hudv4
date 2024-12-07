QBCore = exports['qb-core']:GetCoreObject()
CreateThread(function()
    while true do
        local totalPlayer = #GetPlayers()
        local maxPlayers = GetConvarInt('sv_maxclients', 128)
        TriggerClientEvent('wais:totalPlayers', -1, totalPlayer, maxPlayers)
        Wait(Config.RefreshPlayersCountTime)
    end
end)

RegisterNetEvent('wais:getTotalPlayers', function()
    local src = source
    local totalPlayer = #GetPlayers()
    local maxPlayers = GetConvarInt('sv_maxclients', 128)
    TriggerClientEvent('wais:totalPlayers', src, totalPlayer, maxPlayers)
end)



-- qb-robbery/server.lua
local robberyStatus = false -- Initial robbery status

-- Event to get the robbery status when a player loads in
QBCore.Functions.CreateCallback('qb-robbery:getRobberyStatus', function(source, cb)
    cb(robberyStatus)
end)

-- Command to toggle robbery status
RegisterCommand('toggleRobbery', function(source, args, rawCommand)
    local src = source
    if QBCore.Functions.GetPlayer(src).PlayerData.job.type == 'leo' then  -- Optional: Add permissions
        robberyStatus = not robberyStatus
        TriggerClientEvent('qb-robbery:statusChanged', -1, robberyStatus) -- Broadcast to all clients
        TriggerClientEvent('QBCore:Notify', src, 'Robbery status updated: ' .. tostring(robberyStatus), 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have permission to use this command.', 'error')
    end
end, false)
