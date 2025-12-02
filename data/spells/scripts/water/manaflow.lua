local cf = {}
cf.ticks = 9 -- quantas vezes a dobra vai procar
cf.interval = 400 -- cf.intervalo entre cada tick (milisegundos)
cf.cooldown = 3 -- tempo de cf.cooldown para poder usar a spell novamente
cf.effectz = 12

local MyLocal = {}
MyLocal.players = {}

local alvosFlow = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, cf.effectz)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)
setCombatArea(combat, createCombatArea({
	{0, 0, 1, 0, 0},
	{0, 1, 1, 1, 0},
	{1, 1, 3, 1, 1},
	{0, 1, 1, 1, 0},
	{0, 0, 1, 0, 0}
}))

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
			local dodge = getPlayerStorageValue(cid, "dodgevalue")
			if not dodge then dodge = 0 end
			local level = getPlayerLevel(cid)
			local magLevel = getPlayerMagLevel(cid)
			local min = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + (dodge*0))
			local max = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + (dodge*0))
			local heal = remakeValue(2, math.random(min, max), cid)	
			doCreatureAddMana(target, heal)
		end
	end
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()

	if not canUseWaterSpell(cid, 1, 3, false) then 
		return false
	end

	if getSpellCancels(cid, "water") == true then
		return false
	end
	if getPlayerExaust(cid, "water", "manaflow") == false then
		return false
	end
	doPlayerAddExaust(cid, "water", "manaflow", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	
	doCreatureAddMana(cid, -(math.ceil(getCreatureMana(cid)/2)))	
		for i = 0, (cf.ticks-1) do 
			addEvent(function()
				if isCreature(cid) and not isInPz(cid) then 
					local pos = getThingPos(cid)
					doSendMagicEffect(pos, cf.effectz)
					doCombat(cid, combat, var)
				end 
			end, cf.interval*i)
		end 
return true
end