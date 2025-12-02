local config = {
    posesToEnter = {
        {x=753,y=365,z=10},
        {x=753,y=367,z=10},
        {x=753,y=369,z=10},
        {x=753,y=371,z=10}
    }
}

local convertedVocs = {1, 4, 3, 2}
local function isTheElement(cid, x)
	if getPlayerVocation(cid) ~= convertedVocs[x] then 
		return false 
	end 
	return true
end 
local posesToVoc = {
        {x=731,y=325,z=11},
        {x=871,y=465,z=11},
        {x=780,y=376,z=11},
        {x=679,y=377,z=11}
}
function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid 
	local players = {}
    for x = 1, #config.posesToEnter do
        local possiblePlayer = getTopCreature(config.posesToEnter[x]).uid
		if possiblePlayer > 0 and isPlayer(possiblePlayer) and getPlayerLevel(possiblePlayer) >= 125 and isTheElement(possiblePlayer, x) then
            players[x] = possiblePlayer
        else
            doPlayerSendCancel(cid, getLangString(cid, "Your team needs an bender of each element in the correct position to start.", "Seu time precisa de um dobrador de cada elemento na posição correta para iniciar."))
            return true
        end
    end
	for i = 1, #players do 
		doSendMagicEffect(getThingPos(players[i]), CONST_ME_TELEPORT)
		doTeleportThing(players[i], posesToVoc[getPlayerVocation(players[i])])
		doSendMagicEffect(getThingPos(players[i]), CONST_ME_TELEPORT)
	end 
	return true
end
