local deliveryInProgress = false
local currentDeliveryPoint = nil
local deliveryBlip = nil

local deliveryLocations = {
    {x = 1157.0, y = -331.0, z = 68.0}, -- 411, Fuel Station, Westminster
    {x = 1375.0, y = -586.0, z = 74.0}, -- 444, Nikola Pl, Westminster
    {x = 1197.0, y = -3099.0, z = 5.0}, -- 18, London Gateway Ports
    {x = -376.0, y = -1874.0, z = 20.0}, -- 88, Maze Bank Arena, Wembely
    {x = 1275.0, y = -1721.0, z = 54.0}, -- 184, Armadillo Vista, Isle of Dogs
    {x = 86.0, y = -1390.0, z = 29.0}, -- 134, Innocence Boulevard, Wembely
    -- Add more locations as needed just copy and paste {x = 0, y = 0, z = 0}
}

local allowedVehicles = {
    "RUMPO3", -- Ford DPD Van
    "MULE3", -- MAN Waitrose Lorry
    "RUMPO", -- Ford Transit Custom
    "POUNDER", -- Amazon Prime Lorry
    "PONY2", -- Ford Royal Mail Van
    "PONY", -- Ford Amazon Prime Van
    "MULE", -- Iveco Tesco Van
    "MULE2", -- MAN Tesco Lorry
    "BOXVILLE" -- Argos Van
}

-- Function to check if the player's vehicle is allowed
local function isVehicleAllowed(vehicle)
    local vehicleModel = GetEntityModel(vehicle)
    for _, allowedModel in ipairs(allowedVehicles) do
        if vehicleModel == GetHashKey(allowedModel) then
            return true
        end
    end
    return false
end

-- Function to list allowed vehicles in chat
local function listAllowedVehicles()
    local vehiclesList = ""
    for _, vehicle in ipairs(allowedVehicles) do
        vehiclesList = vehiclesList .. vehicle .. ", "
    end
    vehiclesList = vehiclesList:sub(1, -3) -- Remove the trailing comma and space
    TriggerEvent('chat:addMessage', {args = {"^3Allowed Vehicles: ^7" .. vehiclesList}})
end

RegisterCommand('deliverystart', function()
    if deliveryInProgress then
        TriggerEvent('chat:addMessage', {args = {"^1You already have an active delivery!"}})
        return
    end

    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle == 0 then
        TriggerEvent('chat:addMessage', {args = {"^1You must be in a vehicle to start a delivery!"}})
        listAllowedVehicles()
        return
    end

    if not isVehicleAllowed(vehicle) then
        TriggerEvent('chat:addMessage', {args = {"^1Please be in the correct vehicle before starting a delivery!"}})
        listAllowedVehicles()
        return
    end

    local randomIndex = math.random(1, #deliveryLocations)
    currentDeliveryPoint = deliveryLocations[randomIndex]

    -- Set waypoint on the map
    SetNewWaypoint(currentDeliveryPoint.x, currentDeliveryPoint.y)

    if deliveryBlip then
        RemoveBlip(deliveryBlip)
    end

    deliveryBlip = AddBlipForCoord(currentDeliveryPoint.x, currentDeliveryPoint.y, currentDeliveryPoint.z)
    SetBlipSprite(deliveryBlip, 1)
    SetBlipDisplay(deliveryBlip, 4)
    SetBlipScale(deliveryBlip, 1.0)
    SetBlipColour(deliveryBlip, 2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Delivery Location")
    EndTextCommandSetBlipName(deliveryBlip)

    TriggerEvent('chat:addMessage', {args = {"^2Delivery started! Drive to the marked location."}})
    deliveryInProgress = true
end)

CreateThread(function()
    while true do
        Wait(0)
        if deliveryInProgress and currentDeliveryPoint then
            local playerPed = PlayerPedId()
            local playerPos = GetEntityCoords(playerPed)

            local distance = #(playerPos - vector3(currentDeliveryPoint.x, currentDeliveryPoint.y, currentDeliveryPoint.z))
            if distance < 10.0 then
                DrawMarker(1, currentDeliveryPoint.x, currentDeliveryPoint.y, currentDeliveryPoint.z - 1.0, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 1.0, 0, 255, 0, 100, false, true, 2, false, nil, nil, false)

                if distance < 3.0 then
                    TriggerServerEvent('delivery:complete')
                    TriggerEvent('chat:addMessage', {args = {"^2Delivery completed successfully!"}})

                    deliveryInProgress = false
                    currentDeliveryPoint = nil

                    if deliveryBlip then
                        RemoveBlip(deliveryBlip)
                        deliveryBlip = nil
                    end
                end
            end
        end
    end
end)
