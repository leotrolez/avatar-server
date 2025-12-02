local cf = {}
cf.cooldown = 2 -- tempo de cooldown para poder usar a spell novamente
cf.percentage = 50 -- porcentagem de dodge que os alvos irao ganhar
cf.duracao = 10000 -- duracao em ms
cf.effectz_a = 13
cf.effectz_b = 14
cf.percentageB = 50 -- % de dodge que os players vao ganhar

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combat, COMBAT_PARAM_EFFECT, cf.effectz_a)

setCombatArea(combat, createCombatArea(AREA_CIRCLE2X2))

function onTargetCreature(creature, target)
  local cid = creature:getId()
	if (isPlayer(target) and cid == target) or (isInSameGuild(cid, target)) or (isPlayer(target) and isInParty(target) and isInParty(cid) and getPlayerParty(cid) == getPlayerParty(target)) or (isSummon(target) and getCreatureMaster(target) == cid) or (isSameWarTeam(cid, target)) then 
		if isNonPvp(cid) and not isNonPvp(target) then 
		else
			if not cid == target then
				exhaustion.set(target, "OnBoostDodge", duracao/1000)
				setPlayerStorageValue(target, "OnBoostDodge", cf.percentageB)
			end
		end
	end
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()

	if getSpellCancels(cid, "air") == true then
		return false
	end
	if getPlayerExaust(cid, "air", "masssense") == false then
		return false
	end
	doPlayerAddExaust(cid, "air", "masssense", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end

	return doCombat(cid, combat, var)
end
