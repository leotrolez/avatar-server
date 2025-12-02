local cf = {}
cf.cooldown = 4 -- tempo de cooldown para poder usar a spell novamente
cf.percentage = 90 -- % de dano que sera reduzido
cf.duration = 5 -- em segundos
cf.effectz = 14

function onCastSpell(creature, var)
	local cid = creature:getId()

	if var.number == cid then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You can't use this fold to defend yourself.")
		doPlayerSendCancel(cid, "You can't use this fold to defend yourself.")
		return false
	end
	
	if getSpellCancels(cid, "earth") == true then
		return false
	end
	  if getPlayerExaust(cid, "earth", "defense") == false then
		return false
	  end
	doPlayerAddExaust(cid, "earth", "defense", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end

	doSendMagicEffect(getCreaturePosition(cid), cf.effectz)
	--decreaseDmg(var.number, cf.percentage, cf.duration, 14, "+ DEF!", 120, false)
    return true
end