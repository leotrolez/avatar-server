local cf = {}
cf.cooldown = 3 -- tempo de cooldown para poder usar a spell novamente
cf.percentage = 90 -- % de dano que sera refletido
cf.duration = 10000 -- duracao em milisegundos
cf.effectz = 14

function onCastSpell(creature, var)
	local cid = creature:getId()	
	target = var.number
	if target == cid then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You can't use this fold to defend yourself.")
		doPlayerSendCancel(cid, "You can't use this fold to defend yourself.")
		return false
	end
	
	if getSpellCancels(cid, "air") == true then
		return false
	end
	if getPlayerExaust(cid, "air", "mirror") == false then
		return false
	end
	doPlayerAddExaust(cid, "air", "mirror", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	
	doSendMagicEffect(getCreaturePosition(target), cf.effectz)
	exhaustion.set(target, "OnReflect", cf.duration/1000)
    return true
end