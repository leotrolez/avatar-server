local itemDelay1 = 450

local spellName = "earth jump"
local cf = {
    duracao = spellsInfo[spellName].duracao
}

local MyLocal = {}
MyLocal.players = {}

local function doRemoveTable(cid)
    if isCreature(cid) then
        if getDobrasLevel(cid) >= 4 then
            doPlayerAddExaust(cid, "earth", "jump", earthExausted.jump - 2)
        else
            doPlayerAddExaust(cid, "earth", "jump", earthExausted.jump)
        end
        --    MyLocal.players[cid] = nil
    end
end

function onCastSpell(creature, var)
    local cid = creature:getId()
    if not (isPlayer(cid)) then
        return false
    end
    if exhaustion.check(cid, "earthCursed") and exhaustion.get(cid, "earthCursed") >= 2 then
        doPlayerSendCancelEf(cid, "You can't use this fold while earth cursed.")
        return false
    end
    if exhaustion.check(cid, "airtrapped") then
        doPlayerSendCancelEf(cid, "You can't use this fold right now.")
        return false
    end

    local playerPos = getCreaturePosition(cid)
    if hasSqm({
        x = playerPos.x,
        y = playerPos.y,
        z = playerPos.z - 1
    }) then
        doPlayerSendCancelEf(cid, "You can't use this fold in closed places.")
        return false
    end

    if getSpellCancels(cid, "earth") == true then
        return false
    end

    if getPlayerExaust(cid, "earth", "jump") == false then
        return false
    end

    --       if MyLocal.players[cid] ~= true then
    -- workAllCdAndAndPrevCd(cid, "air", "jump", cf.duracao, 1)
    --         MyLocal.players[cid] = true
    doRemoveTable(cid)
    if getPlayerHasStun(cid) then
        return true
    end
    local position = getPlayerPosition(cid)
    local stoneId = 8046
    local stoneId1 = 18149
    dismountPlayer(cid)

    doSendMagicEffect(position, 83)
    if doPlayerAddUp(cid, false) then
        --doCreateTiles(459, getPlayerPosition(cid), 5000)
        local stoneUid = doCreateItem(stoneId, 1, position)
        addEvent(doCreateItem, itemDelay1, stoneId1, 1, position)
        addEvent(removeTileItemById, 5000, position, stoneId1)
        addEvent(removeTileItemById, 5000, position, stoneId)
        -- doDecayItem(stoneUid)
        addEvent(function()
            if isCreature(cid) then
                doPlayerDown(cid, false)
            end
        end, 5000)
        return true
    else
        local stoneUid = doCreateItem(stoneId, 1, position)
        addEvent(doCreateItem, itemDelay1, stoneId1, 1, position)
        addEvent(removeTileItemById, 5000, position, stoneId1)
        addEvent(removeTileItemById, 5000, position, stoneId)
        -- doDecayItem(stoneUid)
        return true
    end
    --    else
    --         doPlayerSendCancelEf(cid, "You're already using this fold.")
    --         return false
    --   end
end
