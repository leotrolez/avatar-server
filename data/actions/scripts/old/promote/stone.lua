local function checkBossAlive()
local specs = getSpectators({x=1161, y=726, z=10}, 15, 15)
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isMonster(specs[i]) and getCreatureName(specs[i]) == "Gaz'Haragoth" then 
				return true
			end 
		end 
	end 
	return false
end 

local stoneVoc = {12686, 12688, 12689, 12687} -- fire, water, air, earth
function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if checkBossAlive() then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você precisa derrotar o Gaz'Haragoth primeiro.")
		return true
	end
	local pedra = getTileItemById(toPosition, stoneVoc[getPlayerVocation(cid)]).uid
	if pedra <= 0 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "Choose the stone of your element.", "Escolha a pedra de seu elemento."))
		return true
	end	

	doTeleportThing(cid,  {x = 1117, y = 640, z = 9})
	doSendMagicEffect({x = 1117, y = 640, z = 9}, CONST_ME_TELEPORT)
	if getPlayerStorageValue(cid, "isPromoted") ~= 1 and getPlayerStorageValue(cid, "canPromote") ~= 1 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "Report the mission to your Mentor.", "Reporte esta missão para o seu Mentor."))
		setPlayerStorageValue(cid, "canPromote", 1)
		doPlayerAddItem(cid, 2160, 30)
		doSendMagicEffect(getThingPos(cid), 29)
	
		local finalExp = getExperienceForLevel(201) - getExperienceForLevel(200)
		finalExp = finalExp/2
		doPlayerAddExperience(cid, finalExp)
		doSendAnimatedText(getCreaturePosition(cid), finalExp, 215)
	end
	
  return true
end