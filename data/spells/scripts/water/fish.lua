local MyLocal = {}
MyLocal.players = {}
MyLocal.fishId = 2667

local combat1 = createCombatObject()

local arr = {
  {1, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1}, 
  {0, 0, 0, 0, 3, 0, 0, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat1, area)


function onTargetTile(creature, pos)
	local cid = creature:getId()
    if isAvaliableTileWaterByPos(pos) then
        table.insert(MyLocal.players[cid].poses, pos)
    end
end

setCombatCallback(combat1, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local function removeTable(cid, exaust)
    if exaust then
        doPlayerAddExaust(cid, "water", "fish", waterExausted.fish)
    end
    MyLocal.players[cid] = nil
end

local function sendEffectOnPoses(cid, poses, isEnd)
    if not isCreature(cid) then
        return false
    end

    for x = 1, #poses do
        if math.random(1, 10) > 7 then
            doSendMagicEffect(poses[x], 70)
            if math.random(1, 5) == 1 then
                doPlayerAddItem(cid, MyLocal.fishId)
            end 
        end
    end

    if isEnd then
        removeTable(cid, true)    
    end
end

function onCastSpell(creature, var)
	local cid = creature:getId()
   if getSpellCancels(cid, "water") == true then
       return false
   end

   if getPlayerExaust(cid, "water", "fish") == false then 
       return false
   end

   if MyLocal.players[cid] ~= nil then
       doPlayerSendCancelEf(cid, "You're already using this fold.")
       return false
   end

   MyLocal.players[cid] = {poses = {}}
   doCombat(cid, combat1, var)

   if #MyLocal.players[cid].poses > 4 then
       if not canUseWaterSpell(cid, nil, 1, true) then
           removeTable(cid)
           return false
       end

       if getPlayerHasStun(cid) then
           removeTable(cid, true)
           workAllCdAndAndPrevCd(cid, "water", "fish", nil, 1)
           return true
       end

       local newList = shuffleList(MyLocal.players[cid].poses)
       setCreatureNoMoveTime(cid, 5*1000)
       for x = 0, 5 do
           addEvent(sendEffectOnPoses, 1000*x, cid, newList, x == 5)
       end
       workAllCdAndAndPrevCd(cid, "water", "fish", 5, 1)
       return true
   else
       doPlayerSendCancelEf(cid, "You must be looking for some great water source.")
       removeTable(cid)
       return false
   end
end