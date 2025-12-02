local strError = 'Você está usando o comando de maneira errada. Exemplo correto: "/add bend, 5", que iria gastar 5 de seus pontos em bend, ou "/add health, 5."'
local atributosList = {"health", "bend", "dodge", "mana"}

local function onAddAtributo(cid, atributo, quantia)
  if atributo == "health" then
    setCreatureMaxHealth(cid, getCreatureMaxHealth(cid, true)+(50*quantia))
  elseif atributo == "bend" then
    doPlayerAddMagicLevel(cid, quantia)
  elseif atributo == "dodge" then
    local oldDodge = getPlayerStorageValue(cid, "AttributesPointsInDodge")
    if oldDodge < 1 then
      oldDodge = 0
    end
    setPlayerStorageValue(cid, "AttributesPointsInDodge", oldDodge+quantia)
    doChangeSpeed(cid, 6*quantia)
  elseif atributo == "speed" then
    setCreatureMaxMana(cid, getCreatureMaxMana(cid, true)+(20*quantia))
    doCreatureAddMana(cid, 1)
  end
end

function getCostByValue(value, att)
  if not tonumber(value) then
    print("[Alerta] getCostByValue retornando 99 em algum caso errado")
    return 99
  end
  if att == "health" or att == "speed" then
    if value <= 15 then
      return 1
    elseif value <= 25 then
      return 2
    elseif value <= 40 then
      return 3
    elseif value <= 50 then
      return 4
    elseif value <= 85 then
      return 5
    else
      return 8
    end
  elseif att == "bend" then
    if value >= 0 and value <= 19 then
      return 1
    elseif value >= 20 and value <= 29 then
      return 2
    elseif value >= 30 and value <= 49 then
      return 4
    elseif value >= 50 and value <= 59 then
      return 7
    elseif value >= 60 and value <= 69 then
      return 10
    elseif value >= 70 then
      return 15
    end
  elseif att == "dodge" then
    value = value+1
    local dodgeValues = {1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 10}
    if value >= 0 and value <= 15 then
      return dodgeValues[value]
    else
      return 99
    end
  end
  print("[Alerta] getCostByValue retornando 99 em algum caso errado")
  return 99
end

function onSay(cid, words, param, channel)
  if(param == '') then
    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, strError)
    return false
  end
  param = string.lower(param)
  param = string.explode(param, ",")
  if not tonumber(param[2]) or not isInArray(atributosList, param[1]) then
    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, strError)
    return false
  end

  local atributo = param[1]
  if atributo == "mana" then
    atributo = "speed"
  end

  local quantia = tonumber(param[2])
  local storageAtributo = atributo .. "value"
  local valor = getPlayerStorageValue(cid, storageAtributo)
  valor = valor > 0 and valor or 0
  if atributo == "dodge" and valor >= 15 then
    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Este atributo já atingiu seu nível máximo.")
    return false
  end
  local custo = getCostByValue(valor, atributo)
  quantia = quantia > 1 and quantia or custo
  local pendentes = getPlayerStorageValue(cid, "AttributesPoints")
  pendentes = pendentes > 0 and pendentes or 0

  if quantia > pendentes then
    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você não possui pontos suficientes.")
    return false
  elseif quantia < custo then
    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você não possui pontos suficientes para evoluir este atributo.")
    return false
  end
  local oldValorAtt = valor
  local dbugCount = 0
  while (quantia >= custo) do
    dbugCount = dbugCount+1
    custo = getCostByValue(valor, atributo)
    quantia = quantia-custo
    pendentes = pendentes-custo
    valor = valor+1
    custo = getCostByValue(valor, atributo)
    if atributo == "dodge" and valor >= 15 then
      doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Este atributo já atingiu seu nível máximo.")
      break;
    end
    if dbugCount > 1000 then
      print("[Alerta] Loop parado no sistema de atributos.")
      break;
    end
  end
  if not isCreature(cid) then return false end
  setPlayerStorageValue(cid, storageAtributo, valor)
  pendentes = pendentes >= 0 and pendentes or 0
  setPlayerStorageValue(cid, "AttributesPoints", pendentes)
  onAddAtributo(cid, atributo, valor-oldValorAtt)
  local string = atributo .. ","..valor..","..custo..","..pendentes..""
  doSendPlayerExtendedOpcode(cid, 38, string)

  return false
end