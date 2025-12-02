local effects = {5, 86, 76, 36}
local itemSeachId = 1949

function onTextEdit(cid, item, newText)  
  if item.itemid ~= itemSeachId then
    return true
  end

  if not isPremium(cid) then
    sendBlueMessage(getLangString(cid, WITHOUTPREMIUM, WITHOUTPREMIUMBR))
    return true
  end

  local targetPlayer = getCreatureByName(newText)

  if isPlayer(targetPlayer) then
    if cid == targetPlayer then
      doPlayerSendCancel(cid, getLangString(cid, "You cannot search yourself.", "Você não pode procurar por você mesmo."))
      return true
    end

    if getPlayerAccess(targetPlayer) > 3 then
      doPlayerSendCancel(cid, getLangString(cid, "You cannot search the staff.", "Você não pode procurar por membros da equipe."))
      return true
    end
    
    local currentEffect = effects[getPlayerVocation(cid)]

    if currentEffect then
    local mypos = getThingPos(cid)
    local hispos = getThingPos(targetPlayer)
      local totalPoses = getPoses(mypos, hispos)
      local currentZPos = getThingPos(cid).z

      if totalPoses ~= true then
        for x = 1, #totalPoses do
          totalPoses[x].z = currentZPos
          doSendMagicEffect(totalPoses[x], currentEffect, cid)

          if x >= 100 then
            break
          end
        end
      end
      doRemoveItem(item.uid, 1)
        local andaresStr = "no mesmo andar que você"
    if hispos.z < mypos.z then 
      local dif = mypos.z - hispos.z
      local difStr = dif == 1 and "andar" or "andares"
      andaresStr = dif .. " "..difStr.." acima de você"
    elseif hispos.z > mypos.z then 
      local dif = hispos.z - mypos.z
      local difStr = dif == 1 and "andar" or "andares"
      andaresStr = dif .. " "..difStr.." abaixo de você"
    end 
    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, ""..getCreatureName(targetPlayer).." está à "..getDistanceBetween(hispos, mypos).."sqm de distância e "..andaresStr..".")
    else
      sendBlueMessage(cid, "Error 1872 (creature/script/exivaPlayer.lua) -> Please send it to gamemaster.")
    end
  else
    doPlayerSendCancel(cid, getLangString(cid, "A player with this name is not online.", "O player requisitado não está online ou não existe."))
  end
  return true
end