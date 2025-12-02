local cf = {}
cf.ticks = 5 -- quantas vezes a dobra vai procar
cf.interval = 1000 -- cf.intervalo entre cada tick (milisegundos)
cf.cooldown = 3 -- tempo de cf.cooldown para poder usar a spell novamente
cf.effectz_a = 135
cf.effectz_b = 70
cf.effectz_c = 152
cf.effectx_a = 28
cf.effectx_b = 36

local combatVisual = createCombatObject()
setCombatParam(combatVisual, COMBAT_PARAM_EFFECT, cf.effectz_a)
setCombatArea(combatVisual, createCombatArea{
	{1, 1, 1},
	{1, 2, 1},
	{1, 1, 1}
})

local combatReal = createCombatObject()
setCombatParam(combatReal, COMBAT_PARAM_TYPE, COMBAT_DROWNDAMAGE)
setCombatArea(combatReal, createCombatArea{
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 2, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1}
})

function onGetPlayerMinMaxValues(cid, level, magLevel)

	local vitality = getPlayerStorageValue(cid, "healthvalue")
	if not vitality then vitality = 0 end
	local mana = getPlayerStorageValue(cid, "manavalue")
	if not mana then mana = 0 end
	local level = getPlayerLevel(cid)
	local magLevel = getPlayerMagLevel(cid)
	
    local min = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + 5)
    local max = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + 25)
	
	local total = math.random(min, max)
	
	if getPlayerInWaterWithUnderwater(cid) then -- aprimora a spell dentro d'agua
		total = (total * 1.25)
	end
	
return -total, -total
end
setCombatCallback(combatReal, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetTile(creature, pos)
	local cid = creature:getId()
	local i = math.random(1,2)
	if (i == 1) then
		addEvent(doSendMagicEffect, 400, pos, cf.effectz_b)
	else
		addEvent(doSendMagicEffect, 200, pos, cf.effectz_a)
	end
end
setCombatCallback(combatVisual, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onTargetCreature(creature, target)
  local cid = creature:getId()
	i = math.random(1,6)
	j = math.random(1,4)
	local self = getCreaturePosition(cid)
	local pos = getCreaturePosition(target)
	local shoot = {x = (pos.x - i), y = (pos.y - i), z = (pos.z)}
	if (i <= 3) then
		addEvent(doSendDistanceShoot, 150*j, self, pos, cf.effectx_a)
		addEvent(doSendMagicEffect, 150*j, pos, cf.effectz_a)
	elseif (i == 4) then
		addEvent(doSendDistanceShoot, 150*j, shoot, pos, cf.effectx_a)
	else
		addEvent(doSendDistanceShoot, 150*j, shoot, pos, cf.effectx_b)
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
	if getPlayerExaust(cid, "water", "strikeaura") == false then
		return false
	end
	doPlayerAddExaust(cid, "water", "strikeaura", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
				
	dontMove(cid, cf.ticks * cf.interval)	
	decreaseDmg(cid, 90, math.floor((cf.ticks * cf.interval)/1000), cf.effectz_a, "+ DEF!", 35, false)		
		for i = 0, (cf.ticks-1) do 
			addEvent(function()
				if isCreature(cid) and not isInPZ(cid) then 
					local pos = getCreaturePosition(cid)
					doCombat(cid, combatReal, {type=3, pos=pos})
					doCombat(cid, combatVisual, {type=3, pos=pos})
				end 
			end, cf.interval*i)
		end 
    

return true 
end