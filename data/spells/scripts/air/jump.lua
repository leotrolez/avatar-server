local spellName = "air jump"
local cf = {
    duracao = spellsInfo[spellName].duracao
}

local MyLocal = {}
MyLocal.players = {}

local function sendMagicEff(cid)
    if MyLocal.players[cid] == nil or not isPlayer(cid) then
        return true
    end
    local pos = getThingPos(cid)

    if not comparePoses(pos, MyLocal.players[cid]) then
        return true
    end

    pos.stackpos = 0
    if getThingFromPos(pos).itemid ~= 460 and getThingFromPos(pos).itemid ~= 1 then
        return true
    end

    pos.x = pos.x + 1

    doSendMagicEffect(pos, 67)
    addEvent(sendMagicEff, 500, cid)
end

local function removeTable(cid)
    if isCreature(cid) then
        -- MyLocal.players[cid] = nil
        if getDobrasLevel(cid) >= 4 then
            doPlayerAddExaust(cid, "air", "jump", airExausted.jump - 2)
        else
            doPlayerAddExaust(cid, "air", "jump", airExausted.jump)
        end
    end
end

function onCastSpell(creature, var)
    local cid = creature:getId()
    if not isPlayer(cid) then
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

    if getSpellCancels(cid, "air") == true then
        return false
    end

    if getPlayerExaust(cid, "air", "jump") == false then
        return false
    end

    -- if MyLocal.players[cid] == nil then
    -- workAllCdAndAndPrevCd(cid, "air", "jump", cf.duracao, 1)
    removeTable(cid)
    if getPlayerHasStun(cid) then
        return true
    end

    local position = getPlayerPosition(cid)
    dismountPlayer(cid)
    if doPlayerAddUp(cid, false) then
      --doCreateTiles(459, getPlayerPosition(cid), cf.duracao - 1000)
      MyLocal.players[cid] = {
         x = position.x,
         y = position.y,
         z = position.z - 1
      }
      sendMagicEff(cid)
      doCreateItem(12966, 1, position)
      addEvent(function()
         removeTileItemById(position, 12966)
         if isCreature(cid) then
               doPlayerDown(cid, false)
         end
      end, cf.duracao - 1000)
    end
    return true
    -- else
    --    doPlayerSendCancelEf(cid, "You're already using this fold.")
    --     return false
    --   end
end
