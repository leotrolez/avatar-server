local cf = {}
cf.cooldown = 4
cf.effectz = 96

--efeito = 97/94

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, cf.effectz)

local area = createCombatArea({
{1, 1, 1,},
{1, 2, 1,},
{1, 1, 1,}
})
setCombatArea(combat, area)

function onGetPlayerMinMaxValues(cid, level, magLevel)
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
	
	local dano = remakeValue(4, math.random(min, max), cid)	
return -dano, -dano
end
setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "onGetPlayerMinMaxValues")

function onTargetCreature(creature, target)
  local cid = creature:getId() -- new
	local initialFloor = getThingPos(target).z
	if isCreature(target) and getThingPos(target).z == initialFloor and not isInPz(target) then 
		doPushCreature(target, getDirectionTo(getThingPos(cid), getThingPos(target)), nil, nil, nil, isPlayer(cid))
	end 
	return true
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature") -- new

function onCastSpell(creature, var)
	local cid = creature:getId()
	if getSpellCancels(cid, "earth") == true then
		return false
	end
	  if getPlayerExaust(cid, "earth", "shake") == false then
		return false
	  end
	doPlayerAddExaust(cid, "earth", "shake", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	return doCombat(cid, combat, var)
end
