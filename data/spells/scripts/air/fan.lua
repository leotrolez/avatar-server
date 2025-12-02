local spellName = "air fan"
local cf = {atk = spellsInfo[spellName].atk}

local MyLocal = {}
MyLocal.players = {}
 
local combats = {}
 
combats[1] = createCombatObject()
combats[2] = createCombatObject()
combats[3] = createCombatObject()
combats[4] = createCombatObject()
combats[5] = createCombatObject()
combats[6] = createCombatObject()
combats[7] = createCombatObject()
combats[8] = createCombatObject()
combats[9] = createCombatObject()
 
local sequencia = {
    1, 2, 3,
    4, 5, 6,
    7, 8, 9,
    6, 5, 4,
    3, 1, 2,
}
 
arrs = {
{
 {1,0,0,0},
 {1,0,0,0},
 {1,0,0,2},
 {1,1,0,0}},
 
 {
 {1,3,1}},
 
{
{1,0,0,0},
{1,0,0,0},
{1,0,2,0}},
 
{
{1,0,0,0},
{1,0,0,0},
{1,2,0,0}},
 
 
{
{1,0,0,0},
{1,0,0,0},
{3,0,0,0}},
 
{
{0,1,0,0},
{0,1,0,0},
{2,1,0,0}},
 
{
{0,0,1,0},
{0,0,1,0},
{2,0,1,0}},
 
{
{0,0,0,1},
{0,0,0,1},
{2,0,0,1},
{0,0,1,1}},
 
{
{0,0,1,0},
{0,0,1,0},
{2,0,1,0},
{0,0,1,0}}
 
}
 
local dirs = {
[SOUTH] = {WEST, EAST},
[NORTH] = {EAST, WEST},
[EAST] = {SOUTH, NORTH},
[WEST] = {NORTH, SOUTH}
}
 
for x = 1, #combats do
    setCombatParam(combats[x], COMBAT_PARAM_TYPE, COMBAT_AIRDAMAGE)
    setCombatParam(combats[x], COMBAT_PARAM_EFFECT, 76)
    setCombatArea(combats[x], createCombatArea(arrs[x]))
 
    function onGetPlayerMinMaxValues(cid, level, magLevel)
        local min = (level+(magLevel/4.1)*0.8)
        local max = (level+(magLevel/4.1)*1.0)
		local dano = math.random(min, max)
		local atk = cf.atk
		if atk and type(atk) == "number" then 
			dano = dano * (atk/100)
			dano = dano+1
		end
		dano = remakeAirEarth(cid, dano)
		return -dano, -dano
    end
    setCombatCallback(combats[x], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")
 
    function onTargetCreature(creature, target)
        local cid = creature:getId()
		if getTileInfo(getCreaturePosition(cid)).protection then return false end
        local playerDir = MyLocal.players[cid].dir or NORTH
        local times = MyLocal.players[cid].times
        doPushCreature(target, dirs[MyLocal.players[cid].dir][times], nil, nil, nil, isPlayer(cid))
    end
    setCombatCallback(combats[x], CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")
end
 
local function updateInfosSpell(cid)
    if isCreature(cid) then
        MyLocal.players[cid].times = 2
    end
end
 
local function removeTable(cid)
    if isCreature(cid) then
        MyLocal.players[cid] = nil
		if getDobrasLevel(cid) >= 9 then
			doPlayerAddExaust(cid, "air", "fan", airExausted.fan-6)
		else
			doPlayerAddExaust(cid, "air", "fan", airExausted.fan)
		end
    end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
 
    if getSpellCancels(cid, "air") == true then
        return false
    end
    if getPlayerExaust(cid, "air", "fan") == false then
        return false
    end

    if MyLocal.players[cid] == nil then
        if getPlayerHasStun(cid) then
			if getDobrasLevel(cid) >= 9 then
				doPlayerAddExaust(cid, "air", "fan", airExausted.fan-6)
			else
				doPlayerAddExaust(cid, "air", "fan", airExausted.fan)
			end
            return true
        end
 
        MyLocal.players[cid] = {}
        MyLocal.players[cid].dir = getCreatureLookDirection(cid)
        MyLocal.players[cid].times = 1
        for x = 1, #sequencia do
            addEvent(doCombat, 50*x, cid, combats[sequencia[x]], var)
            if x == #sequencia then
                addEvent(removeTable, 50*x, cid)
            end
        end
        setCreatureNoMoveTime(cid, (#sequencia*50) + 50) 
        workAllCdAndAndPrevCd(cid, "air", "fan", 1000, 1)
        addEvent(updateInfosSpell, 350, cid)
        return true
    else
        doPlayerSendCancelEf(cid, "You're already using this fold.")
        return false
    end
end