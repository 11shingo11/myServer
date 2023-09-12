local playerVehicles = {}
local vehicleIsCreated = false


function createVehicleForPlayer(thePlayer, command, vehicleModel)
    local x, y, z = getElementPosition(thePlayer)
    x = x - 5
    for vehicle, owner in pairs(playerVehicles) do
        if owner == thePlayer and vehicleIsCreated then
            destroyElement(vehicle)
        end
    end

    createdVehicle = createVehicle(tonumber(vehicleModel), x, y, z)

    playerVehicles[createdVehicle] = thePlayer
    vehicleIsCreated = true

    outputChatBox("Вы создали транспортное средство (ID: " .. getElementModel(createdVehicle) .. ")", thePlayer)
end
addCommandHandler("/veh", createVehicleForPlayer)

function checkVehicleCreator(player, seat, jacked)
    local playerVehicle  = getPedOccupiedVehicle(player)
    local isOwner = false

    for vehicle, owner in pairs(playerVehicles) do
        if owner == player and vehicle == playerVehicle  then
            isOwner = true
            break
        end
    end

    if not isOwner then
        cancelEvent()
        outputChatBox("Вы не можете садиться в это транспортное средство, так как вы не являетесь владельцем ни одной из ваших машин.", player, 255, 0, 0)
    end
end
addEventHandler("onVehicleStartEnter", root, checkVehicleCreator)


function removeFromPlayerVehicles(vehicle)
    for v, owner in pairs(playerVehicles) do
        if v == vehicle then
            playerVehicles[v] = nil
            break 
        end
    end
end


function destroyVehicleAfterPlayerLogout()
    local player = source
    for vehicle, owner in pairs(playerVehicles) do
        if owner == player then
            destroyElement(vehicle)
            playerVehicles[vehicle] = nil
        end
    end
end
addEventHandler("onPlayerQuit", root, destroyVehicleAfterPlayerLogout)
