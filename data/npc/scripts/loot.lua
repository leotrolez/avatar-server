local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
npcHandler.talkRadius = 4
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)        npcHandler:onCreatureAppear(cid)      end
function onCreatureDisappear(cid)       npcHandler:onCreatureDisappear(cid)     end
function onCreatureSay(cid, type, msg)    npcHandler:onCreatureSay(cid, type, msg)  end
function onThink()              npcHandler:onThink()            end
function onPlayerEndTrade(cid)        npcHandler:onPlayerEndTrade(cid)      end
function onPlayerCloseChannel(cid)      npcHandler:onPlayerCloseChannel(cid)    end
npcHandler:setMessage(MESSAGE_GREET, "")

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	return true
end
function onGreet(cid) 
	selfSay(getLangString(cid, "Hello "..getCreatureName(cid).."! How can i help you? Do you want to see my {offers}?", "Olá "..getCreatureName(cid).."! Eu ando muito cansado esses dias, porém, como eu posso lhe ajudar? Você deseja ver minhas {ofertas}?"), cid)
	return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

	-- o padrao eh nome, preco, ID, aspas sem nada dentro
    shopModule:addSellableItem('dark lord amulet', 6000, 8266, '')
    shopModule:addSellableItem('dark lord armor', 20000, 12952, '')
    shopModule:addSellableItem('dark lord legs', 20000, 12953, '')
    shopModule:addSellableItem('dark lord shield', 15000, 12921, '')
    shopModule:addSellableItem('vulcan amulet', 5000, 13379, '')
    shopModule:addSellableItem('vulcan robe', 20000, 11356, '')
    shopModule:addSellableItem('vulcan armor', 15000, 12890, '')
    shopModule:addSellableItem('vulcan legs', 15000, 12914, '')
    shopModule:addSellableItem('windy amulet', 5000, 13339, '')
    shopModule:addSellableItem('windy hat', 15000, 13118, '')
    shopModule:addSellableItem('windy robe', 15000, 13119, '')
    shopModule:addSellableItem('windy kilt', 12000, 12959, '')
    shopModule:addSellableItem('windy legs', 15000, 13120, '')
    shopModule:addSellableItem('windy shield', 12000, 13300, '')
    shopModule:addSellableItem('heavy helmet', 30000, 12946, '')
    shopModule:addSellableItem('heavy chest', 30000, 12792, '')
    shopModule:addSellableItem('heavy legs', 30000, 12785, '')
  shopModule:addSellableItem('spellbook of lost souls', 9000, 8903, '')
  shopModule:addSellableItem('ruby necklace', 2000, 2133, '')
  shopModule:addSellableItem('golden legs', 10000, 2470, '')
  shopModule:addSellableItem('zaoan legs', 6200, 11304, '')
  shopModule:addSellableItem('mastermind shield', 12150, 2514, '')
  shopModule:addSellableItem('demonbone amulet', 2000, 2136, '')
  shopModule:addSellableItem('primate legs', 9500, 2507, '')
  shopModule:addSellableItem('boggy legs', 6000, 12957, '')
  shopModule:addSellableItem('belted cape', 3400, 8872, '')
  shopModule:addSellableItem('shield of honour', 6100, 2517, '')
  shopModule:addSellableItem('wyrmhunter robe', 16200, 11355, '')
  shopModule:addSellableItem('focus cape', 2500, 8871, '')
  shopModule:addSellableItem('vampire coat', 17800, 12607, '')
  shopModule:addSellableItem('nightmare shield', 16100, 6391, '')
  shopModule:addSellableItem('spawn legs', 10800, 12936, '')
  shopModule:addSellableItem('tortoise shield', 100, 6131, '')
  shopModule:addSellableItem('shield of honour', 6100, 2517, '')
  shopModule:addSellableItem('witch hat', 7000, 10570, '')
  shopModule:addSellableItem('wyvern armor', 4000, 8891, '')
  shopModule:addSellableItem('dragon scale mail', 11000, 2492, '')
  shopModule:addSellableItem('zaoan armor', 13200, 11301, '')
  shopModule:addSellableItem('zaoan helmet', 14000, 11302, '')
  shopModule:addSellableItem('tower shield', 2500, 2528, '')
  shopModule:addSellableItem('platinum amulet', 200, 2171, '')
  shopModule:addSellableItem('glacier mask', 1030, 7902, '')
  shopModule:addSellableItem('mystic turban', 3000, 2663, '')
  shopModule:addSellableItem('goldensilver shield', 15000, 12929, '')
  shopModule:addSellableItem('terra mantle', 4500, 7884, '')
  shopModule:addSellableItem('terra legs', 4500, 7885, '')
  shopModule:addSellableItem('skullcracker armor', 6000, 8889, '')
  shopModule:addSellableItem('wolf tooth chain', 50, 2129, '')
  shopModule:addSellableItem('strange boots of haste', 13200, 12934, '')
    shopModule:addSellableItem('umbral fire robe', 15500, 13305, '')
  shopModule:addSellableItem('dragon scale boots', 13000, 11118, '')
  shopModule:addSellableItem('earmuffs', 200, 7459, '')

  shopModule:addSellableItem('garlic necklace', 510, 2199, '')

  shopModule:addSellableItem('cooper shield', 30, 2530, '')
  shopModule:addSellableItem('brass armor', 75, 2465, '')
  shopModule:addSellableItem('brass shield', 20, 2511, '')

  shopModule:addSellableItem('studded armor', 15, 2484, '')
  shopModule:addSellableItem('dwarven shield', 90, 2525, '')

  shopModule:addSellableItem('chain armor', 75, 2464, '')
  shopModule:addSellableItem('plate armor', 350, 2463, '')
  shopModule:addSellableItem('plate legs', 350, 2647, '')
  shopModule:addSellableItem('soldier helmet', 20, 2481, '')
  shopModule:addSellableItem('brass helmet', 35, 2460, '')
  shopModule:addSellableItem('leather boots', 2, 2643, '')
  shopModule:addSellableItem('steel helmet', 220, 2457, '')

  shopModule:addSellableItem('battle shield', 75, 2513, '')
  shopModule:addSellableItem('bone shield', 75, 2541, '')
  shopModule:addSellableItem('scale armor', 60, 2483, '')

  shopModule:addSellableItem('iron helmet', 130, 2459, '')

  shopModule:addSellableItem('studded legs', 15, 2468, '')
  shopModule:addSellableItem('dark helmet', 100, 2490, '')

  shopModule:addSellableItem('dark armor', 500, 2489, '')

  shopModule:addSellableItem('vampire shield', 8000, 2534, '')
  shopModule:addSellableItem('ancient earth shield', 13000, 12923, '')

  shopModule:addSellableItem('dragonbone shield', 14000, 12926, '')
  shopModule:addSellableItem('dragonhunter robe', 14000, 12657, '')
  shopModule:addSellableItem('strange helmet', 1300, 2479, '')
  shopModule:addSellableItem('dragon shield', 2550, 2516, '')
  shopModule:addSellableItem('vampire helmet', 2000, 12789, '')

  shopModule:addSellableItem('knight armor', 3000, 2476, '')
  shopModule:addSellableItem('crown armor', 5000, 2487, '')
  shopModule:addSellableItem('bloody robe', 6100, 8867, '')
  shopModule:addSellableItem('dark shield', 20, 2521, '')

  shopModule:addSellableItem('dwarven legs', 4500, 2504, '')
  shopModule:addSellableItem('crown shield', 4300, 2519, '')

  shopModule:addSellableItem('golden armor', 5900, 2466, '')

  shopModule:addSellableItem('crown legs', 4150, 2488, '')

  shopModule:addSellableItem('blue legs', 4300, 7730, '')

  shopModule:addSellableItem('beholder shield', 1000, 2518, '')

  shopModule:addSellableItem('noble armor', 520, 2486, '')
  shopModule:addSellableItem('ornamented shield', 130, 2524, '')


  shopModule:addSellableItem('barbarian curse elmo', 6050, 12791, '')
  shopModule:addSellableItem('haringer harash', 5100, 12810, '')

  shopModule:addSellableItem('scarf', 200, 2661, '')

  shopModule:addSellableItem('warrior helmet', 1300, 2475, '')
  shopModule:addSellableItem('glacier robe', 5500, 7897, '')
  shopModule:addSellableItem('skull helmet', 2300, 5741, '')

  shopModule:addSellableItem('plate shield', 40, 2510, '')
  shopModule:addSellableItem('sandals', 2, 2642, '')

  shopModule:addSellableItem('leather helmet', 4, 2461, '')
  shopModule:addSellableItem('wooden shield', 9, 2512, '')
  shopModule:addSellableItem('steel shield', 75, 2509, '')
  shopModule:addSellableItem('chain helmet', 15, 2458, '')

  shopModule:addSellableItem('boots of haste', 9000, 2195, '')
  shopModule:addSellableItem('zaoan shoes', 3000, 11303, '')
  shopModule:addSellableItem('knight legs', 3000, 2477, '')

  shopModule:addSellableItem('scarab shield', 1000, 2540, '')

  shopModule:addSellableItem('scarab amulet', 300, 2135, '')
  shopModule:addSellableItem('royal helmet', 12000, 2498, '')
  shopModule:addSellableItem('medusa shield', 6000, 2536, '')

  shopModule:addSellableItem('crown helmet', 1800, 2491, '')
  shopModule:addSellableItem('scarab shield', 500, 2540, '')
  shopModule:addSellableItem('blue robe', 1050, 2656, '')
  shopModule:addSellableItem('glacier kilt', 4200, 7896, '')


  shopModule:addSellableItem('guardian shield', 2200, 2515, '')

  shopModule:addSellableItem('brass legs', 120, 2478, '')

  shopModule:addSellableItem('firely armor', 2300, 12755, '')

  shopModule:addSellableItem('stoned elmo', 2200, 11422, '')
  shopModule:addSellableItem('firely hat', 1700, 12802, '')

  shopModule:addSellableItem('steel boots', 12500, 2645, '')

  shopModule:addSellableItem('horned armor', 27000, 12882, '')

  shopModule:addSellableItem('fur boots', 810, 7457, '')
  shopModule:addSellableItem('mammoth fur shorts', 140, 7464, '')
  shopModule:addSellableItem('mammoth fur cape', 400, 7463, '')
  shopModule:addSellableItem('krimhorn helmet', 310, 7461, '')
  shopModule:addSellableItem('crusader helmet', 1610, 2497, '')

  shopModule:addSellableItem('ragnir helmet', 210, 7462, '')

  shopModule:addSellableItem('magma coat', 5700, 7899, '')
  shopModule:addSellableItem('magma monocle', 4700, 7900, '')
  shopModule:addSellableItem('foldbook of warding', 6000, 8901, '')