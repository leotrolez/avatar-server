local runeList = {
[18099] = {runeType = 1, runeLevel = 1},
[18100] = {runeType = 2, runeLevel = 1},
[18101] = {runeType = 3, runeLevel = 1},
[18102] = {runeType = 4, runeLevel = 1},
[18104] = {runeType = 1, runeLevel = 2},
[18105] = {runeType = 2, runeLevel = 2},
[18106] = {runeType = 3, runeLevel = 2},
[18107] = {runeType = 4, runeLevel = 2},
[18109] = {runeType = 1, runeLevel = 3},
[18110] = {runeType = 2, runeLevel = 3},
[18111] = {runeType = 3, runeLevel = 3},
[18112] = {runeType = 4, runeLevel = 3},
[18130] = {runeType = 1, runeLevel = 4},
[18131] = {runeType = 2, runeLevel = 4},
[18132] = {runeType = 3, runeLevel = 4},
[18133] = {runeType = 4, runeLevel = 4},
}

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

-- rune I, II, III, IV
local failRates = {20, 40, 60, 80}
-- rune Types
local effectByElement = {28, 28, 28, 28}

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
	if newRuneLevel == 1 and getPlayerLevel(cid) < 40 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "É necessário Level 40+ para utilizar esta runa em algum equipamento.")
		return true
	end
	if newRuneLevel == 2 and getPlayerLevel(cid) < 100 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "É necessário Level 100+ para utilizar esta runa em algum equipamento.")
		return true
	end
	if newRuneLevel == 3 and getPlayerLevel(cid) < 160 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "É necessário Level 160+ para utilizar esta runa em algum equipamento.")
		return true
	end
	if newRuneLevel == 4 and getPlayerLevel(cid) < 220 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "É necessário Level 220+ para utilizar esta runa em algum equipamento.")
		return true
	end
	local itemType = ItemType(itemEx.itemid)
	if not itemType:isEquipment() or itemEx.itemid == 0 or itemEx.type > 1 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "You can't enchant this item. Only helmets, armors, legs and boots.", "Você não pode encantar este item. Apenas helmets, armors, legs e boots."))
		return true
	end
	if toPosition.x ~= CONTAINER_POSITION then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "The item need to be in a container to be enchanted.", "O item precisa estar em um inventário para ser encantado."))
		return true
	end
	if not itemEx:hasEquipEvent() then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "This item is too weak to be enchanted.", "Este item é fraco demais para ser encantado."))
		return true
	end
	if isEquipped(cid, itemEx.uid) then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "The item need to be unequipped to be enchanted.", "O item precisa estar desequipado para ser encantado."))
		return true
	end
	if getItemAttribute(itemEx.uid, 'elementalrunetype') and getItemAttribute(itemEx.uid, 'elementalrunetype') >= 1 and getItemAttribute(itemEx.uid, 'elementalrunelevel') and getItemAttribute(itemEx.uid, 'elementalrunelevel') >= 1 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "This item is already enchanted. Use the Rune Remover first.", "Este item já está encantado. Utilize a Rune Remover primeiro."))
		return true
	end
	if math.random(1, 100) <= failRates[newRuneLevel] then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "The enchantment failed.", "O encantamento falhou."))
		doSendMagicEffect(getThingPos(cid), CONST_ME_POFF, cid)
		doRemoveItem(item.uid, 1)
		return true
	end
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "The item has successfully enchanted!", "O item foi encantado com sucesso!"))
	doSendMagicEffect(getThingPos(cid), effectByElement[newRuneType], cid)
	doItemSetAttribute(itemEx.uid,'elementalrunetype', newRuneType) doItemSetAttribute(itemEx.uid,'elementalrunelevel', newRuneLevel)
	doRemoveItem(item.uid, 1)
	return true
end