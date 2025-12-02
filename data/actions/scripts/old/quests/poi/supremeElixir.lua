local elixirExp = 100000
local levelMin = 50

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
    if getPlayerLevel(cid) < levelMin then
        doPlayerSendCancel(cid, getLangString(cid, "You need be level "..levelMin.." or higher to use this potion.", "Você precisa ter level "..levelMin.." ou mais para usar essa potion."))
        return true
    end


    doPlayerAddExperience(cid, elixirExp)
    doSendAnimatedText(getPlayerPosition(cid), elixirExp, TEXTCOLOR_WHITE)
    doSendMagicEffect(getThingPos(cid), 28)
    doRemoveItem(item.uid, 1)
    return true
end