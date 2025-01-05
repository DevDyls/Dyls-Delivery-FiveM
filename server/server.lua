RegisterNetEvent('delivery:complete')
AddEventHandler('delivery:complete', function()
    local source = source
    local reward = math.random(200, 500)


    TriggerClientEvent('chat:addMessage', source, {args = {"^2You received $" .. reward .. " for completing the delivery!"}})
end)
