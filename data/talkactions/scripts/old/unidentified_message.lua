function onSay(cid, words, param, channel)
  local param = string.explode(param, ",")

  if param[1] == nil or param[2] == nil then
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Incorrect parameter. Type /msg nickname, message")
    return true
  end

  local texto = param[2]
  local player = getPlayerByNameWildcard(param[1])

  if not player then
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Jogador offline.")
    return true
  end
  doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "[Message from the Gamemaster]: " ..texto)
  doPlayerSendTextMessage(player, MESSAGE_STATUS_CONSOLE_RED, "[Message from the Gamemaster]: " ..texto)

  return true
end