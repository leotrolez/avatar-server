--incompleto (getNpcId())

local timeToBye = 15 --tempo (seg) que npc encerrarï¿½ msg

dofile("data/lib/isoled/150-npcSystem.lua")
dofile("data/lib/isoled/152-npcTaskSystem.lua")
dofile("data/lib/isoled/153-npcTaskDaily.lua")

dofile(getDataDir() .. 'npc/lib/npc.lua')


    local spellInfos = {
    ["fire"] = 
        {
            {words = "Focus", price = 55000}, {words = "Lightning"},
            {words = "Bomb"}, {words = "Clock"}, {words = "Thunderbolt"}, {words = "Meteor", price = 95000},
            {words = "Striker", price = 125000}, {words = "Overload"},  {words = "Explosion"}, {words = "Voltage"},  {words = "Thunderstorm"}, {words = "Discharge"}, {words = "Conflagration"}
        },

    ["water"] = 
        {
           {words = "BloodControl", price = 55000},
            {words = "Punch"}, {words = "Dragon"}, {words = "Rain"}, {words = "Bubbles"}, {words = "Protect", price = 95000},
            {words = "Icebolt"}, {words = "Flow"}, {words = "IceGolem"}, {words = "Tsunami"}, {words = "Clock"}, {words = "Blizzard"}, {words = "BloodBending"}
        },

    ["air"] = 
        {
            {words = "Suffocation"},
            {words = "Hurricane"}, {words = "Tempest"}, {words = "Windblast"}, {words = "Tornado", price = 90000}, {words = "Barrier"}, {words = "Trap", price = 100000}, 
            {words = "Doom"}, {words = "Bomb"}, {words = "Windstorm"}, {words = "Stormcall"}, {words = "Vortex"}, {words = "Deflection"}
        },

    ["earth"] = 
        {
            {words = "Control", price = 55000}, {words = "Leech"},
            {words = "Smash"}, {words = "Ingrain", price = 70000}, {words = "Fists"}, {words = "Arena"},
            {words = "Curse"}, {words = "Quake"}, {words = "Cataclysm"}, {words = "Aura"}, {words = "Storm"}, {words = "Armor"}, {words = "Lavaball"}, {words = "Metalwall"}
        }
}

local function getLangNpcString(lang, en, pt)
  if lang == EN then
    return en
  else
    return pt
  end
end

local function setValidateNumber(number, max)
    local max = max or 100

    if number == nil then
        return 1
    end
    if number > max then
        return max
    end
    if number <= 0 then
        return 1
    else
        return number
    end
end

local function getNameItemPluralOrNot(itemid, normalname, amount)
    local string = ""
    if amount > 1 and string.sub(normalname, normalname:len(), normalname:len()) ~= "s" then
        string = getItemPluralNameById(itemid)
    else
        string = normalname
    end
    return string
end

local Npc = {}

function Npc:new(identifier)
  local newNpc = {uid = nil, options = {}, identifier = identifier, canTalk = {}}
  setmetatable(newNpc, {__index = self})
  return newNpc
end

function newNpc(identifier)
  return Npc:new(identifier)
end

function Npc:getUid()
  return self.uid
end

function Npc:numberValid(number, max)
  return setValidateNumber(number, max)
end

function Npc:getNumberMsg(msg, max)
  return setValidateNumber(getNumbersInString(msg)[1], max)
end

function Npc:getName()
  return getNpcName()
end

function Npc:setHiMsg(msgIngles, msgPort)
  self.msgHi = {msgIngles, msgPort}
end

function Npc:setFuncStart(func)
  self.funcStart = func
end

function Npc:setStorage(storage, value)
  if isPlayer(self.client) then
    setPlayerStorageValue(self.client, self.identifier..storage, value)
    return value
  end
end

function Npc:getStorage(storage)
  if isPlayer(self.client) then
    return getPlayerStorageValue(self.client, self.identifier..storage)
  end
