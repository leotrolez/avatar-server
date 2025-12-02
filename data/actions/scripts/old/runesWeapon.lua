local runeList = {
	[18121] = {runeType = 11, runeLevel = 1},
	[18122] = {runeType = 11, runeLevel = 2},
	[18124] = {runeType = 12, runeLevel = 1},
	[18125] = {runeType = 12, runeLevel = 2},
	[18127] = {runeType = 13, runeLevel = 1},
	[18128] = {runeType = 13, runeLevel = 2},
}

local function isEquipped(cid, uid)
	local possibleSlots = {5, 6}
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

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	local newRuneType = runeList[item.itemid].runeType
	local newRuneLevel = runeList[item.itemid].runeLevel
	if item.uid == 0 or item.itemid == 0 then 
		return false 
	end
	if isCreature(itemEx.uid) then
		return false
	end
	if newRuneLevel == 1 and getPlayerLevel(cid) < 90 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "É necessário Level 90+ para utilizar esta runa em alguma arma.")
		return true
	end
	if newRuneLevel == 2 and getPlayerLevel(cid) < 180 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "É necessário Level 180+ para utilizar esta runa em alguma arma.")
		return true
	end
	if toPosition.x ~= CONTAINER_POSITION then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "The item need to be in a container to be enchanted.", "O item precisa estar em um inventário para ser encantado."))
		return true
	end
	if isEquipped(cid, itemEx.uid) then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "The item need to be unequipped to be enchanted.", "O item precisa estar desequipado para ser encantado."))
		return true
	end
	local itemType = ItemType(itemEx.itemid)
	if not itemType:isWeapon() or itemEx.itemid == 0 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "This rune only enchant weapons.", "Esta runa apenas encanta armas."))
		return true
	end
	local legendarys = {17860, 17861, 17862, 17863}
	if isInArray(legendarys, itemEx.itemid) then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "This legendary weapon already have its own enchantment.", "Esta arma lendária já possui seu próprio encantamento."))
		return true
	end
	if itemType:isStackable() then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "You cant enchant ammo.", "Você não pode encantar munições."))
		return true
	end
	if getItemAttribute(itemEx.uid, 'elementalrunecharges') and getItemAttribute(itemEx.uid, 'elementalrunecharges') >= 1 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "This weapon is already enchanted.", "Esta arma já está encantada."))
		return true
	end
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "The weapon has successfully enchanted!", "A arma foi encantada com sucesso!"))
	doSendMagicEffect(getThingPos(cid), 28, cid)
	doItemSetAttribute(itemEx.uid,'elementalrunetype', newRuneType) 
	doItemSetAttribute(itemEx.uid,'elementalrunelevel', newRuneLevel)
	doItemSetAttribute(itemEx.uid,'elementalrunecharges', 500)
	doRemoveItem(item.uid, 1)
	return true
end