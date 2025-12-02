local frases = {"You made a mistake coming here..", "NOW YOU'LL DIE!"}

local function createIceWalls()
	local basePos = {x=527, y=988, z=7}
	for i = 1, 4 do 
		local pos = {x=basePos.x, y=basePos.y+i, z=basePos.z}
		local v = getTileItemById(pos, 1546).uid
		if v > 0 then
			doTransformItem(v, 6735)
			doSendMagicEffect(pos, 43)
		end
	end 
end

local function doTalkWord(boss, frase)
	if not isCreature(boss) then return false end
	doCreatureSay(boss, frase, TALKTYPE_ORANGE_1)
end

local function doTalkFrase(boss)
	if not isCreature(boss) then return false end
	addEvent(doTalkWord, 1000, boss, frases[1])
	addEvent(doTalkWord, 3000, boss, frases[2])
end

local function heIsGM(cid)
return getPlayerGroupId(cid) >= 3
end 

local function checkZuko()
local specs = getSpectators({x=520, y=990, z=7}, 7, 7)
local haveLost = 0
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isMonster(specs[i]) and not isSummon(specs[i]) then 
				haveLost = 1
			end 
		end 
	end 
	if haveLost == 0 then 
		local boss = doCreateMonster("Seacrest Serpent", {x=519, y=991, z=7})
		createIceWalls()
		doTalkFrase(boss)
	end 
end 

local function getPlayerInRoomCount()
local specs = getSpectators({x=520, y=990, z=7}, 7, 7)
local playerCount = 0
	if specs and #specs > 0 then 
		for i = 1, #specs do 
			if isPlayer(specs[i]) and not heIsGM(specs[i]) then 
				playerCount = playerCount+1
			end 
		end 
	end 
	
	return playerCount
end


function onStepIn(cid, item, position, fromPosition)
	if getPlayerStorageValue(cid, "outlawAccess") == 1 then
		if getPlayerInRoomCount() >= 2 then
			doPlayerSendCancel(cid, "Sorry, only two players at the same time are allowed inside.")
			return true
		end
		checkZuko()
		doSendMagicEffect(position, 14)
		doTeleportThing(cid, {x=position.x-2, y=position.y, z=position.z})
		doSendMagicEffect({x=position.x-2, y=position.y, z=position.z}, 14)
	end
	return true
end