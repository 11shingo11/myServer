local engineState = false
local lightState = false

function setVehicleIdleState()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    toggleControl("vehicle_look_right", false)
    if not engineState then
        setVehicleEngineState(vehicle, engineState)
    end
    if not lightState then
        setVehicleOverrideLights(vehicle, 1)
    end
end
addEventHandler("onClientVehicleEnter", getRootElement(), setVehicleIdleState)

function toggleEngine(key, keyState)
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if not engineState then
        setVehicleEngineState(vehicle, true)
        engineState = true
    end
end

function toggleLights(key, keyState)
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if not lightState then
        setVehicleOverrideLights(vehicle, 2)
        lightState = true
    else
       
        setVehicleOverrideLights(vehicle, 1)
        lightState = false
    end
end

function vehicleJump(key, keyState)
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if isVehicleOnGround(vehicle) then
        local x, y, z = getElementPosition(vehicle)
        setElementPosition(vehicle, x, y, z + 1)
    end
end

function bindTheKeys(thePlayer)
    if thePlayer == localPlayer then
        outputChatBox("bind")
        bindKey("e", "down", toggleEngine)
        bindKey("l", "down", toggleLights)
        bindKey("lshift", "down", vehicleJump)
    end
end

function unbindTheKeys(thePlayer)
    if thePlayer == localPlayer then
        outputChatBox("unbind")
        bindKey("e", "down", toggleEngine)
        bindKey("l", "down", toggleLights)
        bindKey("lshift", "down", vehicleJump)
    end
end

addEventHandler("onClientVehicleEnter", root, bindTheKeys)
addEventHandler("onClientVehicleExit", root, unbindTheKeys)