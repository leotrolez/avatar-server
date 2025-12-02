local cf = {}
cf.cooldown = 3 -- tempo de cooldown para poder usar a spell novamente
cf.effectz = 12

local function doSendHealth(cid, pos, var)
	local vitality = getPlayerStorageValue(cid, "healthvalue")
	if not vitality then vitality = 0 end
	local mana = getPlayerStorageValue(cid, "manavalue")
	if not mana then mana = 0 end
	local dodge = getPlayerStorageValue(cid, "dodgevalue")
	if not dodge then dodge = 0 end
	local level = getPlayerLevel(cid)
	local magLevel = getPlayerMagLevel(cid)
	
    local min = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + (dodge*0))
    local max = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + (dodge*0))
	
	local heal = remakeValue(2, math.random(min, max), cid)	
		
	doCreatureAddMana(var, heal)		
    doSendMagicEffect(pos, cf.effectz)
end

function onCastSpell(creature, var)
	local cid = creature:getId()

	if var.number == cid then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You can't use this fold on yourself.")
		return false
	end
		
	if not canUseWaterSpell(cid, 1, 3, false) then 
		return false
	end

	if getSpellCancels(cid, "water") == true then
		return false
	end
	if getPlayerExaust(cid, "water", "manaheal") == false then
		return false
	end
	doPlayerAddExaust(cid, "water", "manaheal", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
		
    doSendHealth(cid, getCreaturePosition(var.number), var.number)
		
	return true
end