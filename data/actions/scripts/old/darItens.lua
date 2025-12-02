function onUse(cid, item, frompos, item2, topos)
    if getPlayerLevel(cid) < 150 then
        doPlayerSendCancel(cid, getLangString(cid, "You need have level 150 to do this quest.", "Você precisa ter level 150 para fazer essa quest."))
        return true
    end
    if item.uid == 62110 then
        if getPlayerStorageValue(cid,62110) == -1 then
            doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "You have found a bag.", "Você encontrou uma bag."))
            local bag = doPlayerAddItem(cid,1993,1)
           -- doAddContainerItem(bag,12466,10)
            --doAddContainerItem(bag,12753,2)
           -- doAddContainerItem(bag,12754,1)
            setPlayerStorageValue(cid,62110,1)
        else
            doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "The chest is empty.", "Esse chest está vazio."))
        end
    end
    return true
end