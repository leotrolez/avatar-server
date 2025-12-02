local cf = {}
cf.ticks = 10 -- quantas vezes a dobra vai procar
cf.interval = 900 -- cf.intervalo entre cada tick (milisegundos)
cf.cooldown = 2 -- tempo de cf.cooldown para poder usar a spell novamente

local combatVisual = createCombatObject()
setCombatParam(combatVisual, COMBAT_PARAM_EFFECT, 2)
setCombatArea(combatVisual, createCombatArea{
	{0, 0, 0, 0, 0, 0, 0},
	{0, 0, 1, 0, 1, 0, 0},
	{0, 1, 0, 1, 0, 1, 0},
	{0, 0, 1, 2, 1, 0, 0},
	{0, 1, 0, 1, 0, 1, 0},
	{0, 0, 1, 0, 1, 0, 0},
	{0, 0, 0, 0, 0, 0, 0}
})

local combatReal = createCombatObject()
setCombatParam(combatReal, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
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
	local dodge = getPlayerStorageValue(cid, "dodgevalue")
	if not dodge then dodge = 0 end
	local level = getPlayerLevel(cid)
	local magLevel = getPlayerMagLevel(cid)
	
    local min = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + (dodge*0))
    local max = ((level*1) + (magLevel*1) + (vitality*0) + (mana*0) + (dodge*0))
	
	local dano = remakeValue(3, math.random(min, max), cid)	
return -dano, -dano
end
setCombatCallback(combatReal, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetPlayerMinMaxValues")

function onTargetCreature(creature, target)
  local cid = creature:getId()
if isImune(cid, target) or (cid == target) then
return false
else
	local i = math.random(1,4)
	local pos = getCreaturePosition(target)
	local shoot = {
	[1]={x = pos.x, y = pos.y - i, z = pos.z},
	[2]={x = pos.x + i + 1, y = pos.y, z = pos.z},
	[3]={x = pos.x, y = pos.y + i, z = pos.z},
	[4]={x = pos.x - i - 1, y = pos.y, z = pos.z}}
	doSendMagicEffect(pos, 2)
	doSendDistanceShoot(getPlayerPosition(cid), shoot[i], 36)
end
end
setCombatCallback(combatReal, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")


function onCastSpell(creature, var)
	local cid = creature:getId()

	if getSpellCancels(cid, "air") == true then
		return false
	end
	if getPlayerExaust(cid, "air", "chains") == false then
		return false
	end
	doPlayerAddExaust(cid, "air", "chains", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end	
				
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