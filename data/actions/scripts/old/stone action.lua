local stoneIds = {12686, 12688, 12689, 12687}
local effByVoc = {28, 28, 28, 28}
function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	local vocId = getPlayerVocation(cid)
	if stoneIds[vocId] ~= item.itemid then 
		sendBlueMessage(cid, "Você não pode utilizar stone de outro elemento.")
		return true
	end 
	if getDobrasLevel(cid) >= 23 then 
		sendBlueMessage(cid, "Você já aprimorou sua última dobra.")
		return true
	end 
	local needLevel = getLevelForNextUpgrade(getDobrasLevel(cid)+1)
	if getPlayerLevel(cid) < needLevel then 
		sendBlueMessage(cid, "Você precisa alcançar o nível "..needLevel.." para aprimorar sua próxima dobra.")
		return true
	end 
	local needStones = getStonesForNextUpgrade(cid)
	if item.type < needStones then 
		sendBlueMessage(cid, "Você precisa juntar "..needStones.." stones para aprimorar sua próxima dobra.")
		return true
	end 
	local oldStage = getDobrasLevel(cid)
	addDobrasLevel(cid)
	sendBlueMessage(cid, getMessageFromUpgrade(vocId, oldStage+1))
	doRemoveItem(item.uid, needStones)
	doSendMagicEffect(getThingPos(cid), effByVoc[vocId])
	return true
end