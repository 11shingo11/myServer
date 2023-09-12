local spawnX, spawnY, spawnZ = 1959.55, -1714.46, 17
function joinHandler()
	spawnPlayer(source, spawnX, spawnY, spawnZ)
	fadeCamera(source, true)
	setCameraTarget(source, source)
end
addEventHandler("onPlayerJoin", getRootElement(), joinHandler)

