
local config = {
    posesToEnter = {
        {x=1138,y=1049,z=7},
        {x=1139,y=1049,z=7},
        {x=1140,y=1049,z=7}
    }
}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid 
	local players = {}

    for x = 1, #config.posesToEnter do
        local possiblePlayer = getTopCreature(config.posesToEnter[x]).uid

        if possiblePlayer > 0 and isPlayer(possiblePlayer) then
			if getPlayerStorageValue(possiblePlayer, "90520") == 1 then
				doCreatureSay(cid, getLangString(cid, "Someone has completed this quest.", "Alguém já completou esta quest."), TALKTYPE_ORANGE_1)
				return true
			end
            players[x] = possiblePlayer
        else
           doPlayerSendCancel(cid, getLangString(cid, "You need three players to get started.", "É necessário três dobradores para começar."))
            return true
        end
    end
	for i = 1, #players do 
		doSendMagicEffect(getThingPos(players[i]), CONST_ME_TELEPORT)
		doTeleportThing(players[i], {x=1154,y=1063,z=7})
		doSendMagicEffect(getThingPos(players[i]), CONST_ME_TELEPORT)
	end 
	return true
end
