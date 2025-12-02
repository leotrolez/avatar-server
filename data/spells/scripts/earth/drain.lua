-- ticks = 2
local cf = {}
cf.cooldown = 4
cf.interval = 1000 -- em milisegundos

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 4)
setCombatArea(combat, createCombatArea(
      {
      {1, 1, 1},
      {1, 2, 1},
      {1, 1, 1}
      }))

local function getDamage(cid)
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
return dano
end

function onTargetCreature(creature, target)
  local cid = creature:getId()
  heal = getDamage(cid)
  doTargetCombatHealth(0, cid, COMBAT_HEALING, heal, heal, 12)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	local cid = creature:getId()

	if getSpellCancels(cid, "earth") == true then
		return false
	end
	  if getPlayerExaust(cid, "earth", "drain") == false then
		return false
	  end
	doPlayerAddExaust(cid, "earth", "drain", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	
    doCombat(cid, combat, var)
	addEvent(doCombat, cf.interval, cid, combat, var)
	return true
end
