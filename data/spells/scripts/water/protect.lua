local spellName = "water protect"
local cf = {duracao = spellsInfo[spellName].duracao}

local MyLocal = {}
MyLocal.players = {}

local function removeTable(cid, exaust)
    if exaust then
		if getDobrasLevel(cid) >= 16 then
			--doPlayerAddExaust(cid, "water", "protect", waterExausted.protect-12)
		else
			--doPlayerAddExaust(cid, "water", "protect", waterExausted.protect)
		end
    end
    MyLocal.players[cid] = nil
end

local function sendsProtectionEffect(cid, id)
    if not isCreature(cid) then
        return false
    end
    
    local pos = getThingPos(cid)
    doSendMagicEffect({x=pos.x, y=pos.y, z=pos.z}, 75)

    if id < cf.duracao/250 then
        addEvent(sendsProtectionEffect, 380, cid, id+1)
    else
        removeTable(cid, true) 
    end  
end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "water") == true then
        return false
    end

    if getPlayerExaust(cid, "water", "protect") == false then
        return false
    end

    if canUseWaterSpell(cid, 1, 3, false) then
        --workAllCdAndAndPrevCd(cid, "water", "protect", nil, 1)
		if getDobrasLevel(cid) >= 16 then
			doPlayerAddExaust(cid, "water", "protect", waterExausted.protect-13) 
		else
			doPlayerAddExaust(cid, "water", "protect", waterExausted.protect) 
		end
        if getPlayerHasStun(cid) then
            return true
        end
      sendsProtectionEffect(cid, 1)
      setPlayerHasImune(cid, cf.duracao/1000)
      return true
   else
      return false
   end
end 