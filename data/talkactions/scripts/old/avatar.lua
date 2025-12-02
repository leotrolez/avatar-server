function onSay(cid, words, param, channel)
  local avatar = getStorage(73991)
  if avatar > 0 then
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "O Avatar atual é o dobrador: " ..getPlayerNameByGUID(avatar).. ".")
  else
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "O Avatar ainda não foi escolhido.")
  end
  return true
end