local frases = {""}

local function checkZuko()
local specs = getSpectators({x=1117, y=1209, z=7}, 30, 30)
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isMonster(specs[i]) then 
				doRemoveCreature(specs[i])
			end 
		end 
	end 
end 

local function checkPlayer()
local specs = getSpectators({x=1117, y=1209, z=7}, 30, 30)
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isPlayer(specs[i]) and getPlayerGroupId(specs[i]) <= 2 then 
				return true
			end 
		end 
	end 
	return false
end 

function onStepIn(cid, item, position, fromPosition)
	if isPlayerPzLocked(cid) then
		doTeleportThing(cid, fromPosition, false)
      	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You cant pass with battle locked.")
		return false
	end
	if getPlayerLevel(cid) < 150 or getPlayerResets(cid) < 70 then
		doTeleportThing(cid, fromPosition, false)
		doCreatureSay(cid, "Você precisa de Level 150+ e Paragon 70+ para entrar na Evil Zuko Quest.", TALKTYPE_ORANGE_1, false, cid)
		return false
	elseif getPlayerStorageValue(cid, "90509") == 1 then 
		doTeleportThing(cid, fromPosition, false)
		doCreatureSay(cid, "Você já completou esta quest.", TALKTYPE_ORANGE_1, false, cid)
		return false
	elseif checkPlayer() then 
		doTeleportThing(cid, fromPosition, false)
		doCreatureSay(cid, "Alguém já está dentro da sala no momento.", TALKTYPE_ORANGE_1, false, cid)
		return false
	else 
		checkZuko()
		doCreateMonster("Evil Zuko", {x=1116, y=1205, z=7})
		doSendMagicEffect(position, CONST_ME_TELEPORT)
		doTeleportThing(cid, {x=1109, y=1209, z=7})
		doSendMagicEffect({x=1109, y=1209, z=7}, CONST_ME_TELEPORT)
		
	end 
	return true
end