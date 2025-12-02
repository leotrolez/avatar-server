local function isArmor(item)
    local slotPos = getItemInfo(item.itemid).wieldPosition
	local possibleSlots = {1, 4, 7, 8}
	if not isInArray(possibleSlots, slotPos) then
		return false
	end
    return true
end

local function isEquipped(cid, uid)
	local possibleSlots = {1, 4, 7, 8}
	for i = 1, #possibleSlots do
		local slotItem = getPlayerSlotItem(cid, possibleSlots[i])
		if slotItem and slotItem.itemid ~= 0 and slotItem.uid ~= 0 then
			if slotItem.uid == uid then
				return true
			end
		end
	end
	return false
end

-- runeType runeLevel
local runeList = {
["11"] = 18099,
["21"] = 18100,
["31"] = 18101,
["41"] = 18102,
["12"] = 18104,
["22"] = 18105,
["32"] = 18106,
["42"] = 18107,
["13"] = 18109,
["23"] = 18110,
["33"] = 18111,
["43"] = 18112,
["14"] = 18130,
["24"] = 18131,
["34"] = 18132,
["44"] = 18133,
}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if item.uid == 0 or item.itemid == 0 then 
		return false 
	end
	if isCreature(itemEx.uid) then
		return false
	end
	if itemEx.itemid == 0 or itemEx.type > 1 or itemEx.uid == 0 then
		return false
	end
	if not isArmor(itemEx) then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "You can't desenchant this item. Only helmets, armors, legs and boots.", "Você não pode desencantar este item. Apenas helmets, armors, legs e boots."))
		return true
	end
	if not getItemAttribute(itemEx.uid, 'elementalrunetype') or getItemAttribute(itemEx.uid, 'elementalrunetype') <= 0 or not getItemAttribute(itemEx.uid, 'elementalrunelevel') or getItemAttribute(itemEx.uid, 'elementalrunelevel') <= 0 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "This item is not enchanted.", "Este item não está encantado."))
		return true
	end
	if toPosition.x ~= CONTAINER_POSITION then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "The item need to be in a container to be disenchanted.", "O item precisa estar em um inventário para ser desencantado."))
		return true
	end
	if not isItemEventRegistered(itemEx.uid) then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "This item is too weak to be disenchanted.", "Este item é fraco demais para ser desencantado."))
		return true
	end
	if isEquipped(cid, itemEx.uid) then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "The item need to be unequipped to be enchanted.", "O item precisa estar desequipado para ser desencantado."))
		return true
	end
	if item.itemid == 18115 then
		local itemToReturn = runeList[""..getItemAttribute(itemEx.uid, 'elementalrunetype')..""..getItemAttribute(itemEx.uid, 'elementalrunelevel')..""]
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "The item has been disenchanted and the rune has been returned!", "O item foi desencantado e a runa foi devolvida!"))
		doPlayerAddItem(cid, itemToReturn, 1)
	else
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "The item has been disenchanted!", "O item foi desencantado!"))
	end
	doItemSetAttribute(itemEx.uid,'elementalrunetype', 0) doItemSetAttribute(itemEx.uid,'elementalrunelevel', 0)
	doSendMagicEffect(getThingPos(cid), CONST_ME_POFF, cid)
	doRemoveItem(item.uid, 1)
	return true
end