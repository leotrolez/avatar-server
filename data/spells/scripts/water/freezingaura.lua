local cf = {}
cf.ticks = 5 -- quantas vezes a dobra vai procar
cf.interval = 1000 -- cf.intervalo entre cada tick (milisegundos)
cf.cooldown = 7 -- tempo de cf.cooldown para poder usar a spell novamente
cf.stunDuration = 2 -- tempo do alvo stunado por tick
cf.effectz_a = 41
cf.effectz_b = 70
cf.effectz_c = 116
cf.effectx_a = 28
cf.effectx_b = 36

local combatVisual = createCombatObject()
setCombatParam(combatVisual, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combatVisual, COMBAT_PARAM_EFFECT, cf.effectz_a)
setCombatArea(combatVisual, createCombatArea{
	{1, 1, 1},
	{1, 2, 1},
	{1, 1, 1}
})

local combatReal = createCombatObject()
setCombatParam(combatReal, COMBAT_PARAM_AGGRESSIVE, false)
setCombatParam(combatReal, COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
setCombatArea(combatReal, createCombatArea{
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 2, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1}
})

function onTargetTile(creature, pos)
	local cid = creature:getId()
	local i = math.random(1,2)
	if (i == 1) then
		addEvent(doSendMagicEffect, 400, pos, cf.effectz_b)
	else
		addEvent(doSendMagicEffect, 200, pos, cf.effectz_c)
	end
end
setCombatCallback(combatVisual, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onTargetCreature(creature, target)
  local cid = creature:getId()
	i = math.random(1,6)
	local self = getCreaturePosition(cid)
	local pos = getCreaturePosition(target)
	local shoot = {x = (pos.x - i), y = (pos.y - i), z = (pos.z)}
	if (i <= 3) then
		doSendDistanceShoot(self, pos, cf.effectx_a)
		doSendMagicEffect(pos, cf.effectz_c)
	elseif (i == 4) then
		addEvent(doSendDistanceShoot, 200, shoot, pos, cf.effectx_a)
	else
		addEvent(doSendDistanceShoot, 400, shoot, pos, cf.effectx_b)
	end	
	if math.random(1,100) <= 75 then
		doFreeze(target, cf.stunDuration)	
	end
end
setCombatCallback(combatReal, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()

	if not canUseWaterSpell(cid, 1, 3, false) then 
		return false
	end

	if getSpellCancels(cid, "water") == true then
		return false
	end
	if getPlayerExaust(cid, "water", "freezingaura") == false then
		return false
	end
	doPlayerAddExaust(cid, "water", "freezingaura", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	   
	setCreatureNoMoveTime(cid, (cf.interval*cf.ticks))	
	for i = 0, (cf.ticks-1) do 
		addEvent(function()
			if isCreature(cid) and not isInPZ(cid) then 
				local pos = getThingPos(cid)
				doCombat(cid, combatReal, {type=3, pos=pos})
				doCombat(cid, combatVisual, {type=3, pos=pos})
			end 
		end, cf.interval*i)
	end 
    
	return true 
end