end

function Npc:needPremium(param)
  self.needPremium = param
end

function getSpectatorsPlayers(pos, rangex, rangey, multifloor)
	local specs = getSpectators(pos, rangex, rangey, multifloor)
	local specsPlayer = {}
	if type(specs) == "table" and #specs >= 1 then 
		for i = 1, #specs do
			if isPlayer(specs[i]) then 
				table.insert(specsPlayer, specs[i])
			end 
		end 
	end 
	return specsPlayer
end 

function Npc:onThink(func)
  if self.client ~= nil then

    if isPlayer(self.client) then
      doNpcSetCreatureFocus(self.client)

      if getDistanceToCreature(self.client) > 5 then
        self:say("How rude!", "Quanta educaï¿½ï¿½o...")
        setPlayerStorageValue(self.client, "canTalkWithNpc", os.time()+2)
        self.client = nil
        return
      end
		local specs = getSpectatorsPlayers(getCreaturePosition(self.client), 1, 1)
      if (os.clock() - self.talkStart) > 120 or ((os.clock() - self.talkStart) > 45 and #specs > 1) then
        self:say("Next please!", "Prï¿½ximo por favor!")
        setPlayerStorageValue(self.client, "canTalkWithNpc", os.time()+2)
        self.client = nil
      end
    else
      self:say("Next please!", "Prï¿½ximo por favor!")
      self.client = nil
    end
  end

  if func then
    func(self.client)
  end
end

function Npc:onDisappear(cid, pos)
  if self.client then
    if cid == self.client then
      selfSay(getLangNpcString(self.lang, "Good bye then.", "Entï¿½o tï¿½... tchau."))
      setPlayerStorageValue(cid, "canTalkWithNpc", os.time()+2)
      self.client = nil
    end
  end
end

function Npc:say(msgEN, msgPT, lang) --Lang is optional
  self.talkStart = os.clock()
  selfSay(getLangNpcString(lang or self.lang, msgEN, msgPT))
end

function Npc:forceBye()
  self.talkStart = 0
end

function Npc:setStage(number)
  self.stage = number
end

function Npc:addBuyableItens(identifier) --NPC Compra
  local itens = {}
  for x = 1, #itemInfosSell do
    if itemInfosSell[x].inNpcs == identifier then
      table.insert(itens, itemInfosSell[x])
    end
  end
  self.buyItens = itens
end

function Npc:addSellableItens(identifier) --NPC Vende
  local itens = {}

  for x = 1, #itemInfosBuy do
    if itemInfosBuy[x].inNpcs == identifier then
      table.insert(itens, itemInfosBuy[x])
    end
  end
  self.sellItens = itens
end

function Npc:loadSellableItens(msg)
  local itens = self.sellItens

  if self.sellable == 0 then
    if msgcontains(msg, "buy") then
      for x = 1, #itens do
        if msgcontains(msg, itens[x].name) then
          itens[x].number = setValidateNumber(getNumbersInString(msg)[1], 2000)
          self:say('Do you want to buy '..itens[x].number..'x '..getNameItemPluralOrNot(itens[x].itemId, itens[x].name, itens[x].number)..' for '..itens[x].price*itens[x].number..' gold coins?',
          'Vocï¿½ deseja comprar '..itens[x].number..'x '..getNameItemPluralOrNot(itens[x].itemId, itens[x].name, itens[x].number)..' por '..itens[x].price*itens[x].number..' gold coins?')
          self.sellable = 1 
          self.currentItemSell = itens[x]
          return true
        end
      end
      self:say("Sorry, I don't sell this item.", "Desculpe, eu não vendo nenhum item com esse nome.")
    end

  elseif self.sellable == 1 then
    if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
      if doPlayerRemoveMoney(self.client, self.currentItemSell.price*self.currentItemSell.number) then
        self:say("Here is "..self.currentItemSell.number.."x "..getNameItemPluralOrNot(self.currentItemSell.itemId, self.currentItemSell.name, self.currentItemSell.number)..", it was a pleasure doing business with you.",
        "Aqui estï¿½ "..self.currentItemSell.number.."x "..getNameItemPluralOrNot(self.currentItemSell.itemId, self.currentItemSell.name, self.currentItemSell.number)..", ï¿½ sempre um prazer negociar com vocï¿½.")
        --doPlayerAddItem(self.client, self.currentItemSell.itemId, self.currentItemSell.number)
        doPlayerAddItemNPC(self.client, self.currentItemSell.itemId, self.currentItemSell.number)
      else
        self:say("Sorry, you don't have enough money for do this.", "Desculpe, vocï¿½ não tem dinheiro suficiente para comprar isso.")
      end
    else
      self:say("Ok, I think...", "OK entï¿½o...")
    end
    self.sellable = 0
    return true
  end
end

function Npc:loadBuyableItens(msg)
  local itens = self.buyItens

  if self.buyable == 0 then
    if msgcontains(msg, "sell") and not msgcontains(msg, "all loot") then
      for x = 1, #itens do
        if msgcontains(msg, itens[x].name) then
          itens[x].number = setValidateNumber(getNumbersInString(msg)[1])
          self:say('Do you want to sell '..itens[x].number..'x '..getNameItemPluralOrNot(itens[x].itemId, itens[x].name, itens[x].number)..' for '..itens[x].price*itens[x].number..' gold coins?',
          'Vocï¿½ deseja vender '..itens[x].number..'x '..getNameItemPluralOrNot(itens[x].itemId, itens[x].name, itens[x].number)..' por '..itens[x].price*itens[x].number..' gold coins?')
          self.buyable = 1 
          self.currentItemBuy = itens[x]
          return true
        end
      end
      self:say("Sorry, I don't buy this item.", "Desculpe, eu não compro nenhum item com esse nome.")

    elseif msgcontains(msg, "all loot") then
      local lootSlot = getItensInContainer(getPlayerSlotItem(self.client, CONST_SLOT_RING).uid)
      local totalPrice = 0

      for y = 1, #lootSlot do
        local currentItemId = lootSlot[y].itemid

        for x = 1, #itens do
          if itens[x].itemId == currentItemId then
            local currentCount = lootSlot[y].type
            if currentCount == 0 then currentCount = 1 end
            
            if doRemoveItem(lootSlot[y].uid) then
              totalPrice = totalPrice+(itens[x].price*currentCount)
            end
            break
          end
        end
      end

      if totalPrice > 0 then
        local addMoney = doPlayerAddMoney(self.client, totalPrice)

        if not (addMoney) then
          error('[doPlayerAddMoney] Could not add money to: ' .. getPlayerName(self.client) .. ' (' .. totalPrice .. 'gp).')
        end

        self:say("Here is "..totalPrice.." gold coins, it was a pleasure doing business with you.", "Aqui estï¿½ "..totalPrice.." gold coins, ï¿½ sempre um prazer negociar com vocï¿½.")
      else
        self:say("Sorry, I don't buy any item for your Loot Slot.", "Desculpe, eu não estou comprando nenhum desses items.")
      end
    end

  elseif self.buyable == 1 then
    if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
      if doPlayerSellItem(self.client, self.currentItemBuy.itemId, self.currentItemBuy.number, self.currentItemBuy.price*self.currentItemBuy.number) then
        self:say("Here is "..self.currentItemBuy.price*self.currentItemBuy.number.." gold coins, it was a pleasure doing business with you.",
        "Aqui estï¿½ "..self.currentItemBuy.price*self.currentItemBuy.number.." gold coins, ï¿½ sempre um prazer negociar com vocï¿½.")
      else
        self:say("Sorry, you dont have this item to sell.", "Desculpe, vocï¿½ nao tem esses itens para vender.")
      end
    else
      self:say("Ok, I think...", "OK entï¿½o...")
    end
    self.buyable = 0
    return true
  end
end

function Npc:loadShipRoutes(msg)
  if self.boatStage == nil then
    for x = 1, #self.boatRoutes do
      if msgcontains(msg, self.boatRoutes[x].name) then
        self:say("Are you sure you want to go to "..self.boatRoutes[x].name.." for "..self.boatRoutes[x].price.." gold coins?", "Vocï¿½ tem certeza que deseja ir para "..self.boatRoutes[x].name.." por "..self.boatRoutes[x].price.." gold coins?")
        self.boatStage = 1
        self.boatIndex = x
        return true
      end
    end

  elseif self.boatStage == 1 then
    if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
      if not isPlayerPzLocked(self.client) then
        if doPlayerRemoveMoney(self.client, self.boatRoutes[self.boatIndex].price) then
          self:say("Thank you for choosing my services.", "Obrigado por escolher meus serviï¿½os!")
          doTeleportCreature(self.client, self.boatRoutes[self.boatIndex].pos, 10)
        else
          self:say("Sorry, you don't have money to do this.", "Desculpe vocï¿½ não tem dinheiro para fazer isso.")
        end
      else
        self:say("Sorry, you cannot travel with battle active.", "Desculpe, vocï¿½ não pode viajar com battle ativo.")
      end
    else
      self:say("Ok, I think...", "OK entï¿½o...")
    end
    self.boatStage = nil
  end
end

function Npc:isPlayerStageFree()
  return self.buyable == 0 and self.sellable == 0 and self.boatStage == nil and self.taskStage == nil and self.taskItemStage == nil
end

function Npc:addOptionInNpc(msg, awnser)
  table.insert(self.options, {msg = msg, awnser = {awnser[1], awnser[2]}})
end

function Npc:resetRoutes()
  local tableName, tableRoutes = {}, {}

  for x = 1, #routesShip do
        if routesShip[x].inNpcs == self.boatIdentifier then
            if getDistanceBetween(getThingPos(getNpcId()), routesShip[x].pos) > 5 then
                table.insert(tableName, routesShip[x].name)
                table.insert(tableRoutes, routesShip[x])
            end
        end
    end
    self.stringBoat = orgazineStrings(tableName)
    self.boatRoutes = tableRoutes
end

function Npc:setRoutes(identifier)
  self.boatIdentifier = identifier
end

function Npc:getRoutesString()
  return self.stringBoat
end

function Npc:setTasks(identifier)
  self.tasks = getTasksInNpc(identifier)
end

function Npc:getTasksString()
  if isPlayer(self.client) then
    local playerLevel = getPlayerLevel(self.client)
    local taskDisp = {}

    for k, v in pairs(self.tasks) do
          if v.lvMin <= playerLevel then
              if not getPlayerHasEndTask(self.client, v.identifier) then
                  table.insert(taskDisp, v.name)
                end
            end
        end

    if #taskDisp > 0 then
      if #taskDisp == 1 then
        return {"To your level, I've this task: "..orgazineStrings(taskDisp)..". You want to get some?", "Para o seu level, eu tenho essa unica task: "..orgazineStrings(taskDisp)..". Deseja inicia-la?"}
      else
        return {"To your level, I've these tasks: "..orgazineStrings(taskDisp)..". You want to get some?", "Para o seu level, eu tenho essas tasks: "..orgazineStrings(taskDisp)..". Deseja iniciar alguma?"}
      end
    else
      return {"I don't have tasks for you right now, come back when you have more level.", "Eu não tenho nenhuma task para vocï¿½ nesse momento, volte quando tiver mais level."}
    end
  end
  return {"erro", "erro"}
end

function Npc:setTaskItens(identifier, msgFinalEN, msgFinalPT)
  self.taskItemIdentifier = identifier
  self.taskItemMsgs = {msgFinalEN, msgFinalPT}
end

function Npc:loadTasksItens(msg)
  if self.taskItemStage == nil then

    if msgcontains(msg, "help") or msgcontains(msg, "ajuda") or msgcontains(msg, "ajude") then
      if getStageItensTask(self.client, self.taskItemIdentifier) == -1 then
        self:say("I need that you bring me "..getItensNameByNpc(self.taskItemIdentifier).." to receive "..getMoneyInItemTask(self.taskItemIdentifier).." gold coins, are you interresed?", "Eu preciso que vocï¿½ me traga "..getItensNameByNpc(self.taskItemIdentifier).." para receber "..getMoneyInItemTask(self.taskItemIdentifier).." gold coins, vocï¿½ estï¿½ interessado?")
        self.taskItemStage = 1
      elseif getStageItensTask(self.client, self.taskItemIdentifier) == 1 then
        self:say("You're with all the items there?", "Vocï¿½ estï¿½ com todos os itens aï¿½?")
        self.taskItemStage = 2
      else
        self:say("Sorry, you already did this task.", "Desculpe, vocï¿½ jï¿½ terminou essa task.")
        self.taskItemStage = nil
      end
    end

  elseif self.taskItemStage == 1 then
    if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
      self:say("OK! Come back when you have this items.", "OK! Volte aqui quando vocï¿½ tiver os items.")
      activeTaskInPlayer(self.client, self.taskItemIdentifier)
    else
      self:say("Ok, I think...", "OK entï¿½o...")
    end
    self.taskItemStage = nil

  elseif self.taskItemStage == 2 then
    if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
      if doPlayerRemoveItens(self.client, getItensFromTask(self.taskItemIdentifier)) then
        self:say(self.taskItemMsgs[1], self.taskItemMsgs[2])
        endTaskItemInPlayer(self.client, self.taskItemIdentifier)
      else
        self:say("Sorry, you don't have "..getItensNameByNpc(self.taskItemIdentifier)..".", "Desculpe, vocï¿½ não tem "..getItensNameByNpc(self.taskItemIdentifier)..".")
      end
    else
      self:say("Ok, I think...", "OK entï¿½o...")
    end
    self.taskItemStage = nil
  end
end

function Npc:loadTasks(msg)
  if self.taskStage == nil then
    local playerLevel = getPlayerLevel(self.client)

    for k, v in pairs(self.tasks) do
      if msgcontains(msg, v.name) then
        if v.lvMin <= playerLevel then
          if not getPlayerHasEndTask(self.client, v.identifier) then
            if playerHasTaskInProgress(self.client, v.identifier) then
              self:say("Huum... Did you kill all "..v.monsterName.."(s)?", "Huum... Vocï¿½ jï¿½ matou todos "..v.monsterName.."(s)?")
              self.taskStage = 2
              self.currentTask = v.identifier
            else
              self:say("In this task you need kill "..v.amount.." "..v.monsterName.."(s), and you gain some experience and money when you complete this, do you accept?", "Nessa task vocï¿½ precisa matar "..v.amount.." "..v.monsterName.."(s), completando-a vocï¿½ ganharï¿½ expï¿½riencia e dinheiro, vocï¿½ aceita?")
              self.taskStage = 1
              self.currentTask = v.identifier
            end
            return true
          end
        end
      end
    end

  elseif self.taskStage == 1 then
    if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
      if playerHasTaskInProgress(self.client, self.currentTask) == false and getPlayerHasEndTask(self.client, self.currentTask) == false then
        local taskInfo = getTaskInfosByIdentifier(self.currentTask)
        self:say("Huum..., you need kill "..taskInfo.amount.." "..taskInfo.monsterName.."(s), when you finish back here to get your reward.", "Huum..., vocï¿½ precisa matar "..taskInfo.amount.." "..taskInfo.monsterName.."(s), quando vocï¿½ terminar volte aqui para pegar sua recompensa.")
        startTaskInPlayer(self.client, self.currentTask, getNpcName())

        local warningEN, warningPT = "", ""
        if getTaskInfosByIdentifier(self.currentTask).cantDoInParty then
          warningEN, warningPT = " Attention: You can't do this task in Party.", " Atenï¿½ï¿½o: Vocï¿½ não pode fazer essa task em Party."
        end

        sendBlueMessage(self.client, getLangString(self.cliente, "New task added. For more information type !tasks."..warningEN, "Nova task adicionada. Para mais informaï¿½ï¿½es digite !tasks."..warningPT))
      else
        self:say("You already started/finished this task, please try again.", "Vocï¿½ jï¿½ comeï¿½ou/terminou essa task, por favor tente novamente.")
      end
    else
      self:say("Ok, I think...", "OK entï¿½o...")
    end
    self.taskStage = nil

  elseif self.taskStage == 2 then
    if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
      if endTaskInPlayer(self.client, self.currentTask) then
        self:say("Good service brave adventurer, here's your reward, if you prepared again to do more tasks talk with me.", "Bom trabalho bravo aventureiro, aqui estï¿½ sua recompensa, quando vocï¿½ estiver preparado para mais tasks, volte a falar comigo.")
      else
        local taskInfo = getTaskInfosByIdentifier(self.currentTask)
        self:say("You haven't done this task, you need kill more "..taskInfo.amount-getMonstersHasKilled(self.client, self.currentTask).. " "..taskInfo.monsterName.."(s) to complete this.", "Vocï¿½ ainda não terminou essa task, vocï¿½ precisa matar mais "..taskInfo.amount-getMonstersHasKilled(self.client, self.currentTask).. " "..taskInfo.monsterName.."(s) para termina-la.")
      end
    else
      self:say("Ok, I think...", "OK entï¿½o...")
    end
    self.taskStage = nil
  end
end

function Npc:loadFoldNPC(cid, msg)
  local element = getPlayerElement(cid, true)
  local cid = self.client

    if self.stage == 1 then
		if msgcontains(msg, "promote") or msgcontains(msg, "promotion") or msgcontains(msg, "promover") then
			if getPlayerStorageValue(cid, "canPromote") == 1 then
				local nomeByVoc = {"Fire Lord", "Tribal Chief", "Air Monk", "Dai Li"}
				self:say("I now promote you to "..nomeByVoc[getPlayerVocation(cid)]..". Congratulations and honor your name!", "Eu agora te promovo a "..nomeByVoc[getPlayerVocation(cid)]..". Parabï¿½ns e honre seu nome!")
				doSendMagicEffect(getCreaturePosition(cid), 49)
				self:setStage(1)
				setPlayerStorageValue(cid, "canPromote", 2)
				setPlayerStorageValue(cid, "isPromoted", 1)
			elseif getPlayerStorageValue(cid, "canPromote") == 2 then
				local nomeByVoc = {"Fire Lord", "Tribal Chief", "Air Monk", "Dai Li"}
				self:say("You already are a "..nomeByVoc[getPlayerVocation(cid)]..".", "Vocï¿½ jï¿½ ï¿½ um "..nomeByVoc[getPlayerVocation(cid)]..".")
				self:setStage(1)
			else
				self:say("You need to complete your secret mission first.", "Vocï¿½ precisa completar a sua missï¿½o secreta primeiro.")
				self:setStage(1)
			end
        elseif msgcontains(msg, "learn") or msgcontains(msg, "aprender") then
            local list = getListLearnFold(cid, true)

            if list ~= "" then
                self:say("Huuumm, let me see... in this level you can learn: "..list..". Are you interested?", "Huuumm, deixe-me ver... nesse level vocï¿½ pode aprender: "..list..". Estï¿½ interessado?")
                self:setStage(2)
            else
                self:say("Right now you don't have any fold avaiable to learn.", "Nesse momento vocï¿½ não tem nenhuma dobra dï¿½sponivel para aprender.")
            end
        end

        return true
        
    elseif self.stage == 2 then
        local list = string.explode(getListLearnFold(cid), ",")

    local spells = spellInfos[getPlayerElement(cid)]
    for x = 1, #spells do 
      if spells[x].words:lower() == msg then 
        sequencia = x 
        break;
      end 
    end 

        for x = 1, #list do
            if msgcontains(msg, list[x]:lower()) then
                local current, price = list[x]:lower(), math.ceil(getFoldPrice(cid, list[x]))
        local nextStage = 4
       --   if sequencia+1 < #spells then 
            self:say("Hum, the fold "..element.." "..list[x].." costs "..price.." gold coins or 1 bender scroll to learn, do you wanna pay with GOLD or BENDER SCROLL?", "Hum, a dobra "..element.." "..list[x].." custa "..price.." gold coins ou 1 bender scroll para aprender, quer pagar com GOLD ou BENDER SCROLL?")
            nextStage = 3
      --    elseif sequencia == #spells then      
      --      self:say("Unfortunately, folds as the "..element.." "..list[x].." is not so simple to master. I'll need bender scrolls, which are scrolls that have the secrets of these folds. Rumor has it that the Belzeboss is the guardian of these scrolls, which protects them to prevent them from falling into the hands of benders.", "Infelizmente, dobra como a "..element.." "..list[x].." não ï¿½ tï¿½o simples de se dominar. Precisarei de bender scrolls, que sï¿½o pergaminhos que possuem os segredos destas dobras. Hï¿½ rumores de que o Belzeboss ï¿½ o guardiï¿½o destes pergaminhos, que os protege para evitar que caiam em mï¿½os de dobradores.")      
      --      self:say("The fold "..element.." "..list[x].." costs 3 bender scrolls to learn, do you accept?", "A dobra "..element.." "..list[x].." custa 3 bender scrolls para aprender, estï¿½ interessado?")
      --    elseif sequencia+1 == #spells then                    
      --      self:say("Unfortunately, folds as the "..element.." "..list[x].." is not so simple to master. I'll need bender scrolls, which are scrolls that have the secrets of these folds. Rumor has it that the Belzeboss is the guardian of these scrolls, which protects them to prevent them from falling into the hands of benders.", "Infelizmente, dobra como a "..element.." "..list[x].." não ï¿½ tï¿½o simples de se dominar. Precisarei de bender scrolls, que sï¿½o pergaminhos que possuem os segredos destas dobras. Hï¿½ rumores de que o Belzeboss ï¿½ o guardiï¿½o destes pergaminhos, que os protege para evitar que caiam em mï¿½os de dobradores.")        
      --      self:say("The fold "..element.." "..list[x].." costs 2 bender scrolls to learn, do you accept?", "A dobra "..element.." "..list[x].." custa 2 bender scrolls para aprender, estï¿½ interessado?")
      --      end 
          self:setStorage("foldName", list[x])
          self:setStage(nextStage)
                return true
            end
        end

        self:say("Only the folds I said earlier are available for learning.", "Apenas as dobras que eu disse anteriormente estï¿½o disponiveis para aprendizagem.")
        self:setStage(2)
        return true

    elseif self.stage == 3 then
    local msg = string.lower(msg)
        if msgcontains(msg, "gold") or msgcontains(msg, "scroll") or msgcontains(msg, "yes") or msgcontains(msg, "sim") then
			if not msgcontains(msg, "scroll") then 
				msg = "gold"
			end
            local current = self:getStorage("foldName")

            local canLearn = canBuyFold(cid, current, msgcontains(msg, "gold") and 1 or 2)

            if canLearn == true then
                self:say("Congratulations! Use this fold with extreme caution and wisdom.", "Parï¿½bens! Use essa dobra com extremo cuidado e sabedoria.")
            else
                self:say(canLearn[1], canLearn[2])
            end
        else
            self:say("Ok, I think...", "Ok entï¿½o...")
        end

        self:setStage(2)
        return true
   elseif self.stage == 4 then
    local msg = string.lower(msg)
        if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
            local current = self:getStorage("foldName")

            local canLearn = canBuyFold(cid, current, 2)

            if canLearn == true then
                self:say("Congratulations! Use this fold with extreme caution and wisdom.", "Parï¿½bens! Use essa dobra com extremo cuidado e sabedoria.")
            else
                self:say(canLearn[1], canLearn[2])
            end
        else
            self:say("Ok, I think...", "Ok entï¿½o...")
        end

        self:setStage(1)
        return true
    
    end
end

function Npc:onSay(cid, type, msg, func)
  if (msgcontains(msg, "hi") or msgcontains(msg, "oi")) and getDistanceToCreature(cid) < 4 then
    if self.client ~= nil then
      if self.client ~= cid then
        --selfSay(getLangNpcString(getLang(cid), getCreatureName(cid).." please wait for your turn.", getCreatureName(cid)..", por favor espere por sua vez."))
		doCreatureSay(getNpcId(), getLangNpcString(getLang(cid), getCreatureName(cid).." please wait for your turn.", getCreatureName(cid)..", por favor espere por sua vez."), TALKTYPE_SAY, false, cid)
      else
        self.talkStart = os.clock()
        selfSay(getLangNpcString(self.lang, "I'm already talking with you.", "Eu jï¿½ estou falando com vocï¿½."))
      end
    else

      if isPlayer(cid) then
        if getPlayerStorageValue(cid, "canTalkWithNpc") > os.time() then
          doPlayerSendCancel(cid, getLangString(cid, "Anti-Spam: Please wait a moment to talk with any npc again.", "Anti-Spam: por favor aguarde um momento para falar com qualquer NPC novamente."))
          return true
        end

        if self.needPremium == true then
          if not isPremium(cid) then
            self:say(WITHOUTPREMIUM, WITHOUTPREMIUMBR, getLang(cid))
            return true
          end
        end

        self.stage = 1

        if self.funcStart ~= nil then
          if not self.funcStart(cid) then
            return true
          end
        end

        if self.stringBoat == nil and self.boatIdentifier ~= nil then
          self:resetRoutes()
        end

        self.lang = getLang(cid)

        if self.funcStart == nil then
          if self.msgHi then
            selfSay(getLangNpcString(self.lang, string.format(self.msgHi[1], getCreatureName(cid)), string.format(self.msgHi[2], getCreatureName(cid))))
          else
            selfSay("Olï¿½, oque vocï¿½ deseja com minha pessoa?")
          end
        end

        stopEvent(self.currentEventCanTalk)
        self.currentEventCanTalk = addEvent(function(self)  
          self:forceBye()
        end, self.timeToBlock or 1*15*1000, self)

        self.talkStart = os.clock()
        self.client = cid
        self.buyable = 0
        self.sellable = 0
        self.taskStage = nil
        self.boatStage = nil
        self.taskItemStage = nil
      end
    end
    return true
  else
    if self.client == cid then
      if msgcontains(msg, "bye") or msgcontains(msg, "tchau") then
        self:say('Good bye, ' .. creatureGetName(cid) .. '!', 'Atï¿½ logo '..creatureGetName(cid)..'!')
        setPlayerStorageValue(cid, "canTalkWithNpc", os.time()+2)
        self.client = nil
        return
      end

      if self.stage == 1 then
        if self:isPlayerStageFree() then
          if #self.options > 0 then
            for x = 1, #self.options do
              if msgcontains(msg, self.options[x].msg) then
                self:say(self.options[x].awnser[1], self.options[x].awnser[2])
                return
              end
            end
          end
        end
      end

      if func ~= nil then
        if func(self.stage) then
          self.talkStart = os.clock()
        end
      end
    end
  end
end