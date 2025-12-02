local rewards = {12949, 12880, 12916, 12927, 13456, 12804, 12859, 12864}
 
 
local function doPlayerAddRandomReward(cid, items)
        if type(items) ~= "table" then return false end
       
        local ite = math.random(1, #items)
        for i,v in pairs (items) do
                if i == ite then
                        doPlayerAddItem(cid, v)
                        return true
                end
        end
        return false
end
 
function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
        if getPlayerLevel(cid) < 45 then
                return doPlayerSendCancel(cid, getLangString(cid, "Not enough level.", "Você não tem level suficiente."))
        end
        local stor = getPlayerStorageValue(cid, item.actionid)
        if stor == -1 then
                doPlayerAddRandomReward(cid, rewards)
                setPlayerStorageValue(cid, item.actionid, 1)
                return doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "You have found an item.", "Você encontrou um item."))
        else
                return doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, getLangString(cid, "The chest is empty.", "Esse chest está vazio."))
        end
        return true
end