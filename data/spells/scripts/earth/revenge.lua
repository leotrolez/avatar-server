local cf = {}
cf.cooldown = 8
cf.earthId = 13847 -- 1304
cf.stunDuration = 1
-- duracao = 4 seg

local combatVisual = createCombatObject()
setCombatParam(combatVisual, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combatVisual, COMBAT_PARAM_EFFECT, 4)
setCombatArea(combatVisual, createCombatArea{
	{0, 1, 0},
	{1, 2, 1},
	{0, 1, 0}
})

local combatReal = createCombatObject()
setCombatParam(combatReal, COMBAT_PARAM_AGGRESSIVE, true)
setCombatParam(combatReal, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatArea(combatReal, createCombatArea{
	{0, 0, 0, 1, 1, 1, 0, 0, 0},
	{0, 0, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 3, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 1, 1, 0, 0},
	{0, 0, 0, 1, 1, 1, 0, 0, 0}
})

function onTargetCreature(creature, target)
  local cid = creature:getId()
  local tid = target:getId()
	if not (isImune(cid, tid) or (cid == target)) or cantReceiveDisable(cid, target) then
		i = math.random(1,6)
		j = math.random(1,4)
		local self = getCreaturePosition(cid)
		local pos = getCreaturePosition(target)
		local shoot = {x = (pos.x - i), y = (pos.y - i), z = (pos.z)}
		if (i <= 3) then
			addEvent(doSendDistanceShoot, 150*j, self, pos, 38)
		else
			addEvent(doSendDistanceShoot, 150*j, self, pos, 11)
		end
		if isPlayer(target) then 
			exhaustion.set(target, "stopDashs", 2) 
			time = time/2
		end 
		setCreatureNoMoveTime(tid, cf.stunDuration*1000, cf.stunDuration*500)
		doSetItemOutfit(target, cf.earthId, (cf.stunDuration*1000)-500)
	end
end
setCombatCallback(combatReal, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()

	if getSpellCancels(cid, "earth") == true then
		return false
	end
	  if getPlayerExaust(cid, "earth", "revenge") == false then
		return false
	  end
	doPlayerAddExaust(cid, "earth", "revenge", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end

	setCreatureNoMoveTime(cid, cf.stunDuration * 1000)

	for i = 0, 5 do 
		addEvent(function()
			if isCreature(cid) and not isInPZ(cid) then 
				local pos = getCreaturePosition(cid)
				doCombat(cid, combatReal, {type=3, pos=pos})
				doCombat(cid, combatVisual, {type=3, pos=pos})
			end 
		end, 800*i)
	end 
	return true 
end