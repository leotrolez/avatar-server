local config = {
    storageCompleted = "90500",

    winActionId = {
        [100] = {itemid = 13752, amount = 1},
        [101] = {itemid = 13920, amount = 1},
        [102] = {itemid = 13939, amount = 1}
    },

    posExit = {x=778,y=230,z=9}
}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    doTeleportCreature(cid, config.posExit, 10)

    if getPlayerStorageValue(cid, config.storageCompleted) == 1 then
        return sendBlueMessage(cid, "Please report it to gameMaster (Annihilator chestBug: 1)")
    end

    local prizeItem = doPlayerAddItem(cid, config.winActionId[item.actionid].itemid, config.winActionId[item.actionid].amount)
    doSendMagicEffect(getThingPos(cid), 29)
    setPlayerStorageValue(cid, config.storageCompleted, 1)
	
	local finalExp = getExperienceForLevel(101) - getExperienceForLevel(100)
	finalExp = finalExp/2
	doPlayerAddExperience(cid, finalExp)
	doSendAnimatedText(getCreaturePosition(cid), finalExp, 215)
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você recebeu "..finalExp.." pontos de experiência e "..config.winActionId[item.actionid].amount.."x "..getItemNameById(config.winActionId[item.actionid].itemid)..".")
    return true
end