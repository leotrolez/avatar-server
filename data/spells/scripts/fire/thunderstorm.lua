local spellName = "fire thunderstorm"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}

local area1 = createCombatArea({ 
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 2, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}}) 

local area2 = createCombatArea({ 

{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0},
{0, 0, 0, 1, 0, 2, 0, 1, 0, 0, 0},
{0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
}) 
   
    
local area3 = createCombatArea({ 

{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0},
{0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0},
{0, 0, 1, 0, 0, 2, 0, 0, 1, 0, 0},
{0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0},
{0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
})  

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat1, area1)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat2, area2)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatArea(combat3, area3)

local combats = {combat1, combat2, combat3}

for x = 1, #combats do
    function onGetPlayerMinMaxValues(cid, level, magLevel)
    local min = (level+(magLevel/2)*4.1)+math.random(3, 7)
    local max = (level+(magLevel/2)*5.3)+math.random(7, 15)
	if getPlayerInWaterWithUnderwater(cid) then 
        min = min*1.3
        max = max*1.3
    end
    if exhaustion.check(cid, "isFocusthunderstorm") then 
        min = min*1.5
        max = max*1.5
    end
	local dano = math.random(min, max)
	local atk = cf.atk
	if atk and type(atk) == "number" then 
		dano = dano * (atk/100)
		dano = dano+1
	end
	dano = remakeValue(1, dano, cid)
    return -dano, -dano
	end 
    setCombatCallback(combats[x], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
	function onTargetTile(creature, pos)
	local cid = creature:getId()
        return doSendMagicEffect({x=pos.x+1, y=pos.y, z=pos.z}, 136)
    end
    setCombatCallback(combats[x], CALLBACK_PARAM_TARGETTILE, "onTargetTile")
	function onTargetCreature(creature, target)
  local cid = creature:getId()
		if isNpc(target) then
			return false
		end
		if getTileInfo(getCreaturePosition(cid)).protection then return false end
			doSlow(cid, target, 20, 3500)
	end
	setCombatCallback(combats[x], CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")
end




local function explodePos(cid, pos, combat)
return isCreature(cid) and not getTileInfo(getCreaturePosition(cid)).protection and doCombat(cid, combat, {type=2, pos=pos})
end 


function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "fire") == true then
        return false
    end 
    if getPlayerExaust(cid, "fire", "thunderstorm") == false then
        return false
    end
	if getDobrasLevel(cid) >= 21 then
		doPlayerAddExaust(cid, "fire", "thunderstorm", fireExausted.thunderstorm-6)
	else
		doPlayerAddExaust(cid, "fire", "thunderstorm", fireExausted.thunderstorm)
	end
    if getPlayerHasStun(cid) then
        workAllCdAndAndPrevCd(cid, "fire", "thunderstorm", nil, 1)
        return true
    end
   -- setCreatureNoMoveTime(cid, 1250)
    if getPlayerOverPower(cid, "fire", true, true) then 
        exhaustion.set(cid, "isFocusthunderstorm", 3)
    end
	for j = 1, 2 do 
		for i = 1, #combats do 
			addEvent(explodePos, ((j-1)*900)+(300*(i-1)), cid, getCreaturePosition(cid), combats[i])
		end 
	end
    return true
end