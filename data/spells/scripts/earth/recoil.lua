local cf = {}
cf.cooldown = 4
cf.duration = 15 -- duracao do reflect
cf.percentage_RF = 50 -- % de reflect
cf.effectz = 13

function onCastSpell(creature, var)
	local cid = creature:getId()
	if getSpellCancels(cid, "earth") == true then
		return false
	end
	  if getPlayerExaust(cid, "earth", "recoil") == false then
		return false
	  end
	doPlayerAddExaust(cid, "earth", "recoil", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	
	--reflectDmg(cid, cf.percentage_RF, cf.duration, cf.effectz, "Reflect!", 120, false)
	
	return true
end
