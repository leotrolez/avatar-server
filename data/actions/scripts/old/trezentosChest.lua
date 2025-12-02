local bosses = {"Tyrn", "Moohtant", "Demodras", "Lava Golem"}

local function checkBossAlive()
local specs = getSpectators({x=1212, y=1053, z=7}, 15, 15)
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isMonster(specs[i]) and isInArray(bosses, getCreatureName(specs[i])) then 
				return true
			end 
		end 
	end 
	return false
end 

local armasId = {13429, 17865, 12798, 13651}
local function getItemBySkill(cid)
	local skillId = 1
	local bestNumber = getPlayerSkillLevel(cid, 1)
	for i = 2, 4 do
		local candidato = getPlayerSkillLevel(cid, i)
		if candidato > bestNumber then
			bestNumber = candidato
			skillId = i
		end
	end 
	return armasId[skillId]
end

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if checkBossAlive() then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você precisa derrotar os 4 bosses presentes na sala.")
		return true
	elseif getPlayerStorageValue(cid, "90520") == 1 then 	
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já pegou esta recompensa.")
	else	
		local theItem = getItemBySkill(cid)
		setPlayerStorageValue(cid, "90520", 1)
		doPlayerAddItem(cid, theItem, 1)
		doSendMagicEffect(getThingPos(cid), 29)
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Você conquistou o "..getItemNameById(theItem)..".")
	end 
		doTeleportThing(cid, {x=1138, y=1047, z=7})
		doSendMagicEffect({x=1138, y=1047, z=7}, CONST_ME_TELEPORT)
    return true
end