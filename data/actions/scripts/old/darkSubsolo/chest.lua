local config = {
    storageCompleted = "90517",

    winActionId = {
        [53614] = {itemid = 8918, amount = 1},
        [53615] = {itemid = 6300, amount = 1}
    },

    posExit = {x=86,y=735,z=9}
}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    doTeleportCreature(cid, config.posExit, 10)

    if getPlayerStorageValue(cid, config.storageCompleted) == 1 then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You already completed this quest.")
        return true
    end

    local prizeItem = doPlayerAddItem(cid, config.winActionId[item.actionid].itemid, config.winActionId[item.actionid].amount)
    doSendMagicEffect(getThingPos(cid), 29)
    setPlayerStorageValue(cid, config.storageCompleted, 1)
	
	local finalExp = getExperienceForLevel(181) - getExperienceForLevel(180)
	doPlayerAddExperience(cid, finalExp)
	doSendAnimatedText(getCreaturePosition(cid), finalExp, 215)
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você recebeu "..finalExp.." pontos de experiência e "..config.winActionId[item.actionid].amount.."x "..getItemNameById(config.winActionId[item.actionid].itemid)..".")
    return true
end