local spellName = "earth armor"
local cf = {
    duracao = spellsInfo[spellName].duracao
}

local MyLocal = {}
MyLocal.players = {}

local function removeTable(cid, exaust)
    if exaust then
        if getDobrasLevel(cid) >= 16 then
            -- doPlayerAddExaust(cid, "earth", "armor", earthExausted.armor-14)
        else
            -- doPlayerAddExaust(cid, "earth", "armor", earthExausted.armor)
        end
    end
    MyLocal.players[cid] = nil
end

local function sendsArmorionEffect(cid, id)
    if not isCreature(cid) then
        return false
    end

    doSendMagicEffect(getThingPos(cid), 124)
    doSendMagicEffect(getThingPos(cid), 113)

    if id < cf.duracao then
        addEvent(sendsArmorionEffect, 250, cid, id + 250)
    else
        removeTable(cid, true)
    end
end

function onCastSpell(creature, var)
    local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end
    if getDobrasLevel(cid) >= 19 then
        if (doPlayerAddExaust(cid, "earth", "armor", earthExausted.armor - 14)) == false then
            return false
        end
    else
        if (doPlayerAddExaust(cid, "earth", "armor", earthExausted.armor)) == false then
            return false
        end
    end
    if getPlayerHasStun(cid) then
        return true
    end
    sendsArmorionEffect(cid, 1)
    setPlayerHasImune(cid, cf.duracao / 1000)
    setCreatureNoMoveTime(cid, 10000)
    return true
end
