local cf = {}
cf.ticks = 5 -- quantas vezes a dobra vai procar
cf.interval = 1000 -- intervalo entre cada tick (milisegundos)
cf.cooldown = 6 -- tempo de cooldown para poder usar a spell novamente
cf.effectz_a = 138
cf.effectz_b = 70
cf.effectz_c = 41

local combat1 = createCombatObject() 
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)

local combat2 = createCombatObject() 
local combat3 = createCombatObject() 


local area1 = createCombatArea({
	{0, 0, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 3, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 0, 0}})
	
local area2 = createCombatArea({
	{0, 0, 1, 1, 1, 0, 0},
	{0, 1, 0, 0, 0, 1, 0},
	{1, 0, 0, 1, 0, 0, 1},
	{1, 0, 1, 3, 1, 0, 1},
	{1, 0, 0, 1, 0, 0, 1},
	{0, 1, 0, 0, 0, 1, 0},
	{0, 0, 1, 1, 1, 0, 0}})
	
local area3 = createCombatArea({
	{0, 0, 0, 0, 0, 0, 0},
	{0, 0, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 0},
	{0, 1, 1, 3, 1, 1, 0},
	{0, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 0, 0},
	{0, 0, 0, 0, 0, 0, 0}})
	
setCombatArea(combat1, area1)
setCombatArea(combat2, area2)
setCombatArea(combat3, area3)

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
	
	local dano = remakeValue(2, math.random(min, max), cid)	
return -dano, -dano
end
setCombatCallback(combat1, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetTile(creature, pos)
	local cid = creature:getId()
	doSendMagicEffect(pos, cf.effectz_a)
end
setCombatCallback(combat2, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onTargetTile(creature, pos)
	local cid = creature:getId()
	local chance = math.random(1,3)
	if chance <= 2 then
		doSendMagicEffect(pos, cf.effectz_b)
	else
		doSendMagicEffect(pos, cf.effectz_c)
	end
end
setCombatCallback(combat3, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(creature, var)
	local cid = creature:getId()	
	if not canUseWaterSpell(cid, 1, 3, false) then 
		return false
	end

	if getSpellCancels(cid, "water") == true then
		return false
	end
	if getPlayerExaust(cid, "water", "geiser") == false then
		return false
	end
	doPlayerAddExaust(cid, "water", "geiser", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	
	for x = 0, (cf.ticks) do
		addEvent(function()
		if isCreature(cid) then
		doCombat(cid, combat1, var)
		doCombat(cid, combat2, var)
		doCombat(cid, combat3, var)
		end end, x*cf.interval)	
	end
return true
end