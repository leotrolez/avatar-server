local cf = {}
cf.ticks = 10 -- quantas vezes a dobra vai procar
cf.interval = 500 -- intervalo entre cada tick (milisegundos)
cf.cooldown = 3 -- tempo de cooldown para poder usar a spell novamente
cf.effectz_a = 14
cf.effectz_b = 70
cf.effectz_c = 75
cf.effectx_a = 28
cf.effectx_b = 36
cf.percentageD = 90

local combatVisual = createCombatObject()
setCombatParam(combatVisual, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combatVisual, COMBAT_PARAM_EFFECT, cf.effectz_a)
setCombatArea(combatVisual, createCombatArea(AREA_SQUARE1X1))

local combatReal = createCombatObject()
setCombatParam(combatReal, COMBAT_PARAM_AGGRESSIVE, 0)
setCombatParam(combatReal, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatArea(combatReal, createCombatArea{
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 3, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1}
})

function onTargetTile(creature, pos)
	local cid = creature:getId()
	local i = math.random(1,2)
	if (i == 1) then
		doSendMagicEffect(pos, cf.effectz_c)
	else
		doSendMagicEffect(pos, 1)
	end
end
setCombatCallback(combatVisual, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local function isInPvpZone(cid)
local pos = getCreaturePosition(cid)
	if getTileInfo(pos).hardcore then
		return true 
	end
return false
end

local function isInSameGuild(cid, target)
if isPlayer(cid) and isPlayer(target) and not (isInPvpZone(target) and not castleWar.isOnCastle(target)) then
	local cidGuild = getPlayerGuildId(cid)
	local targGuild = getPlayerGuildId(target)
	if cidGuild > 0 and cidGuild == targGuild then
		return true
	end
end
	return false
end

local function isNonPvp(cid)
return isMonster(cid) or getPlayerStorageValue(cid, "canAttackable") == 1
end 

function onTargetCreature(creature, target)
  local cid = creature:getId()
	if (isPlayer(target) and cid == target) or (isInSameGuild(cid, target)) or (isPlayer(target) and isInParty(target) and isInParty(cid) and getPlayerParty(cid) == getPlayerParty(target)) or (isSummon(target) and getCreatureMaster(target) == cid) or (isSameWarTeam(cid, target)) then 
		if isNonPvp(cid) and not isNonPvp(target) then 
		else
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
			doCreatureAddHealth(target, total)
			doCreatureAddMana(target, total)			
			
			i = math.random(1,6)
			local self = getCreaturePosition(cid)
			local pos = getCreaturePosition(target)
			local shoot = {x = (pos.x - i), y = (pos.y - i), z = (pos.z)}
			if (i <= 3) then
				doSendDistanceShoot(self, pos, cf.effectx_a)
				doSendMagicEffect(pos, cf.effectz_a)
			elseif (i == 4) then
				addEvent(doSendDistanceShoot, 200, shoot, pos, cf.effectx_a)
				addEvent(doSendMagicEffect, 300, pos, cf.effectz_b)
			else
				addEvent(doSendDistanceShoot, 400, shoot, pos, cf.effectx_b)
				addEvent(doSendMagicEffect, 500, pos, cf.effectz_a)
			end
		end
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
	if getPlayerExaust(cid, "water", "healaura") == false then
		return false
	end
	doPlayerAddExaust(cid, "water", "healaura", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
		
	setCreatureNoMoveTime(cid, (cf.interval*cf.ticks))	
	exhaustion.set(cid, "OnDecrease", (cf.interval*cf.ticks)/1000)
	setPlayerStorageValue(cid, "OnDecrease", cf.percentageD)
	for i = 0, (cf.ticks - 1) do 
		addEvent(function()
			if isCreature(cid) and not isInPz(cid) then 
				local pos = getCreaturePosition(cid)
				doSendMagicEffect(pos, cf.effectz_c)
				doCombat(cid, combatReal, var)
				doCombat(cid, combatVisual, var)
			end 
		end, i*cf.interval)
	end 
    
	return true 
end