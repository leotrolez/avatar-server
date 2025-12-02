local cf = {}
cf.cooldown = 2 -- tempo de cooldown para poder usar a spell novamente
cf.percentageB = 50 -- porcentagem de dodge que os alvos irao ganhar
cf.duration = 5 -- em segundos
cf.effectz = 14

function onCastSpell(creature, var)
	local cid = creature:getId()

	if getSpellCancels(cid, "air") == true then
		return false
	end
	if getPlayerExaust(cid, "air", "sense") == false then
		return false
	end
	doPlayerAddExaust(cid, "air", "sense", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	
	exhaustion.set(cid, "OnBoostDodge", cf.duration)
	setPlayerStorageValue(cid, "OnBoostDodge", cf.percentageB)
	return true 
end