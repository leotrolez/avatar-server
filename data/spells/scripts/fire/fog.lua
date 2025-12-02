local cf = {} 
cf.cooldown = 4 -- tempo de cooldown para poder usar a spell novamente
cf.duration = 3 -- em segundos
cf.miss = 50 -- chance de dar miss

local AREA_WAVENEW = {
{0, 0, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 0, 0, 0},
{0, 0, 0, 3, 0, 0, 0}
}
--focus ready--

local MyLocal = {}
MyLocal.players = {}

local combat = createCombatObject()
local area = createCombatArea(AREA_WAVENEW, AREADIAGONAL_WAVE4)
setCombatArea(combat, area)

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 36)

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
	
	local dano = remakeValue(1, math.random(min, max), cid)	
	return -dano, -dano
end
setCombatCallback(combat1, CALLBACK_PARAM_SKILLVALUE, "onGetPlayerMinMaxValues")

function onTargetCreature(creature, target)
  local cid = creature:getId()
	if (isPlayer(target) and cid == target) or (isInSameGuild(cid, target)) or (isPlayer(target) and isInParty(target) and isInParty(cid) and getPlayerParty(cid) == getPlayerParty(target)) or (isSummon(target) and getCreatureMaster(target) == cid) or (isSameWarTeam(cid, target)) then 
		if isNonPvp(cid) and not isNonPvp(target) then 
		else		
			doSendMagicEffect(getCreaturePosition(target),48)
			doSlow(cid, target, 60, cf.duration*1000)
			chance = math.random(1,100)
			if chance <= cf.miss then
				setPlayerStuned(target, cf.duration)
			end	
		end
	end
end
setCombatCallback(combat1, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function sendMagicEffectWave(pos1, pos2, cid)
    if math.random(1, 3) == 3 then
        doSendDistanceShoot(pos1, pos2, 3)
    end
    doCombat(cid, combat1, {type=2, pos=pos2})
end

function onTargetTile(creature, pos)
	local cid = creature:getId()
	if getTileInfo(getCreaturePosition(cid)).protection then return false end
  addEvent(sendMagicEffectWave, 25*MyLocal.players[cid], getThingPos(cid), pos, cid)
  MyLocal.players[cid] = MyLocal.players[cid]+1
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local function retireTable(cid)
    MyLocal.players[cid] = nil
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end
    if MyLocal.players[cid] == nil then
		if getPlayerExaust(cid, "fire", "fog") == false then
			return false
		end
		doPlayerAddExaust(cid, "fire", "fog", cf.cooldown)
		if getPlayerHasStun(cid) then
			return true
		end
        MyLocal.players[cid] = 0
        doCombat(cid, combat, var)
        addEvent(retireTable, 1000, cid)
        return true
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end