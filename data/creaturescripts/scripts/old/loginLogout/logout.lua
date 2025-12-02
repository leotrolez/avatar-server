saida = {
  logout = function(cid)
    local pos = getThingPos(cid)
    setPlayerStorageValue(cid, "onMoveFlyPosX", pos.x)
    setPlayerStorageValue(cid, "onMoveFlyPosY", pos.y)
    setPlayerStorageValue(cid, "onMoveFlyPosZ", pos.z)
  end,
  login = function(cid)
    local oldPos = {x=getPlayerStorageValue(cid, "onMoveFlyPosX"), y=getPlayerStorageValue(cid, "onMoveFlyPosY"), z=getPlayerStorageValue(cid, "onMoveFlyPosZ")}
    local currentPos = getThingPos(cid)

    if getPlayerStorageValue(cid, "playerOnAir") == 1 and not comparePoses(currentPos, oldPos) then
      if getPlayerStorageValue(cid, "playerCantDown") == 1 then
        if getPlayerSex(cid) == 0 then
                doAddCondition(cid, conditionVoarFemale)
            else
                doAddCondition(cid, conditionVoarMale)
            end
          end
      doCreateTile(460, oldPos)
      doTeleportThing(cid, oldPos)
    end

    if not hasSqm(currentPos) then
           doCreateTile(460, oldPos)
         doTeleportThing(cid, oldPos)
      end
  end,
  
  death = function(cid)
    setPlayerStorageValue(cid, "playerOnAir", -1)
  end
}

function onLogout(cid, forceLogout)
  if not forceLogout and getPlayerStorageValue(cid, "ativoBot") == 1 and os.time()-4 < getPlayerStorageValue(cid, "horarioBot") then
    doPlayerSendCancel(cid, getLangString(cid, "You cant logout now, you have an anti-bot question active.", "Você não pode deslogar antes de responder ao !antibot."))
    return false 
  end
  local posicao = getThingPos(cid)
  doSendMagicEffect({x=posicao.x+1, y=posicao.y+1, z=posicao.z}, 119)
  saida.logout(cid)
  dismountPlayer(cid)
  local guid = getPlayerGUID(cid)
  if getPlayerStorageValue(cid, "isPromoted") == 1 then
    addEvent(function(guid) db.executeQuery('UPDATE `players` SET `questpromotion` = "1" WHERE `id` = "'..guid..'"') end, 100, guid)
  end
  return true
end