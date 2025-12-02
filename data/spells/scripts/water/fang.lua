local MyLocal = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_POISONDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 8)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 14)
setCombatParam(combat, COMBAT_PARAM_CREATEITEM, 1496)

function onTargetTile(creature, pos)
	local cid = creature:getId()
    addEvent(removeTileItemById, 100, pos, 1496)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end

    if getPlayerExaust(cid, "water", "fang", waterExausted.fang) == false then
        return false
    end
    local target = getCreatureTarget(cid)
    
    if target > 0 then
        local targetPos = getThingPos(target)
        local playerPos = getThingPos(cid)

        if getDistanceBetween(targetPos, playerPos) < 3 then
            if canUseWaterSpell(cid, 1, 3, false) then
                doPlayerAddExaust(cid, "water", "fang", waterExausted.fang)
                if getPlayerHasStun(cid) then
                    workAllCdAndAndPrevCd(cid, "water", "fang", nil, 1)
                    return true
                end
                workAllCdAndAndPrevCd(cid, "water", "fang", nil, 1)
                return doCombat(cid, combat, {type=2, pos=targetPos})
            else
                return false 
            end
        else
            doPlayerSendCancelEf(cid, "Creature is not reachable.")
            return false
        end
    else
        doPlayerSendCancelEf(cid, "You can only use it on creatures.")
        doSendMagicEffect(getThingPos(cid), 2)    
    end
end
