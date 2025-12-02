local valores = {10, 22, 46, 68, 84, 120, 240}

local function rewardByValor(cid, valor, adm)
  if valor == valores[1] then
    db.query("UPDATE `accounts` SET `premium_points` = '".. getPlayerCoins(cid) + 10 .."' WHERE `id` = " .. getPlayerAccountId(cid) .. ";")
  elseif valor == valores[2] then
    db.query("UPDATE `accounts` SET `premium_points` = '".. getPlayerCoins(cid) + 27 .."' WHERE `id` = " .. getPlayerAccountId(cid) .. ";")
    doPlayerAddItem(cid, 12830, 1)
  elseif valor == valores[3] then
    db.query("UPDATE `accounts` SET `premium_points` = '".. getPlayerCoins(cid) + 61 .."' WHERE `id` = " .. getPlayerAccountId(cid) .. ";")
    doPlayerAddItem(cid, 12830, 1) -- bless pot
    doPlayerAddItem(cid, 12754, 1) -- exp pot
  elseif valor == valores[4] then
    db.query("UPDATE `accounts` SET `premium_points` = '".. getPlayerCoins(cid) + 93 .."' WHERE `id` = " .. getPlayerAccountId(cid) .. ";")
    doPlayerAddItem(cid, 12754, 1) -- exp pot
    doPlayerAddItem(cid, 10219, 1) -- sacred life amulet
    doPlayerAddItem(cid, 12781, 1) -- crystal shield
  elseif valor == valores[5] then
    db.query("UPDATE `accounts` SET `premium_points` = '".. getPlayerCoins(cid) + 124 .."' WHERE `id` = " .. getPlayerAccountId(cid) .. ";")
    doPlayerAddItem(cid, 12754, 3) -- 3x exp pot
    doPlayerAddItem(cid, 10219, 1) -- sacred life amulet
    doPlayerAddItem(cid, 12781, 1) -- crystal shield
  elseif valor == valores[6] then
    db.query("UPDATE `accounts` SET `premium_points` = '".. getPlayerCoins(cid) + 190 .."' WHERE `id` = " .. getPlayerAccountId(cid) .. ";")
    doPlayerAddItem(cid, 12754, 3) -- 3x exp pot
    doPlayerAddItem(cid, 10219, 1) -- sacred life amulet
    doPlayerAddItem(cid, 17822, 1) -- mysterious box
    doPlayerAddItem(cid, 13914, 1) -- crystal legs
    doPlayerAddItem(cid, 17961, 1) -- night waccoon
    doPlayerAddItem(cid, 12781, 1) -- crystal shield
    doPlayerAddItem(cid, 12781, 1) -- crystal shield
  elseif valor == valores[7] then
    db.query("UPDATE `accounts` SET `premium_points` = '".. getPlayerCoins(cid) + 430 .."' WHERE `id` = " .. getPlayerAccountId(cid) .. ";")
    doPlayerAddItem(cid, 12754, 7) -- 7x exp pot
    doPlayerAddItem(cid, 10219, 1) -- sacred life amulet
    doPlayerAddItem(cid, 10503, 1) -- lucky box
    doPlayerAddItem(cid, 10503, 1) -- lucky box
    doPlayerAddItem(cid, 13914, 1) -- crystal legs
    doPlayerAddItem(cid, 17961, 1) -- night waccoon
    doPlayerAddItem(cid, 17970, 1) -- night waccoon
    doPlayerAddItem(cid, 12781, 1) -- crystal shield
    doPlayerAddItem(cid, 12781, 1) -- crystal shield
    doPlayerAddItem(cid, 12781, 1) -- crystal shield
    doPlayerAddItem(cid, 12781, 1) -- crystal shield
  else
    doPlayerSendTextMessage(adm, MESSAGE_STATUS_CONSOLE_BLUE, "[Erro] Este pacote não possui itens na lista. Revisar código.")
  end
end

function onSay(cid, words, param, channel)
  local param = string.explode(param, ",")

  if param[1] == nil or param[2] == nil then
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Parâmetro incorreto. Digite /pacote Nick, valor - Lembre-se que o valor é o BRL equivalente aos pacotes do pagseguro.")
    return true
  end
  local nick = param[1]
  local valor = tonumber(param[2])
  if not isInArray(valores, valor) then
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Valor não consta na lista. Os pacotes são: 10, 22, 46, 68, 84, 120 e 240 (equivalente em BRL).")
    return true
  end
  local player = getPlayerByNameWildcard(nick)
  if not player then
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, ""..nick.." está offline no momento.")
    return true
  end
  rewardByValor(player, valor, cid)
  doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Os itens referentes ao pacote de "..valor.." R$ foram entregues à "..nick..".")
  doPlayerSendTextMessage(player, MESSAGE_STATUS_CONSOLE_RED, "[Donate] You received new items, check your backpack. New elemental coins was been received too, check your webshop. Thank you for supporting Avatar!")
  return true
end