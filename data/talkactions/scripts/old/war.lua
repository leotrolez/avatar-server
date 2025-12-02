local config = {
  storageExhaustion = 7485,
  storageExhaustionEnd = 7486
}

local function setExhaustion(uid, time)
  return doCreatureSetStorage(uid, config.storageExhaustion, time + os.time())
end

local function getExhaustion(uid)
  local storage = getCreatureStorage(uid, config.storageExhaustion)
  if storage <= 0 then
    return 0
  end
  return storage - os.time()
end

local function setExhaustionEnd(uid, time)
  return doCreatureSetStorage(uid, config.storageExhaustionEnd, time + os.time())
end

local function getExhaustionEnd(uid)
  local storage = getCreatureStorage(uid, config.storageExhaustionEnd)
  if storage <= 0 then
    return 0
  end
  return storage - os.time()
end

local function msgAllWarMembers(guild_id, enemy_id, msg)
  for _, uid in pairs(getPlayersOnline()) do
    if getPlayerGuildId(uid) == guild_id or getPlayerGuildId(uid) == enemy_id then
      doPlayerSendTextMessage(uid, MESSAGE_STATUS_CONSOLE_BLUE, "[GUILDWAR]: ".. msg)
    end
  end
end

function onSay(cid, words, param, channel)
  local guild = getPlayerGuildId(cid)
  local parametro = string.explode(param, ",")
  if parametro[1] == "placar" then
    local database = db.getResult("SELECT `enemy_id`, `guild_kills`, `enemy_kills` FROM `guild_wars` WHERE `guild_id` = " .. guild .." AND `status` = 1")
    if database:getID() == -1 then
      local database2 = db.getResult("SELECT `guild_id`, `guild_kills`, `enemy_kills` FROM `guild_wars` WHERE `enemy_id` = " .. guild .." AND `status` = 1")
      if database2:getID() == -1 then
        doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Sua guild não está em guerra.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
        return true
      end

      local enemyId = database2:getDataInt("guild_id")
      local guildKills = database2:getDataInt("guild_kills")
      local enemyKills = database2:getDataInt("enemy_kills")
      database2:free()

      local enemyName, database2 = "", db.getResult("SELECT `name` FROM `guilds` WHERE `id` = " .. enemyId)
      if database2:getID() == -1 then
        return true
      end
      enemyName = database2:getDataString("name")
      database2:free()

      doPlayerSendChannelMessage(cid, "[GUILDWAR]", "".. enemyName .." ".. guildKills .. " x ".. enemyKills .." ".. getPlayerGuildName(cid) ..".", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    end
    local enemyId = database:getDataInt("enemy_id")
    local guildKills = database:getDataInt("guild_kills")
    local enemyKills = database:getDataInt("enemy_kills")
    database:free()

    local enemyName, database = "", db.getResult("SELECT `name` FROM `guilds` WHERE `id` = " .. enemyId)
    if database:getID() == -1 then
      return true
    end
    enemyName = database:getDataString("name")
    database:free()

    doPlayerSendChannelMessage(cid, "[GUILDWAR]", "".. getPlayerGuildName(cid) .." ".. guildKills .. " x ".. enemyKills .." ".. enemyName ..".", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
    return true
  end

  if not guild or guild == 0 or getPlayerGuildLevel(cid) < GUILDLEVEL_LEADER then
    doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Você não pode executar esta ação.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
    return true
  elseif getExhaustion(cid) > 0 then
    doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Você está exhausted.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
    return true
  end

  if not parametro[2] then
    doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Parâmetro incorreto.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
    return true
  end

  local enemy = getGuildId(parametro[2])
  if not enemy then
    doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Esta guild não existe.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
    return true
  end

  if enemy == guild then
    doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Você não pode invitar sua própria guild para uma guerra.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
    return true
  end

  local enemyName, database = "", db.getResult("SELECT `name` FROM `guilds` WHERE `id` = " .. enemy)
  if database:getID() == -1 then
    return true
  end
  enemyName = database:getDataString("name")
  database:free()

  if isInArray({"accept", "reject", "cancel"}, parametro[1]) then
    local query = "`guild_id` = " .. enemy .. " AND `enemy_id` = " .. guild
    if parametro[1] == "cancel" then
      query = "`guild_id` = " .. guild .. " AND `enemy_id` = " .. enemy
    end

    database = db.getResult("SELECT `id`, `begin`, `end`, `payment` FROM `guild_wars` WHERE " .. query .. " AND `status` = 0")
    if database:getID() == -1 then
      doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Você não tem nenhum convite para uma guerra com a guild " .. enemyName .. ".", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    end

    local beginWar = database:getDataInt("begin")
    local endWar = database:getDataInt("end")
    local idWar = database:getDataInt("id")
    local paymentWar = database:getDataInt("payment")
    database:free()

    if parametro[1] == "accept" then
      local databaseGuild = db.getResult("SELECT `id` FROM `guild_wars` WHERE `guild_id` = " .. guild .." AND `status` = 1")
      if databaseGuild:getID() ~= -1 then
        doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Você não pode aceitar o convite de uma guerra porque já está participando de uma.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
        return true
      end

      databaseGuild = db.getResult("SELECT `id` FROM `guild_wars` WHERE `enemy_id` = " .. guild .." AND `status` = 1")
      if databaseGuild:getID() ~= -1 then
        doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Você não pode aceitar o convite de uma guerra porque já está participando de uma.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
        return true
      end

      databaseGuild = db.getResult("SELECT `id` FROM `guild_wars` WHERE `guild_id` = " .. enemy .." AND `status` = 1")
      if databaseGuild:getID() ~= -1 then
        doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Você não pode aceitar o convite dessa guerra porque o seu oponente já está participando de uma.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
        return true
      end

      databaseGuild = db.getResult("SELECT `id` FROM `guild_wars` WHERE `enemy_id` = " .. enemy .." AND `status` = 1")
      if databaseGuild:getID() ~= -1 then
        doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Você não pode aceitar o convite dessa guerra porque o seu oponente já está participando de uma.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
        return true
      end

      local balanceQuery = db.getResult("SELECT `balance` FROM `guilds` WHERE `id` = " .. guild)
      local state = balanceQuery:getID() < 0 or balanceQuery:getDataInt("balance") < paymentWar
      balanceQuery:free()

      if state then
        doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Você não tem saldo suficiente no banco da sua guild para aceitar o convite dessa guerra.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
        return true
      end

      db.executeQuery("UPDATE `guilds` SET `balance` = `balance` - " .. paymentWar .. " WHERE `id` = " .. guild)
    end

    query = "UPDATE `guild_wars` SET "
    local msg = "aceitou o convite da guild " .. enemyName .. " para uma guerra."
    if parametro[1] == "reject" then
      query = query .. "`end` = " .. os.time() .. ", `status` = 2"
      msg = "rejeitou o convite da guild " .. enemyName .. " para uma guerra."
      db.executeQuery("UPDATE `guilds` SET `balance` = `balance` + " .. paymentWar .. " WHERE `id` = " .. enemy)
    elseif parametro[1] == "cancel" then
      query = query .. "`end` = " .. os.time() .. ", `status` = 3"
      msg = "cancelou o convite para uma guerra que havia feito à guild " .. enemyName .. "."
      db.executeQuery("UPDATE `guilds` SET `balance` = `balance` + " .. paymentWar .. " WHERE `id` = " .. guild)
    else
      query = query .. "`begin` = " .. os.time() .. ", `end` = " .. (endWar > 0 and (os.time() + ((beginWar - endWar) / 86400)) or 0) .. ", `status` = 1"
    end
    query = query .. " WHERE `id` = " .. idWar

    if parametro[1] == "accept" then
      doGuildAddEnemy(guild, enemy, idWar, WAR_GUILD)
      doGuildAddEnemy(enemy, guild, idWar, WAR_ENEMY)
      doBroadcastMessage("[GUILDWAR]: A guild ".. getPlayerGuildName(cid) .. " " .. msg, MESSAGE_EVENT_ADVANCE)
    else
      doPlayerSendChannelMessage(cid, "[GUILDWAR]", "A guild ".. getPlayerGuildName(cid) .. " " .. msg, TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      msgAllWarMembers(guild, enemy, "A guild ".. getPlayerGuildName(cid) .. " " .. msg .."")
    end
    db.executeQuery(query)
    return true
  end

  if parametro[1] == "invite" then
    if not parametro[3] then
      doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Digite a quantidade de frags para invitar a guerra.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    elseif not parametro[4] then
      doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Digite o valor da aposta para invitar a guerra.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    end

    local str = ""
    database = db.getResult("SELECT `guild_id`, `status` FROM `guild_wars` WHERE `guild_id` IN (" .. guild .. "," .. enemy .. ") AND `enemy_id` IN (" .. enemy .. "," .. guild .. ") AND `status` IN (0, 1)")
    if database:getID() ~= -1 then
      if database:getDataInt("status") == 0 then
        if database:getDataInt("guild_id") == guild then
          str = "Você já enviou um convite de guerra para a guild " .. enemyName .. "."
        else
          str = "A guild ".. enemyName .. " já enviou um convite de guerra para a sua guild."
        end
      else
        str = "Você já está em guerra com a guild " .. enemyName .. "."
      end
      database:free()
    end

    setExhaustion(cid, 30)

    if str ~= "" then
      doPlayerSendChannelMessage(cid, "[GUILDWAR]", "".. str, TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    end

    local frags = tonumber(parametro[3])
    if not frags or frags < 1 then
      doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Digite a quantidade de frags para invitar a guerra.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    elseif frags < 10 or frags > 100 then
      doPlayerSendChannelMessage(cid, "[GUILDWAR]", "A quantidade mínima de frags é 10 e a máxima 100.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    end

    local payment = tonumber(parametro[4])
    if not payment or payment < 1 then
      doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Digite a quantidade da aposta para invitar a guerra.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    elseif payment < 100000 or payment > 10000000 then
      doPlayerSendChannelMessage(cid, "[GUILDWAR]", "A quantidade mínima da aposta da guerra é de 100k e a máxima 10kk.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    end

    database = db.getResult("SELECT `balance` FROM `guilds` WHERE `id` = " .. guild)
    local state = database:getID() < 0 or database:getDataInt("balance") < payment
    database:free()

    if state then
      doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Você não tem dinheiro suficiente no banco da sua guild para a aposta.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    end

    db.executeQuery("UPDATE `guilds` SET `balance` = `balance` - " .. payment .. " WHERE `id` = " .. guild)

    local begining, ending = os.time(), 0
    db.executeQuery("INSERT INTO `guild_wars` (`guild_id`, `enemy_id`, `begin`, `end`, `frags`, `payment`, `world_id`) VALUES (" .. guild .. ", " .. enemy .. ", " .. begining .. ", " .. ending .. ", " .. frags .. ", " .. payment .. ", " .. getConfigValue('worldId') .. ");")
    doPlayerSendChannelMessage(cid, "[GUILDWAR]", "A guild ".. getPlayerGuildName(cid) .. " invitou a guild " .. enemyName .. " para uma guerra de " .. frags .. " frags com o valor da premiação em ".. payment .." gold coins.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
    msgAllWarMembers(guild, enemy, "A guild ".. getPlayerGuildName(cid) .. " invitou a guild " .. enemyName .. " para uma guerra de " .. frags .. " frags com o valor da premiação em ".. payment .." gold coins.")
    return true
  end

  if parametro[1] == "end" then
    if getExhaustionEnd(cid) > 0 then
      doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Você está exhausted para finalizar esta guerra.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
      return true
    end

    database = db.getResult("SELECT `id`, `payment` FROM `guild_wars` WHERE `guild_id` = " .. guild .. " AND `enemy_id` = " .. enemy .. " AND `status` = 1")
    if database:getID() ~= -1 then
      local idWar = database:getDataInt("id")
      local paymentWar = database:getDataInt("payment")
      paymentWar = paymentWar * 2
      database:free()

      doGuildRemoveEnemy(guild, enemy)
      doGuildRemoveEnemy(enemy, guild)

      db.executeQuery("UPDATE `guilds` SET `balance` = `balance` + " .. paymentWar .. " WHERE `id` = " .. enemy)
      db.executeQuery("UPDATE `guild_wars` SET `end` = " .. os.time() .. ", `status` = 5 WHERE `id` = " .. idWar)
      doBroadcastMessage("[GUILDWAR]: A guild ".. getPlayerGuildName(cid) .. " terminou antecipadamente a guerra dando a vitória a guild " .. enemyName .. ".", MESSAGE_EVENT_ADVANCE)
      setExhaustionEnd(cid, 900)
      return true
    end

    database = db.getResult("SELECT `id`, `payment` FROM `guild_wars` WHERE `guild_id` = " .. enemy .. " AND `enemy_id` = " .. guild .. " AND `status` = 1")
    if database:getID() ~= -1 then
      local idWar = database:getDataInt("id")
      local paymentWar = database:getDataInt("payment")
      paymentWar = paymentWar * 2
      database:free()

      doGuildRemoveEnemy(guild, enemy)
      doGuildRemoveEnemy(enemy, guild)

      db.executeQuery("UPDATE `guilds` SET `balance` = `balance` + " .. paymentWar .. " WHERE `id` = " .. enemy)
      db.executeQuery("UPDATE `guild_wars` SET `end` = " .. os.time() .. ", `status` = 5 WHERE `id` = " .. idWar)
      doBroadcastMessage("[GUILDWAR]: A guild ".. getPlayerGuildName(cid) .. " terminou antecipadamente a guerra dando a vitória a guild " .. enemyName .. ".", MESSAGE_EVENT_ADVANCE)
      setExhaustionEnd(cid, 900)
      return true
    end

    doPlayerSendChannelMessage(cid, "[GUILDWAR]", "Sua guild não está em guerra.", TALKTYPE_CHANNEL_HIGHLIGHT, CHANNEL_GUILD)
    return true
  end

  return true
end
