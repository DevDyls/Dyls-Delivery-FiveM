local deliveryInProgress = false
local currentDeliveryPoint = nil
local deliveryBlip = nil
local spawnedVehicle = nil
local courierSelection = nil
local onDuty = false

-- Import NativeUI and Initialize Properly
local Menu = nil
local _menuPool = NativeUI.CreatePool()

-- Function to Send Notifications Above the Map
function ShowNotification(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(false, true)
end

-- Delivery Locations (Shared for All Couriers)
local deliveryLocations = {
    {x = 1157.0, y = -331.0, z = 68.0}, -- Mirror Park Fuel Station (411)
    {x = 1302.0, y = -528.0, z = 71.0}, -- Nikola Pl, Mirror Park
    {x = 1301.0, y = -573.0, z = 71.0}, -- Nikola Pl, Mirror Park
    {x = 906.0, y = -491.0, z = 59.0}, -- West Mirror Drive, Mirror Park
    {x = 1154.0, y = -776.0, z = 57.0}, -- West Mirror Drive, Mirror Park
    {x = -14.0, y = -1442.0, z = 31.0}, -- Forum Drive, Strawberry
    {x = 85.0, y = -1958.0, z = 21.0}, -- Grove Street, Davis
    {x = 1375.0, y = -586.0, z = 74.0}, -- Nikola Pl, Mirror Park
    {x = 1197.0, y = -3099.0, z = 5.0}, -- LS Ports
    {x = -376.0, y = -1874.0, z = 20.0}, -- Maze Bank Arena
    {x = 1275.0, y = -1721.0, z = 54.0}, -- Armadillo Vista
    {x = 86.0, y = -1390.0, z = 29.0} -- Innocence Boulevard
}

-- Couriers and Vehicles with Liveries
local courierOptions = {
    {
        name = "DPD",
        vehicles = {
            {model = "RUMPO", livery = 4},
            {model = "RUMPO3", livery = 0}
        }
    },
    {
        name = "Waitrose",
        vehicles = {
            {model = "MULE3", livery = 0}
        }
    },
    {
        name = "Amazon Prime",
        vehicles = {
            {model = "POUNDER", livery = 0},
            {model = "PONY", livery = 0}
        }
    },
    {
        name = "Royal Mail",
        vehicles = {
            {model = "PONY2", livery = 0},
            {model = "RUMPO", livery = 3}
        }
    },
    {
        name = "Tesco",
        vehicles = {
            {model = "MULE2", livery = 0},
            {model = "MULE", livery = 0}
        }
    },
    {
        name = "Argos",
        vehicles = {
            {model = "BOXVILLE", livery = 3}
        }
    }
}

-- Create the Menu for Courier Selection
function CreateCourierMenu()
    Menu = NativeUI.CreateMenu("Courier Selection", "Choose Your Delivery Service", 50, 100)
    _menuPool:Add(Menu)

    -- On Duty/Off Duty Toggle Button
    local dutyToggleItem = NativeUI.CreateItem("Toggle Duty Status", "Go On/Off Duty for Deliveries")
    Menu:AddItem(dutyToggleItem)
    dutyToggleItem.Activated = function(sender, item)
        onDuty = not onDuty
        if onDuty then
            ShowNotification("~g~You are now ON DUTY. Deliveries will be assigned automatically.")
        else
            ShowNotification("~r~You are now OFF DUTY.")
        end
    end

    -- Force Delivery Option
    local forceDeliveryItem = NativeUI.CreateItem("Force Delivery", "Force a delivery right now!")
    Menu:AddItem(forceDeliveryItem)
    forceDeliveryItem.Activated = function(sender, item)
        if spawnedVehicle then
            StartRandomDelivery()
            ShowNotification("~y~A delivery has been forced and marked on your map!")
        else
            ShowNotification("~r~You need to spawn a vehicle first!")
        end
    end

    -- Courier Selection and Vehicle Spawning
    for _, courier in ipairs(courierOptions) do
        local courierSubMenu = _menuPool:AddSubMenu(Menu, courier.name, "Select your vehicle and start delivery")

        for _, vehicle in ipairs(courier.vehicles) do
            -- Spawn Vehicle Option
            local spawnVehicleItem = NativeUI.CreateItem("Spawn " .. vehicle.model, "Spawn this delivery vehicle.")
            courierSubMenu:AddItem(spawnVehicleItem)
            spawnVehicleItem.Activated = function(sender, item)
                SpawnCourierVehicle(vehicle.model, vehicle.livery)
            end
        end
    end
end

-- Initialize the Menu When the Resource Starts
CreateCourierMenu()

-- F9 Keybind to Open the Menu
CreateThread(function()
    while true do
        Wait(0)
        _menuPool:ProcessMenus()
        if IsControlJustPressed(0, 56) then -- F9 Key
            Menu:Visible(not Menu:Visible())
        end
    end
end)

-- Function to Spawn a Vehicle with Correct Livery
function SpawnCourierVehicle(vehicleModel, livery)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do Wait(0) end

    -- Delete existing vehicle if any
    if spawnedVehicle then DeleteEntity(spawnedVehicle) end

    -- Spawn the vehicle
    spawnedVehicle = CreateVehicle(GetHashKey(vehicleModel), playerCoords.x + 5, playerCoords.y, playerCoords.z, 0.0, true, false)
    SetPedIntoVehicle(playerPed, spawnedVehicle, -1)

    -- Apply the specified livery
    SetVehicleLivery(spawnedVehicle, livery)
    ShowNotification("~g~Your delivery vehicle with the correct livery has been spawned!")
end

-- Function to Start a Random Delivery
function StartRandomDelivery()
    if deliveryInProgress then
        ShowNotification("~r~You already have an active delivery!")
        return
    end

    deliveryInProgress = true

    -- Select a Random Delivery Point
    local randomIndex = math.random(1, #deliveryLocations)
    currentDeliveryPoint = deliveryLocations[randomIndex]

    -- Set Waypoint and Blip
    SetNewWaypoint(currentDeliveryPoint.x, currentDeliveryPoint.y)

    if deliveryBlip then RemoveBlip(deliveryBlip) end
    deliveryBlip = AddBlipForCoord(currentDeliveryPoint.x, currentDeliveryPoint.y, currentDeliveryPoint.z)
    SetBlipSprite(deliveryBlip, 1)
    SetBlipColour(deliveryBlip, 2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Delivery Location")
    EndTextCommandSetBlipName(deliveryBlip)

    ShowNotification("~g~A new delivery has been assigned!")
end

-- Monitor Delivery Completion with Money Reward Notification
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
                    ShowNotification("~g~Delivery completed! You earned £" .. math.random(200, 500) .. "!")
                    deliveryInProgress = false
                    currentDeliveryPoint = nil
                    if deliveryBlip then RemoveBlip(deliveryBlip) end
                end
            end
        end
    end
end)

-- Automatic Deliveries Every Few Minutes (Auto-Start Only If On Duty)
CreateThread(function()
    while true do
        Wait(5000) -- 5 minutes (300,000ms) 5 seconds for dev testing
        if onDuty and spawnedVehicle and not deliveryInProgress then
            StartRandomDelivery()
            ShowNotification("~y~A new delivery has been automatically assigned!")
        end
    end
end)
