local function checkBossAlive()
local specs = getSpectators({x = 438, y = 1478, z = 7}, 15, 15)
  if specs and #specs > 0 then 
    for i = 1, #specs do 
      if isMonster(specs[i]) and getCreatureName(specs[i]) == "Draptor" then 
        return true
      end 
    end 
  end 
  return false
end 
function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
  if getPlayerStorageValue(cid, "90526i1") == 1 then  
    doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já pegou esta recompensa.")
    return true
  elseif checkBossAlive() then  
    doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você precisa derrotar o Draptor.")
    return true
  end 
    setPlayerStorageValue(cid, "90526i1", 1)
   doSendMagicEffect(getThingPos(cid), 29)
   
  doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Você completou a Draptor Quest. Como recompensa, todos os danos da suas dobras foram aumentados em 5%.")
    return true
end