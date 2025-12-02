local config = {
	timeToRemove = 179 , -- seconds
	message = "Agora você tem 3 minutos para sair desta sala. O teletransporte irá te levar para outra sala durante esse tempo, após esse tempo ele desaparecerá.",
	teleportId = 1387,
	bosses = { -- Monster Name,  Teleport Position
		["Ushuriel"] = {  pos={ x=754, y=1283, z=9 }, aid=2006, stor=100079, value=3},
		["Zugurosh"] = {  pos={ x=808, y=1534, z=9 }, aid=2007, stor=100079, value=6},
		["Madareth"] = {  pos={ x=891, y=1536, z=12 }, aid=2008, stor=100078, value=25},
		["Golgordan"] = { pos={ x=1149, y=1533, z=12 }, aid=2009, brother = "Latrivan", stor=100078, value=28},
		["Latrivan"] = { pos={ x=1149, y=1533, z=12 }, aid=2009, brother = "Golgordan", stor=100078, value=28},
		["Annihilon"] = {  pos={ x=1249, y=1724, z=12 }, aid=2010, stor=100078, value=32},
		["Hellgorak"] = {  pos={ x=1376, y=1667, z=9 }, aid=2011, stor=100078, value=35},
	},
}
local function removal(position)
	position.stackpos = 1
	if getThingfromPos(position).itemid == config.teleportId then
		doRemoveItem(getThingfromPos(position).uid)
	end
	return TRUE
end

function onKill(creature, target)
	local cid = creature.uid
    if(isMonster(target)) then
		local t = config.bosses[getCreatureName(target)]
		if t == nil then
			return true
		end
		if t.brother then
			for x = 1141, 1157 do
				for y = 1527, 1539 do
					local v = getTopCreature({x=x, y=y, z=12})
					if v.type == 2 and getCreatureName(v.uid) == t.brother then
						return true
					end
				end
			end
		end
		if (getPlayerStorageValue(cid, t.stor) < t.value) then
		setPlayerStorageValue(cid, t.stor, t.value)
        end
		doItemSetAttribute(doCreateItem(config.teleportId, t.pos), "aid", t.aid)
		doCreatureSay(cid, config.message, TALKTYPE_ORANGE_1)
		addEvent(removal, config.timeToRemove * 1000, t.pos)
	end
	return true
end