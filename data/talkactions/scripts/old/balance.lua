function onSay(cid, words, param, channel)
  local guild = getPlayerGuildId(cid)
  if not guild or guild == 0 or getPlayerGuildLevel(cid) < GUILDLEVEL_LEADER then
    doPlayerSendChannelMessage(cid, "[GUILDBANK]", "Você não pode executar esta ação.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
    return true
  end

  local parametro = string.explode(param, ' ', 1)
  if parametro[1] == "pick" then  
    if not parametro[2] then
      doPlayerSendChannelMessage(cid, "[GUILDBANK]", "Insira algum valor.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    end

    local value = tonumber(parametro[2])
    if not value or value < 1 then
      doPlayerSendChannelMessage(cid, "[GUILDBANK]", "Insira valores válidos.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    elseif string.len(value) > 7 then
      doPlayerSendChannelMessage(cid, "[GUILDBANK]", "Este valor está acima do limite.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    elseif value > 9999999 then
      doPlayerSendChannelMessage(cid, "[GUILDBANK]", "Este valor está acima do limite.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    end
  
    local result = db.getResult('SELECT `balance` FROM `guilds` WHERE `id` = ' .. guild)
    if result:getID() == -1 then
      return false
    end

    local balance = result:getDataLong('balance')
    balance = balance > 0 and balance or 0
    result:free()
  
    if value == 0 or value > balance then
      doPlayerSendChannelMessage(cid, '[GUILDBANK]', 'O banco da sua guild não possui o saldo que você deseja retirar.', TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    end
  
    if not db.executeQuery('UPDATE `guilds` SET `balance` = `balance` - ' .. value .. ' WHERE `id` = ' .. guild .. ' LIMIT 1;') then
      return false
    end

    doPlayerAddMoney(cid, value)
    doPlayerSendChannelMessage(cid, '[GUILDBANK]', 'Você retirou ' .. value .. ' gold coins do saldo do banco da sua guild.', TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)

  elseif parametro[1] == "donate" then  
    if not parametro[2] then
      doPlayerSendChannelMessage(cid, "[GUILDBANK]", "Insira algum valor.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    end

    local value = tonumber(parametro[2])
    if not value or value < 1 then
      doPlayerSendChannelMessage(cid, "[GUILDBANK]", "Insira valores válidos.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    elseif string.len(value) > 7 then
      doPlayerSendChannelMessage(cid, "[GUILDBANK]", "Este valor está acima do limite.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    elseif value > 9999999 then
      doPlayerSendChannelMessage(cid, "[GUILDBANK]", "Este valor está acima do limite.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    end

    if getPlayerMoney(cid) < value then
      doPlayerSendChannelMessage(cid, '[GUILDBANK]', 'Você não tem dinheiro suficiente.', TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    end

    if not doPlayerRemoveMoney(cid, value) then
      return false
    end

    db.executeQuery('UPDATE `guilds` SET `balance` = `balance` + ' .. value .. ' WHERE `id` = ' .. guild .. ' LIMIT 1;')
    doPlayerSendChannelMessage(cid, '[GUILDBANK]', 'Você transferiu ' .. value .. ' gold coins para o saldo do banco da sua guild.', TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
  else
    local result = db.getResult('SELECT `balance` FROM `guilds` WHERE `id` = ' .. guild)
    if(result:getID() == -1) then
      return false
    end

    doPlayerSendChannelMessage(cid, '[GUILDBANK]', 'O saldo do banco da sua guild é ' .. result:getDataLong('balance') .. ' gold coins.', TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
    result:free()
  end

  return true
end