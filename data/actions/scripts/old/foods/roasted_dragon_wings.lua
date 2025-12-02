local condition = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(condition, CONDITION_PARAM_TICKS, 60 * 60 * 1000)
setConditionParam(condition, CONDITION_PARAM_SKILL_SHIELD, 10)

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  local food = SPECIAL_FOODS[item.itemid]
  if(food == nil) then
    return false
  end

  if(not doAddCondition(cid, condition)) then
    return true
  end

  doRemoveItem(item.uid, 1)
  doCreatureSay(cid, food, TALKTYPE_MONSTER)
  return true
end
