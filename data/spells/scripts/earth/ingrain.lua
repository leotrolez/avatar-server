local spellName = "earth ingrain"
local cf = {heal = spellsInfo[spellName].heal, segundos = spellsInfo[spellName].segundos}

local MyLocal = {}
MyLocal.threeId = 13846
MyLocal.playersCantUse = {}
MyLocal.time = cf.segundos
MyLocal.interval = 1

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)

local condition = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(condition, CONDITION_PARAM_TICKS, MyLocal.time*1000)
setConditionParam(condition, CONDITION_PARAM_SKILL_SHIELD, 100)
addCombatCondition(combat, condition)


local function stopIngrain(info)
      local cid = info.cid
      local pos = info.pos
      removeTileItemById(pos, MyLocal.threeId)


end

local function healingIngrain(info)
      if isCreature(info.cid) == false then
         stopIngrain(info)
         return false
      end

      local timeEnd = info.timeEnd
      local cid = info.cid
      local pos = getCreaturePosition(cid)
      local magicEffect = 130
      local heal = getCreatureMaxHealth(cid)*0.047
      local atk = cf.heal
    if atk and type(atk) == "number" then 
      heal = heal * (atk/100)
    end

      doCreatureAddHealth(cid, heal)
      doSendMagicEffect({x=pos.x+1, y=pos.y+1, z=pos.z}, magicEffect)
      if timeEnd <= os.time() then
         --stopIngrain(info)
        -- doCreatureSetNoMove(cid, false)
    -- doPlayerCancelFollow(cid)
      else
          addEvent(healingIngrain, MyLocal.interval*1000, info)
      end

end

function onCastSpell(creature, var)
	local cid = creature:getId()
    if getSpellCancels(cid, "earth") == true then
        return false
    end
   if MyLocal.playersCantUse[cid] == nil then
      if getPlayerExaust(cid, "earth", "ingrain") == false then
        return false
      end
      if getPlayerHasStun(cid) then
      if getDobrasLevel(cid) >= 14 then
        doPlayerAddExaust(cid, "earth", "ingrain", earthExausted.ingrain-9)
      else
        doPlayerAddExaust(cid, "earth", "ingrain", earthExausted.ingrain)
      end
          return true
      end
      local position = getCreaturePosition(cid)
      local magicEffect = 50
     -- setCreatureNoMoveTime(cid, (MyLocal.time+MyLocal.interval)*1000)
    --doPlayerCancelFollow(cid)
  exhaustion.set(cid, "AirBarrierReduction", (MyLocal.time+MyLocal.interval))
      --workAllCdAndAndPrevCd(cid, "earth", "ingrain", (MyLocal.time+MyLocal.interval)*1000, 1)
     -- doCreateItem(MyLocal.threeId, position)
      MyLocal.playersCantUse[cid] = true
      addEvent(healingIngrain, 200, {cid = cid, timeEnd = os.time()+MyLocal.time, pos = position, magicEffect = magicEffect})
      doCombat(cid, combat, var)
          MyLocal.playersCantUse[cid] = nil
      if getDobrasLevel(cid) >= 14 then
      doPlayerAddExaust(cid, "earth", "ingrain", 7+earthExausted.ingrain-9)
      else
      doPlayerAddExaust(cid, "earth", "ingrain", 7+earthExausted.ingrain)
      end
		exhaustion.set(cid, "canturecover", 3)
      return true
   else
      doPlayerSendCancelEf(cid, "You're already using this fold.")
      return false
   end
end