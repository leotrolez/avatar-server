local config = {
    posesToEnter = {
        {x=883,y=527,z=9},
        {x=884,y=527,z=9},
        {x=885,y=527,z=9},
        {x=886,y=527,z=9},
        {x=887,y=527,z=9}
    }
}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid 
	local players = {}

    for x = 1, #config.posesToEnter do
        local possiblePlayer = getTopCreature(config.posesToEnter[x]).uid

        if possiblePlayer > 0 and isPlayer(possiblePlayer) then
            players[x] = possiblePlayer
        else
            doPlayerSendCancel(cid, getLangString(cid, "Your team needs five players to start.", "Seu time precisa de cinco dobradores para iniciar a Rarods Quest."))
            return true
        end
    end
	for i = 1, #players do 
		doSendMagicEffect(getThingPos(players[i]), CONST_ME_TELEPORT)
		doTeleportThing(players[i], {x=981, y=877, z=6})
		doSendMagicEffect(getThingPos(players[i]), CONST_ME_TELEPORT)
	end 
	return true
end
