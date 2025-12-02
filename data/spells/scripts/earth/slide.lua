local cf = {}
cf.cooldown = 4
cf.effectz = 44
cf.effectx = 11
cf.duration = 2 -- duracao da paralyze em segundos

local MyLocal = {}
MyLocal.players = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, cf.effectz)

local area = createCombatArea({
	{1, 1, 1},
	{1, 3, 1},
	{1, 1, 1}
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

local function sendTwo(cid, frompos, pos, times, target)
	if not isCreature(cid) then
		return false
	end
	if isCreature(target) and not getTileInfo(getCreaturePosition(target)).protection and getCreaturePosition(target).z == getCreaturePosition(cid).z then 
		pos = getCreaturePosition(target)
	end 
	doSendDistanceShoot(frompos, pos, cf.effectx)
	doCombat(cid, combat, {pos=pos, type=2})  
	doSendMagicEffect(pos, cf.effectz)
	if times == 3 then
		MyLocal.players[cid] = nil
	end
end

local function SendOne(cid, frompos, pos, targetPos, target)
	if not(isCreature(cid)) then
		return false
	end
	doSendDistanceShoot(frompos, pos, cf.effectx)
	if targetPos ~= nil then
		for x = 1, 3 do
			addEvent(sendTwo, x*333, cid, {x=targetPos.x-2,y=targetPos.y-6,z=targetPos.z}, targetPos, x, target)  
		end
	end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
	if getSpellCancels(cid, "earth") == true then
		return false
	end
	  if getPlayerExaust(cid, "earth", "slide") == false then
		return false
	  end
	doPlayerAddExaust(cid, "earth", "slide", cf.cooldown)
	if getPlayerHasStun(cid) then
		return true
	end
	
	local playerPos = getCreaturePosition(cid)
	local target = getCreatureTarget(cid)
	local targetPos = getCreaturePosition(target)
	if MyLocal.players[cid] == nil then
		for x = 1, 3 do
			if x == 3 then
				addEvent(SendOne, x*333, cid, playerPos, {x=playerPos.x-2,y=playerPos.y-6,z=playerPos.z}, targetPos, target)
			else
				addEvent(SendOne, x*333, cid, playerPos, {x=playerPos.x-2,y=playerPos.y-6,z=playerPos.z}, nil, target)
			end  
		end
		MyLocal.players[cid] = true
		return true
	else
		doPlayerSendCancel(cid, "You're already using this fold.")
		return false
	end
end