local MyLocal = {}
MyLocal.jumps = 5
MyLocal.walktime = 300
MyLocal.spikeVertical ={8392, 8396}
MyLocal.spikeHorizontal = {8391, 8397}
MyLocal.time = 5
MyLocal.players = {}


local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TARGETCASTERORTOPMOST, 1)
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 50)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -1, -10, -1, -15, 5, 5, 1.8, 3, -20, -40) 

local arr = {
{0, 3, 0}
}

local area = createCombatArea(arr)
setCombatArea(combat, area)    
        

local function spikes(cid, pos, jumps, dir)
  local jumps = jumps or 0
  if (jumps < MyLocal.jumps) then
    local effectPos = pos or getCreaturePosition(cid)
    local newPos = getPosByDir(effectPos, dir)
    local itemId = MyLocal.spike

    if dir+1 == 1 or dir+1 == 3 then
      for x = 1, #MyLocal.spikeHorizontal do
        doCreateItem(MyLocal.spikeHorizontal[x], newPos)
        addEvent(removeTileItemById, MyLocal.time*1000, newPos, MyLocal.spikeHorizontal[x]) 
      end
    else
      for x = 1, #MyLocal.spikeVertical do
        doCreateItem(MyLocal.spikeVertical[x], newPos)
        addEvent(removeTileItemById, MyLocal.time*1000, newPos, MyLocal.spikeVertical[x]) 
      end
    end
    addEvent(spike, MyLocal.walktime, cid, newPos, jumps+1, dir)
    doCombat(cid, combat, {pos = newPos, type = 2})
  else
    MyLocal.players[cid] = nil
  end
end 

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end
  if MyLocal.players[cid] == nil then
    if doPlayerAddExaust(cid, "earth", "spikes", earthExausted.spikes) == false then
      return false
    end
    MyLocal.players[cid] = true
    spikes(cid, nil, nil, getCreatureLookDirection(cid))   
    return true
  else
    doPlayerSendCancelEf(cid, "You're already using this fold.")
    return false
  end
end  