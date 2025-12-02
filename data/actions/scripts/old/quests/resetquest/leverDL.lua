dofile("data/actions/scripts/old/quests/resetquest/const.lua")

local isOpen = {
    [3485] = false,
    [3486] = false
}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    if not isOpen[item.actionid] then
        local stonePos = leverDL.poses[item.actionid]
        removeTileItemByIds(stonePos, {leverDL.stoneID}, 3)
        isOpen[item.actionid] = true
        doTransformLever(item)
        sendBlueMessage(cid, getLangString(cid, "You have removed one Protect Stone.", "Voc� removeu uma Protect Stone."))
    else
        doPlayerSendCancel(cid, getLangString(cid, "This Protect Stone is already broken.", "Essa Protect Stone j� est� quebrada."))
    end

    return true
end