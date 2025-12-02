--[[
 * File destinado as Tasks do Servidor, nos NPCS.
 * Corpo da tabela: {name, monsterName, amount, exp, [itens - {itemid, amount}, money], lvMin, endAutomatic (para receber reawrds assim que matar ultimo monstro)}
]]--

local taskItens = {
  {name = "Studian of Spiders", itensNeed = {{itemid = 11328, amount = 200, name = "widow's mandibles"}, {itemid = 8859, amount = 300, name = "spider fang"}},
  money = 40000, inNpcs = "Aluisio"},
  {name = "Explore Wants Know More", itensNeed = {{itemid = 11195, amount = 90, name = "stone wing"}, {itemid = 10549, amount = 75, name = "ancient stone"}, {itemid = 11367, amount = 110, name = "undead heart"}},
  money = 29000, inNpcs = "Explorer"},
  {name = "Help Kill These Cyclops", itensNeed = {{itemid = 10574, amount = 300, name = "cyclops toe"}, {itemid = 5898, amount = 130, name = "cyclops eye"}},
  money = 18300, inNpcs = "Tyson"},
  {name = "Help The Army Of Ba Sing Se", itensNeed = {{itemid = 2645, amount = 1, name = "steel boots"}, {itemid = 2477, amount = 1, name = "knight legs"},{itemid = 2476, amount = 1, name = "knight armor"},{itemid = 2536, amount = 1, name = "medusa shield"},{itemid = 12867, amount = 1, name = "yellow sword"},{itemid = 2498, amount = 1, name = "royal helmet"}},
  money = 94000, inNpcs = "generalLuther"},
  {name = "Help The Cristopher", itensNeed = {{itemid = 2663, amount = 4, name = "mystic turban"}, {itemid = 2796, amount = 400, name = "green mushroom"}},
  money = 24000, inNpcs = "Cristopher"},
  {name = "Studian of Hydras", itensNeed = {{itemid = 12638, amount = 15, name = "hydramat hearth"}, {itemid = 11196, amount = 150, name = "piece of hydra leather"}},
  money = 105000, inNpcs = "Jambo"},
}

function getItensNameByNpc(inNpcs)
  local string = {}

  for x = 1, #taskItens do
    if taskItens[x].inNpcs == inNpcs then
      for h = 1, #taskItens[x].itensNeed do
        table.insert(string, taskItens[x].itensNeed[h].amount.." "..taskItens[x].itensNeed[h].name.."(s)")
      end    
      return orgazineStrings(string)
    end
  end

  return false
end

function getItensFromTask(inNpcs)
  for x = 1, #taskItens do
    if taskItens[x].inNpcs == inNpcs then
      return taskItens[x].itensNeed
    end
  end  

  return false
end

function getMoneyInItemTask(inNpcs)
  for x = 1, #taskItens do
    if taskItens[x].inNpcs == inNpcs then
      return taskItens[x].money
    end
  end  

  return false
end

function endTaskItemInPlayer(cid, inNpcs)
  setPlayerStorageValue(cid, inNpcs.."taskItem", 2)
  doPlayerAddMoney(cid, getMoneyInItemTask(inNpcs))
  return true
end

function activeTaskInPlayer(cid, inNpcs)
  return setPlayerStorageValue(cid, inNpcs.."taskItem", 1)
end

function getStageItensTask(cid, inNpcs) -- -1 nao comecou, 1 em curso, 2 terminado
  return getPlayerStorageValue(cid, inNpcs.."taskItem")
end
-------------------------------------------------------------------------
-- AINDA FUNCIONA NORMALMENTE SE FICAR EXEMPLO EXP = 5000, VAI DAR 5K EXATOS
-- SE QUISER USAR O NOVO SISTEMA DE PORCENTAGEM, USE {} COMO POR EXEMPLO: 
-- mude exp para exp = {levelBase, porcentagem}
-- exemplo 
-- exp = {8, 50}
-- vai dar o equivalente a 50% da exp de um level 8
-- O script ja vai checar se n tiver {} vai dar absoluto o valor, se tiver ele faz esse novo sistema ai, ou seja da pra usar ambos

-- eu mudei o giants easy pra ser 100% da exp de um level 15 pra test e deu certo, tb testei o giants medium que diz ser 20k absoluto e tb deu tudo ok

-- NOVO: exp 1 significa que vai se basear na quantia de monstro/exp do monstro/rate do lvMin para fazer a xp de recompensa

local tasks = {
  {name = "Initial Rotworms", monsterName = "Rotworm", amount = 25, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 1, lvMin = 2},

  {name = "Tortoise Easy", monsterName = "Tortoise", amount = 30, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 90, lvMin = 5},
  {name = "Thornback Tortoise Easy", monsterName = "Thornback Tortoise", amount = 30, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 91, lvMin = 8},

  {name = "Cyclops Easy", monsterName = "Cyclops", amount = 30, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 2, lvMin = 15},
  {name = "Cyclops Medium", monsterName = "Cyclops Drone", amount = 30, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 4, lvMin = 20},
  {name = "Cyclops Hard", monsterName = "Cyclops Smith", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 3, lvMin = 25},
  {name = "Cyclops Extreme", monsterName = "Cyclops Smith", amount = 500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 150, lvMin = 30},
  
  {name = "Hydras Easy", monsterName = "Hydra", amount = 160, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 5, lvMin = 50},
  {name = "Hydras Medium", monsterName = "Hydramat", amount = 35, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 6, lvMin = 52},
  {name = "Hydras Hard", monsterName = "Hydra", amount = 550, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 151, lvMin = 56},
  {name = "Hydras Extreme", monsterName = "Hydramat", amount = 140, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 152, lvMin = 61},
  {name = "Demoniacs Skeletons", monsterName = "Demon Skeleton", amount = 60, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 7, lvMin = 26},
  {name = "Boss Devil Skeleton", monsterName = "Devil Skeleton", itens = {{itemid=2392, amount=1}}, amount = 1, exp = 0, inNpcs = "notHave", money = 0, identifier = 8, lvMin = 1, endAutomatic = true},
  {name = "Terror Easy", monsterName = "Terror Bird", amount = 130, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 9, lvMin = 35},
  {name = "Destroyer Easy", monsterName = "Destroyer", amount = 40, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 10, lvMin = 45},

  {name = "Frost Dragon Easy", monsterName = "Frost Dragon Hatchling", amount = 130, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 89, lvMin = 41},
  {name = "Frost Dragon Medium", monsterName = "Frost Dragon", amount = 80, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 11, lvMin = 51},
  {name = "Crystal Spider Easy", monsterName = "Crystal Spider", amount = 45, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 12, lvMin = 27},
  {name = "Ice Witch Easy", monsterName = "Ice Witch", amount = 55, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 13, lvMin = 28},

  {name = "Bloody Easy", monsterName = "Bloody Hunter", amount = 30, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 14, lvMin = 40},
  {name = "Bloody Hard", monsterName = "Bloody Alchemist", amount = 50, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 15, lvMin = 42},

  {name = "Dragons Easy", monsterName = "Dragon Hatchling", amount = 60, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 16, lvMin = 36},
  {name = "Dragons Medium", monsterName = "Dragon", amount = 120, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 17, lvMin = 46},
  {name = "Dragons Extreme", monsterName = "Dragon", amount = 1500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 155, lvMin = 56, customParagon = 3},

  {name = "Sea Serpent Easy", monsterName = "Sea Serpent", amount = 200, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 18, lvMin = 52},
  {name = "Sea Serpent Hard", monsterName = "Sea Serpent", amount = 800, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 153, lvMin = 57, customParagon = 3},
  {name = "Frost Dragon Hard", monsterName = "Zero", amount = 15, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 19, lvMin = 53},

  {name = "Diabolic Imp Easy", monsterName = "Diabolic Imp", amount = 30, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 20, lvMin = 37},
  {name = "Fire Devil Easy", monsterName = "Fire Devil", amount = 45, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 21, lvMin = 28},
  {name = "Behemoth Easy", monsterName = "Behemoth", amount = 70, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 22, lvMin = 47},
  {name = "Behemoth Hard", monsterName = "Behemoth", amount = 320, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 154, lvMin = 54},
  {name = "Dragons Hard", monsterName = "Dragon Lord", amount = 80, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 23, lvMin = 85},
  {name = "Necromancer Easy", monsterName = "Necromancer", amount = 40, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 24, lvMin = 38},


  --NPC DA CIDADE DE FOGO--
  {name = "Golens Easy", resets = 1, monsterName = "Worker Golem", amount = 150, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 25, lvMin = 60},
  {name = "Golens Hard", resets = 1, monsterName = "War Golem", amount = 150, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 26, lvMin = 70},
  {name = "Orc Easy", resets = 1, monsterName = "Orc", amount = 50, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 27, lvMin = 16},
  {name = "Orc Medium", resets = 1, monsterName = "Orc Berserker", amount = 50, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 28, lvMin = 21},
  {name = "Orc Hard", resets = 1, monsterName = "Orc Warlord", amount = 50, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 29, lvMin = 30},
  {name = "Vampires Easy", resets = 1, monsterName = "Vampire", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 30, lvMin = 29},
  {name = "Vampires Medium", resets = 1, monsterName = "Marcelline", amount = 150, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 31, lvMin = 54},
  {name = "Vampires Hard", resets = 1, monsterName = "Abadeer", amount = 550, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 32, lvMin = 80, customParagon = 3},
  {name = "Banshee", resets = 1, monsterName = "Banshee", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 33, lvMin = 61},
  {name = "Hellspawn", resets = 1, monsterName = "Hellspawn", amount = 250, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 34, lvMin = 81},

  {name = "Vulcan Easy", resets = 1, monsterName = "Magma Crawler", amount = 380, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 52, lvMin = 78, customParagon = 2},
  {name = "Vulcan Medium", resets = 1, monsterName = "Vulcongra", amount = 360, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 53, lvMin = 79, customParagon = 2},
  {name = "Vulcan Hard", resets = 1, monsterName = "Orewalker", amount = 290, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 54, lvMin = 85, customParagon = 2},
  {name = "Vulcan Extreme", resets = 1, monsterName = "Weeper", amount = 320, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 55, lvMin = 85, customParagon = 2},
  {name = "Vulcan Hardcore", resets = 1, monsterName = "Cliff Strider", amount = 300, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 75, lvMin = 90, customParagon = 2},

  {name = "Nipper Easy", resets = 1, monsterName = "Frazzlemaw", amount = 360, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 56, lvMin = 82},
  {name = "Nipper Medium", resets = 1, monsterName = "Choking Fear", amount = 300, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 57, lvMin = 83},
  {name = "Nipper Hard", resets = 1, monsterName = "Guzzlemaw", amount = 320, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 58, lvMin = 85},
  {name = "Niper Extreme", resets = 1, monsterName = "Mawhawk", amount = 290, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 59, lvMin = 91},
  {name = "Niper Hardcore", resets = 1, monsterName = "Minotaur Amazon", amount = 310, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 76, lvMin = 92, customParagon = 2},
  {name = "Niper Master", resets = 1, monsterName = "Minotaur Hunter", amount = 380, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 77, lvMin = 95, customParagon = 2},

  {name = "Mine Easy", resets = 1, monsterName = "Deepling Scout", amount = 240, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 78, lvMin = 100},
  {name = "Mine Medium", resets = 1, monsterName = "Deepling Spellsinger", amount = 260, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 79, lvMin = 101},
  {name = "Mine Hard", resets = 1, monsterName = "Deepling Tyrant", amount = 210, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 80, lvMin = 102, customParagon = 2},
  {name = "Mine Extreme", resets = 1, monsterName = "Deepling Warrior", amount = 450, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 81, lvMin = 105, customParagon = 3},

  {name = "Mutation Easy", resets = 1, monsterName = "Mutated Human", amount = 140, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 82, lvMin = 62},
  {name = "Mutation Medium", resets = 1, monsterName = "Mutated Bat", amount = 200, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 83, lvMin = 65},
  {name = "Mutation Hard", resets = 1, monsterName = "Mutated Rat", amount = 300, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 84, lvMin = 71},

  {name = "Giants Extreme", resets = 1, monsterName = "Frost Giantess", amount = 150, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 85, lvMin = 75},
  {name = "Giants Hardcore", resets = 1, monsterName = "Frost Giant", amount = 40, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 86, lvMin = 84},

  {name = "Crystal Golem Hard", resets = 1, monsterName = "Crystal Golem", amount = 350, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 87, lvMin = 110},
  {name = "Crystal Crusher Hard", resets = 1, monsterName = "Crystal Crusher", amount = 320, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 88, lvMin = 115},

  {name = "Askarak Easy", resets = 1, monsterName = "Askarak Demon", amount = 350, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 60, lvMin = 76, customParagon = 2},
  {name = "Askarak Medium", resets = 1, monsterName = "Askarak Lord", amount = 450, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 62, lvMin = 80, customParagon = 3},
  {name = "Askarak Hard", resets = 1, monsterName = "Askarak Prince", amount = 850, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 61, lvMin = 85, customParagon = 4},

  {name = "Shaburak Easy", resets = 1, monsterName = "Shaburak Demon", amount = 450, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 63, lvMin = 80, customParagon = 2},
  {name = "Shaburak Medium", resets = 1, monsterName = "Shaburak Lord", amount = 550, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 64, lvMin = 83, customParagon = 3},
  {name = "Shaburak Hard", resets = 1, monsterName = "Shaburak Prince", amount = 950, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 65, lvMin = 85, customParagon = 4},

  {name = "Vampire Extreme", resets = 1, monsterName = "Nightfiend", amount = 350, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 66, lvMin = 85},
  {name = "Vampire Hardcore", resets = 1, monsterName = "The Pale Count", amount = 430, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 67, lvMin = 93},
  {name = "Vampire Master", resets = 1, monsterName = "Vicious Manbat", amount = 500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 68, lvMin = 95, customParagon = 3},
  {name = "Vampire Torture", resets = 1, monsterName = "Vampire Viscount", amount = 900, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 69, lvMin = 103, customParagon = 4},

  --NPC DA CIDADE DE AIR (MATHE)
  {name = "Mummys Easy", resets = 1, monsterName = "Kashek", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 35, lvMin = 72},
  {name = "Mummys Medium", resets = 1, monsterName = "Munrah", amount = 600, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 36, lvMin = 75, customParagon = 2},
  {name = "Mummys Hard", resets = 1, monsterName = "Kashek", amount = 800, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 37, lvMin = 83, customParagon = 2},
  {name = "Wyvern Easy", resets = 1, monsterName = "Wyvern", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 38, lvMin = 31},
  {name = "Wyrm Easy", resets = 1, monsterName = "Wyrm", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 39, lvMin = 84},
  {name = "Nomads Easy", resets = 1, monsterName = "Air Defensor", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 40, lvMin = 22},


  --NPC DA CIDADE BA-SING-SE--
  {name = "Big Bugs Easy", resets = 1, monsterName = "Tilehorned", amount = 50, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 41, lvMin = 43},
  {name = "Big Bugs Hard", resets = 1, monsterName = "Tilehorned", amount = 300, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 42, lvMin = 48},
  {name = "Bogs Easy", resets = 1, monsterName = "Bog Raider", amount = 50, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 43, lvMin = 60},
  {name = "Bogs Hard", resets = 1, monsterName = "Bog Raider", amount = 300, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 44, lvMin = 63},
  {name = "Primate Easy", resets = 1, monsterName = "Primate", amount = 80, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 45, lvMin = 62},
  {name = "Knights Easy", resets = 1, monsterName = "Black Knight", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 46, lvMin = 47},
  {name = "Knights Hard", resets = 1, monsterName = "Dark Knight", amount = 200, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 47, lvMin = 61},
  {name = "Monkeys Easy", resets = 1, monsterName = "Sibang", amount = 30, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 48, lvMin = 10},
  {name = "Monkeys Hard", resets = 1, monsterName = "Kongra", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 49, lvMin = 17},
  
  {name = "Dwarf Easy", resets = 1, monsterName = "Enslaved Dwarf", amount = 70, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 70, lvMin = 90},
  {name = "Dwarf Medium", resets = 1, monsterName = "Lost Berserker", amount = 150, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 71, lvMin = 94},
  {name = "Dwarf Hard", resets = 1, monsterName = "Lost Basher", amount = 200, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 72, lvMin = 97},
  {name = "Dwarf Extreme", resets = 1, monsterName = "Lost Thrower", amount = 300, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 73, lvMin = 98, customParagon = 2},
  {name = "Dwarf Hardcore", resets = 1, monsterName = "Lost Husher", amount = 550, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 74, lvMin = 104, customParagon = 3},

  {name = "Ogre Brute Easy", monsterName = "Ogre Brute", amount = 300, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 93, lvMin = 105},
  {name = "Ogre Savage Easy", monsterName = "Ogre Savage", amount = 300, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 94, lvMin = 106},
  {name = "Ogre Shaman Easy", monsterName = "Ogre Shaman", amount = 300, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 95, lvMin = 107},
  {name = "Ogre Brute Hard", monsterName = "Ogre Brute", amount = 1000, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 96, lvMin = 110, customParagon = 3},
  {name = "Ogre Savage Hard", monsterName = "Ogre Savage", amount = 1000, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 97, lvMin = 113, customParagon = 3},

  {name = "Sandstone Scorpion Easy", monsterName = "Sandstone Scorpion", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 99, lvMin = 70},
  {name = "Sandstone Scorpion Hard", monsterName = "Sandstone Scorpion", amount = 500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 100, lvMin = 75, customParagon = 2},

  {name = "Deep Terror Easy", monsterName = "Deep Terror", amount = 150, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 101, lvMin = 79},
  {name = "Deep Terror Hard", monsterName = "Deep Terror", amount = 450, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 102, lvMin = 85, customParagon = 2},

  {name = "Plaguesmith Easy", monsterName = "Plaguesmith", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 103, lvMin = 86},
  {name = "Plaguesmith Hard", monsterName = "Plaguesmith", amount = 500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 104, lvMin = 87, customParagon = 2},
 
  {name = "Grimeleech Easy", monsterName = "Grimeleech", amount = 50, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 105, lvMin = 90},
  {name = "Grimeleech Hard", monsterName = "Grimeleech", amount = 350, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 106, lvMin = 92, customParagon = 2},
 
  {name = "Fungus Easy", monsterName = "Hideous Fungus", amount = 250, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 107, lvMin = 91, customParagon = 2},
  {name = "Fungus Medium", monsterName = "Humongous Fungus", amount = 300, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 128, lvMin = 92, customParagon = 2},
  {name = "Fungus Hard", monsterName = "Hideous Fungus", amount = 450, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 108, lvMin = 93, customParagon = 3},
  
  {name = "Ghastly Easy", monsterName = "Ghastly Dragon", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 109, lvMin = 131, customParagon = 2},
  {name = "Ghastly Hard", monsterName = "Ghastly Dragon", amount = 600, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 110, lvMin = 135, customParagon = 3},

  {name = "Moohtant Easy", monsterName = "Moohtant", amount = 20, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 111, lvMin = 136, customParagon = 2},
  {name = "Lava Golem Easy", monsterName = "Lava Golem", amount = 20, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 112, lvMin = 137, customParagon = 2},
  {name = "Jaul Easy", monsterName = "Jaul", amount = 20, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 113, lvMin = 138, customParagon = 2},
  {name = "King Scorpianus Easy", monsterName = "King Scorpianus", amount = 20, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 114, lvMin = 139, customParagon = 2},
  {name = "Abyssador Easy", monsterName = "Abyssador", amount = 20, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 115, lvMin = 140, customParagon = 2},
  {name = "Demodras Easy", monsterName = "Demodras", amount = 20, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 142, lvMin = 141, customParagon = 2},
  
  {name = "Insectoid Scout Easy", monsterName = "Insectoid Scout", amount = 300, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 116, lvMin = 160, customParagon = 2},
  {name = "Spitter Easy", monsterName = "Spitter", amount = 400, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 117, lvMin = 165, customParagon = 3},
  {name = "Spidris Easy", monsterName = "Spidris", amount = 400, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 118, lvMin = 170, customParagon = 3},
  {name = "Spitter Hard", monsterName = "Spitter", amount = 1000, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 120, lvMin = 180, customParagon = 4},
  {name = "Spidris Hard", monsterName = "Spidris", amount = 1000, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 121, lvMin = 185, customParagon = 4},
  
  {name = "Moohtant Medium", monsterName = "Moohtant", amount = 50, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 123, lvMin = 186, customParagon = 3},
  {name = "Lava Golem Medium", monsterName = "Lava Golem", amount = 50, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 124, lvMin = 188, customParagon = 3},
  {name = "Jaul Medium", monsterName = "Jaul", amount = 50, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 125, lvMin = 190, customParagon = 3},
  {name = "King Scorpianus Medium", monsterName = "King Scorpianus", amount = 50, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 126, lvMin = 192, customParagon = 3},
  {name = "Abyssador Medium", monsterName = "Abyssador", amount = 50, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 127, lvMin = 194, customParagon = 3},
  {name = "Demodras Medium", monsterName = "Demodras", amount = 50, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 143, lvMin = 195, customParagon = 3},
 
  {name = "Kollos Easy", monsterName = "Kollos", amount = 20, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 122, lvMin = 200, customParagon = 2},

  {name = "Leviathan Easy", monsterName = "Leviathan", amount = 300, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 130, lvMin = 200, customParagon = 2},
  {name = "Leviathan Medium", monsterName = "Leviathan", amount = 650, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 131, lvMin = 210, customParagon = 3},
  {name = "Leviathan Hard", monsterName = "Leviathan", amount = 1000, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 132, lvMin = 225, customParagon = 4},
  {name = "Leviathan Extreme", monsterName = "Leviathan", amount = 3000, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 133, lvMin = 240, customParagon = 5},
 
  {name = "Elder Wyrm Easy", monsterName = "Elder Wyrm", amount = 300, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 134, lvMin = 205, customParagon = 2},
  {name = "Elder Wyrm Medium", monsterName = "Elder Wyrm", amount = 550, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 135, lvMin = 215, customParagon = 3},
  {name = "Elder Wyrm Hard", monsterName = "Elder Wyrm", amount = 1000, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 136, lvMin = 230, customParagon = 4},
  {name = "Elder Wyrm Extreme", monsterName = "Elder Wyrm", amount = 3000, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 137, lvMin = 250, customParagon = 5},

  {name = "Kelpie Easy", monsterName = "Kelpie", amount = 20, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 138, lvMin = 204, customParagon = 2},
  {name = "Kelpie Medium", monsterName = "Kelpie", amount = 50, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 139, lvMin = 218, customParagon = 3},
 
  {name = "Tyrn Easy", monsterName = "Tyrn", amount = 20, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 140, lvMin = 222, customParagon = 2},
  {name = "Tyrn Medium", monsterName = "Tyrn", amount = 50, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 141, lvMin = 237, customParagon = 3},
   
  {name = "Moohtant Hard", monsterName = "Moohtant", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 144, lvMin = 226, customParagon = 4},
  {name = "Lava Golem Hard", monsterName = "Lava Golem", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 145, lvMin = 227, customParagon = 4},
  {name = "King Scorpianus Hard", monsterName = "King Scorpianus", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 147, lvMin = 229, customParagon = 4},
  {name = "Abyssador Hard", monsterName = "Abyssador", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 148, lvMin = 230, customParagon = 4},
  {name = "Demodras Hard", monsterName = "Demodras", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 149, lvMin = 231, customParagon = 4},
  
  {name = "Grim Reaper Easy", monsterName = "Grim Reaper", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 156, lvMin = 53},
  {name = "Grim Reaper Hard", monsterName = "Grim Reaper", amount = 500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 157, lvMin = 73, customParagon = 2},

  {name = "Medusa Easy", monsterName = "Medusa", amount = 120, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 158, lvMin = 58},
  {name = "Medusa Hard", monsterName = "Medusa", amount = 600, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 159, lvMin = 76, customParagon = 2},

  {name = "Serpent Spawn Medium", monsterName = "Serpent Spawn", amount = 500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 177, lvMin = 75, customParagon = 2},
  {name = "Serpent Spawn Extreme", monsterName = "Serpent Spawn", amount = 1200, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 178, lvMin = 86, customParagon = 3},

  {name = "Beholder Easy", monsterName = "Beholder", amount = 300, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 179, lvMin = 91},
  {name = "Beholder Hard", monsterName = "Elder Beholder", amount = 600, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 180, lvMin = 96, customParagon = 2},
 
  {name = "Energy Elementals Easy", monsterName = "Energy Elemental", amount = 300, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 181, lvMin = 102},
  {name = "Energy Elementals Hard", monsterName = "Energy Overlord", amount = 200, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 182, lvMin = 116, customParagon = 2},
 
  {name = "Undead Dragon Easy", monsterName = "Undead Dragon", amount = 250, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 160, lvMin = 83, customParagon = 2},
  {name = "Undead Dragon Hard", monsterName = "Undead Dragon", amount = 700, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 161, lvMin = 93, customParagon = 3},
 
  {name = "Warlock Easy", monsterName = "Warlock", amount = 150, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 162, lvMin = 60},
  {name = "Warlock Hard", monsterName = "Warlock", amount = 500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 163, lvMin = 62, customParagon = 2},

  {name = "Dark Warlock Easy", monsterName = "Dark Warlock", amount = 150, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 164, lvMin = 120, customParagon = 2},
  {name = "Dark Warlock Hard", monsterName = "Dark Warlock", amount = 350, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 165, lvMin = 130, customParagon = 3},
  
  {name = "Drakens Easy", monsterName = "Draken Elite", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 166, lvMin = 81},
  {name = "Drakens Medium", monsterName = "Draken Spellweaver", amount = 350, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 167, lvMin = 87, customParagon = 2},
  {name = "Drakens Hard", monsterName = "Draken Warmaster", amount = 450, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 168, lvMin = 92, customParagon = 2},
 
  {name = "Lizards Easy", monsterName = "Lizard Legionnaire", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 169, lvMin = 41},
  {name = "Lizards Medium", monsterName = "Lizard High Guard", amount = 200, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 170, lvMin = 47},
  {name = "Lizards Hard", monsterName = "Lizard Chosen", amount = 400, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 171, lvMin = 52, customParagon = 2},
 
  {name = "Sand Dragon Easy", monsterName = "Sand Dragon", amount = 250, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 172, lvMin = 97, customParagon = 2},
  {name = "Sand Dragon Hard", monsterName = "Sand Dragon", amount = 700, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 173, lvMin = 105, customParagon = 3},

  {name = "Death Dragon Easy", monsterName = "Death Dragon", amount = 250, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 174, lvMin = 147, customParagon = 2},
  {name = "Death Dragon Hard", monsterName = "Death Dragon", amount = 500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 175, lvMin = 155, customParagon = 3},

  {name = "Zorvorax Hard", monsterName = "Zorvorax", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 176, lvMin = 171, customParagon = 3},

  {name = "Dragons POI", monsterName = "Dragon", amount = 50, exp = 0, inNpcs = "notHave", money = 0, identifier = 50, lvMin = 915, endAutomatic = true},
  {name = "Dragons Lord POI", monsterName = "Dragon Lord", amount = 10, exp = 0, money = 0, inNpcs = "notHave", identifier = 51, lvMin = 915, endAutomatic = true},
  
  -- Addons -- id do outfit e dps o addon, o 1 eh citizen 15 tasks e 30 tasks, o 21 eh yalaharian 100 e 150 tasks
  
  {name = "Water Outlaws Easy", monsterName = "Water Outlaw", amount = 100, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 223, lvMin = 171},
  {name = "Water Outlaws Hard", monsterName = "Water Outlaw", amount = 500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 224, lvMin = 175, customParagon = 2},
  {name = "Water Outlaws Extreme", monsterName = "Water Outlaw Leader", amount = 350, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 227, lvMin = 180, customParagon = 3},
 
  {name = "Nightstalker Easy", monsterName = "Nightstalker", amount = 120, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 225, lvMin = 177},
  {name = "Dark Fury Hard", monsterName = "Dark Fury", amount = 500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 226, lvMin = 182, customParagon = 3},
  {name = "Dark Fury Extreme", monsterName = "Dark Fury", amount = 1500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 228, lvMin = 191, customParagon = 4},
  
  
 
  {name = "Quara Mantassin Easy", monsterName = "Quara Mantassin", amount = 400, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 229, lvMin = 152, customParagon = 2},
  {name = "Quara Predator Hard", monsterName = "Quara Predator", amount = 450, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 230, lvMin = 161, customParagon = 2},
  {name = "Quara Mantassin Extreme", monsterName = "Quara Mantassin", amount = 900, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 231, lvMin = 168, customParagon = 3},
  
  {name = "Silencer Easy", monsterName = "Silencer", amount = 150, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 232, lvMin = 212, customParagon = 2},
  {name = "Vexclaw Medium", monsterName = "Vexclaw", amount = 450, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 233, lvMin = 217, customParagon = 3},
  {name = "Silencer Hard", monsterName = "Silencer", amount = 850, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 234, lvMin = 222, customParagon = 4},
 
  {name = "Orclops Medium", monsterName = "Orclops Doomhauler", amount = 650, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 235, lvMin = 227, customParagon = 3},
  {name = "Shaper Hard", monsterName = "Shaper Matriarch", amount = 750, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 236, lvMin = 232, customParagon = 3},
  {name = "Orclops Extreme", monsterName = "Orclops Doomhauler", amount = 1500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 237, lvMin = 237, customParagon = 4},

  {name = "Snowman Easy", monsterName = "Muffled Snowman", amount = 250, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 238, lvMin = 182, customParagon = 2},
  {name = "Snowman Medium", monsterName = "Muffled Snowman", amount = 650, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 239, lvMin = 193, customParagon = 3},
  {name = "Snowman Hard", monsterName = "Ancient Snowman", amount = 400, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 240, lvMin = 204, customParagon = 4},
  {name = "Snowman Extreme", monsterName = "Muffled Snowman", amount = 1500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 241, lvMin = 211, customParagon = 4},
  {name = "Olaf Easy", monsterName = "Olaf", amount = 20, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 242, lvMin = 141, customParagon = 2},
  {name = "Olaf Medium", monsterName = "Olaf", amount = 50, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 243, lvMin = 182, customParagon = 3},

  {name = "Zushuka Medium", monsterName = "Zushuka", amount = 500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 244, lvMin = 214, customParagon = 3},
  {name = "Zushuka Hard", monsterName = "Zushuka", amount = 1000, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 245, lvMin = 246, customParagon = 4},
  {name = "Zushuka Extreme", monsterName = "Zushuka", amount = 2500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 246, lvMin = 271, customParagon = 5},
  {name = "Yakchal Hard", monsterName = "Yakchal", amount = 400, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 247, lvMin = 244, customParagon = 3},
  {name = "Yakchal Extreme", monsterName = "Yakchal", amount = 850, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 248, lvMin = 266, customParagon = 4},
  {name = "Kraken Hard", monsterName = "Kraken", amount = 200, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 249, lvMin = 259, customParagon = 5},

  {name = "Horus Hard", monsterName = "Horus", amount = 600, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 250, lvMin = 265, customParagon = 4},
  {name = "Horus Extreme", monsterName = "Horus", amount = 1500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 251, lvMin = 280, customParagon = 5},

  {name = "Carnival Hard", monsterName = "Carnival", amount = 700, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 252, lvMin = 241, customParagon = 4},
  {name = "Carnival Extreme", monsterName = "Carnival", amount = 1500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 253, lvMin = 252, customParagon = 5},
  {name = "Dead Beat Medium", monsterName = "Dead Beat", amount = 450, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 254, lvMin = 223, customParagon = 3},
  {name = "Dead Beat Hard", monsterName = "Dead Beat", amount = 700, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 255, lvMin = 237, customParagon = 4},
  {name = "Dead Beat Extreme", monsterName = "Dead Beat", amount = 1500, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 256, lvMin = 258, customParagon = 5},
  {name = "Mouth of Hell Hard", monsterName = "Mouth of Hell", amount = 200, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 257, lvMin = 260, customParagon = 5},

  {name = "Leecher Easy", monsterName = "Leecher", amount = 250, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 258, lvMin = 219, customParagon = 3},
  {name = "Leecher Medium", monsterName = "Leecher", amount = 550, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 259, lvMin = 234, customParagon = 4},
  {name = "Leecher Hard", monsterName = "Leecher", amount = 850, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 260, lvMin = 245, customParagon = 5},
  {name = "Jafar Hard", monsterName = "Jafar", amount = 400, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 261, lvMin = 263, customParagon = 4},
  {name = "Jafar Extreme", monsterName = "Jafar", amount = 800, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 262, lvMin = 276, customParagon = 5},
  {name = "Machine King Hard", monsterName = "Machine King", amount = 200, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 263, lvMin = 261, customParagon = 5},
  {name = "Death Wing Hard", monsterName = "Death Wing", amount = 200, exp = 0, inNpcs = "geralTasks", money = 0, identifier = 264, lvMin = 262, customParagon = 5}
  -- last identifier = 264
}

function addNewTasks(cid, newLevel)
	for k, v in pairs(tasks) do
		if newLevel >= v.lvMin and v.inNpcs == "geralTasks" then 
			if playerHasTaskInProgress(cid, v.identifier) == false and getPlayerHasEndTask(cid, v.identifier) == false then
				startTaskInPlayer(cid, v.identifier, "Don Corleone")
			end
		end
	end
	return true
end

function getMultiplierByAmount(amount)
	if amount <= 5 then 
		return 2.8
	elseif amount <= 10 then
		return 2.45
	elseif amount <= 20 then 
		return 2.1
	elseif amount <= 30 then 
		return 1.75
	elseif amount <= 50 then 
		return 1.4
	elseif amount <= 100 then 
		return 1.2
	elseif amount <= 150 then 
		return 1
	else 
		return 0.8
	end
end

function refleshTasksInBD()
  --Limpa--
  db.executeQuery("DELETE FROM tasksmonsters WHERE identifier > 0")

  --Carrega Tasks--
  for x = 1, #tasks do
    local current = tasks[x]
	local finalExp = current.exp
	if type(finalExp) == "table" then 
		finalExp = getExperienceForLevel(finalExp[1]+1) - getExperienceForLevel(finalExp[1])
		finalExp = finalExp * (current.exp[2]/100)
	elseif finalExp == 1 then 
		local theStage = getExperienceStage(current.lvMin)
		if current.lvMin >= 30 and current.lvMin <= 60 then 
			theStage = getExperienceStage(43)
		elseif current.lvMin >= 61 and current.lvMin <= 99 then 
			theStage = getExperienceStage(57)
		elseif current.lvMin >= 100 and current.lvMin <= 140 then 
			theStage = getExperienceStage(87) + 0.05
		elseif current.lvMin >= 141 and current.lvMin <= 160 then 
			theStage = getExperienceStage(100) + 0.04
		elseif current.lvMin >= 161 and current.lvMin <= 180 then 
			theStage = getExperienceStage(151) + 0.03
		elseif current.lvMin >= 181 and current.lvMin <= 249 then 
			theStage = getExperienceStage(179) + 0.02
		elseif current.lvMin >= 249 then
			theStage = getExperienceStage(249) + 0.01
		end
		finalExp = (getMonsterInfo(current.monsterName).experience * current.amount) * theStage
		finalExp = finalExp * getMultiplierByAmount(current.amount)
	end 
	finalExp = math.ceil(finalExp)

    db.executeQuery(string.format('INSERT INTO tasksmonsters VALUES("%s", "%s", %s, %s, "%s", %s, %s, %s)', 
    current.name or "NULL", current.monsterName or "NULL", current.amount or "NULL", finalExp or "NULL", current.inNpcs or "NULL", current.money or "NULL", current.identifier or "NULL", current.lvMin or "NULL"))
  end
  --End--

end

local storages = {
  start = 8789 
}


function resetTaskByIdentifier(cid, identifier)
  setPlayerStorageValue(cid, "taskInCourse"..identifier, -1)
  setPlayerStorageValue(cid, "taskInCourseGetMonsters"..identifier, -1)
end

function getTaskIdentifierByMonster(monsterName)
  local tableIdentifier = {}
  for k, v in pairs(tasks) do
    if v.monsterName == monsterName then
      table.insert(tableIdentifier, v.identifier)
    end
  end
  return tableIdentifier
end

function getTaskIdentifierByName(name)
  local tableIdentifier = {}
  for k, v in pairs(tasks) do
    if name == v.name then
      table.insert(tableIdentifier, v.identifier)
    end
  end
  return tableIdentifier
end

function getTaskInfosByIdentifier(identifier)
  for k, v in pairs(tasks) do
    if v.identifier == identifier then
      return tasks[k]
    end
  end
end

function getMonstersHasKilled(cid, identifier)
  return math.max(0, getCreatureStorage(cid, "taskInCourseGetMonsters"..identifier) or 1)
end

function addMonsterInTaskCourse(cid, identifier)
  return setPlayerStorageValue(cid, "taskInCourseGetMonsters"..identifier, getMonstersHasKilled(cid, identifier)+1)
end

function playerHasTaskInProgress(cid, identifier)
  if getCreatureStorage(cid, "taskInCourse"..identifier) == 1 then
    return true
  else
    return false
  end
end

function getPlayerHasEndTask(cid, identifier)
  if getCreatureStorage(cid, "taskInCourse"..identifier) == 2 then
    return true
  else
    return false
  end
end

function getHasCompletedAllTasks(cid)
  local level = getPlayerLevel(cid)

  for x = 1, #tasks do
    local minLevel = tasks[x].lvMin or 0

    if level >= minLevel then
      if not getPlayerHasEndTask(cid, tasks[x].identifier) then
        return false
      end
    end
  end

  return true
end

function getTasksCompleted(cid)
  local count = 0

  for x = 1, #tasks do
    if getPlayerHasEndTask(cid, tasks[x].identifier) then
      count = count+1
    end
  end

  return count
end

function getNpcNameInTask(cid, identifier)
  local npcStorage = getCreatureStorage(cid, "taskInCourse"..identifier.."npcName") 
  if npcStorage == -1 then
    return "unknow"
  else
    return npcStorage  
  end
end

function getTasksInNpc(npc)
  local tableIn = {}
  for x = 1, #tasks do
    if tasks[x].inNpcs == npc then
      table.insert(tableIn, tasks[x])
    end
  end
  return tableIn
end

function ReadableNumber(num, places)
    local ret
    local placeValue = ("%%.%df"):format(places or 0)
    if not num then
        return 0
    elseif num >= 1000000000 then
        ret = placeValue:format(num / 1000000000) .. "kkk" -- billion
    elseif num >= 1000000 then
        ret = placeValue:format(num / 1000000) .. "kk" -- million
    elseif num >= 1000 then
        ret = placeValue:format(num / 1000) .. "k" -- thousand
    else
        ret = num -- hundreds
    end
    return ret
end

--function getValueToNextFreeAddon(cid, counter)
--	local objectives = {15, 30, 100, 150}
	--for i = 1, #objectives do
		--if counter < objectives[i] then
			--return objectives[i] - counter
--		end
	--end
	--return 0
--end

--function getNextAddonName(cid, counter)
	--local objectives = {15, 30, 100, 150}
	--local addonNames = {"Citizen Addon 1", "Citizen Addon 2", "Yalaharian Addon 1", "Yalaharian Addon 2"}
	--for i = 1, #objectives do
	--	if counter < objectives[i] then
	--		return addonNames[i]
	--	end
	--end
	--return ""
--end

--function getNextFreeAddon(cid, counter)
--	local restante = getValueToNextFreeAddon(cid, counter)
	--if restante <= 0 then
		--return ""
	--end
	--return getLangString(cid, "\n\nYou need to finish "..restante.." more tasks to receive the "..getNextAddonName(cid, counter)..".", "\n\nFaltam "..restante.." tasks para você receber o "..getNextAddonName(cid, counter)..".")
--end

--function tryAddNewFreeAddon(cid)
	--local objectives = {15, 30, 100, 150}
	--local addonNames = {"Citizen Addon 1", "Citizen Addon 2", "Yalaharian Addon 1", "Yalaharian Addon 2"}
	--local addonIds = {1, 1, 21, 21}
--	local addonAddons = {1, 2, 1, 2}
--	for i = 1, #objectives do
--		if getTasksCompleted(cid) == objectives[i] and not canPlayerWearOutfitId(cid, addonIds[i], addonAddons[i]) then
	--		doPlayerAddOutfitId(cid, addonIds[i], addonAddons[i])
		--	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, getLangString(cid, "You finished "..objectives[i].." general tasks and received the "..addonNames[i].."!", "Você completou "..objectives[i].." tasks gerais e recebeu o "..addonNames[i].."!"))
			--return true
		--end
	--end
--end

function getAdvancedTaskList(cid, onlyCompleted)
	if not onlyCompleted then
		local string, counter = "\n                                 » General Tasks «\n\n", 0
		for k, v in pairs(tasks) do
			if counter >= 950 then
				break
			end
			if playerHasTaskInProgress(cid, v.identifier) then
				if getMonstersHasKilled(cid, v.identifier) > v.amount then
					string = string..v.name.." ["..v.amount.."/"..v.amount.." - "..getTaskInfosByIdentifier(v.identifier).monsterName.."].\n"
				else
					string = string..v.name.." ["..getMonstersHasKilled(cid, v.identifier).."/"..v.amount.." - "..getTaskInfosByIdentifier(v.identifier).monsterName.."].\n"
				end
				counter = counter+1
			end
		end
		local noTaskStr = getLangString(cid, "\n                                 » General Tasks «\n\nYou don't have current general tasks in progress.\n", "\n                                 » General Tasks «\n\nVocê não possui nenhuma task geral em andamento.\n")
		if counter == 0 then
			return noTaskStr .. ""..getAdvancedTaskList(cid, true)
		else
			return string..""..getAdvancedTaskList(cid, true)
		end
	else
		local counter = getTasksCompleted(cid)
		if type(counter) ~= "number" then
			counter = 0
		end
		if counter <= 0 then
			return getLangString(cid, "", "")
		else
			return ""
		end
	end
end

function startTaskInPlayer(cid, identifier, npcName)
  if getCreatureStorage(cid, "taskInCourse"..identifier) == -1 then
    setPlayerStorageValue(cid, "taskInCourse"..identifier, 1)
    setPlayerStorageValue(cid, "taskInCourse"..identifier.."npcName", npcName)
	sendBlueMessage(cid, getLangString(cid, "New general task started: ".. getTaskInfosByIdentifier(identifier).name .. ". For more information, type !tasks.", "Nova task geral iniciada: ".. getTaskInfosByIdentifier(identifier).name .. ". Para mais informações, digite !tasks."))
    return true
  else
    return false
  end
end

function calculateTaskExpe(cid, identifier)
  local tableInfo = getTaskInfosByIdentifier(identifier)
  local newExp = tableInfo.exp
  if type(newExp) == "table" then 
	local finalExp = getExperienceForLevel(newExp[1]+1) - getExperienceForLevel(newExp[1])
	newExp = finalExp * (newExp[2]/100)
  elseif newExp == 1 then 
	local myLevel = getPlayerLevel(cid)
	if myLevel >= 250 then myLevel = 250 end
	local finalExp = (getMonsterInfo(tableInfo.monsterName).experience * tableInfo.amount) * getExperienceStage(myLevel)
	newExp = finalExp * getMultiplierByAmount(tableInfo.amount)
  end 
	newExp = math.ceil(newExp)


  return newExp
end

function endTaskInPlayer(cid, identifier)
  local tableInfo = getTaskInfosByIdentifier(identifier)

  if getMonstersHasKilled(cid, identifier) >= tableInfo.amount then
	local expFinal = calculateTaskExpe(cid, identifier)
    setPlayerStorageValue(cid, "taskInCourse"..identifier, 2)
--    doPlayerAddExperience(cid, expFinal)
--    doSendAnimatedText(getPlayerPosition(cid), expFinal, TEXTCOLOR_WHITE)
	doSendMagicEffect(getThingPos(cid), 28)
	local finalString = "Task Reward: +1 Paragon Level."
	--tryAddNewFreeAddon(cid)
    if tableInfo.itens ~= nil then
      for k, v in pairs(tableInfo.itens) do
        doPlayerAddItem(cid, v.itemid, v.amount)
		finalString = finalString .. ", " .. v.amount ..  "x " .. getItemNameById(v.itemid) .. ""
      end
    end

    if tableInfo.money ~= nil then
		if tableInfo.money == 1 and tableInfo.outfit ~= nil then
			doPlayerAddOutfitId(cid, tableInfo.outfit[1], tableInfo.outfit[2])
			finalString = finalString .. ", " .. tableInfo.name .. ""
		else
			doPlayerAddMoney(cid, tableInfo.money)
			finalString = finalString .. ""
		end
    end
	finalString = finalString .. "."
	--doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, finalString)
	--local newParagon = getPlayerResets(cid)+1
	--setPlayerResets(cid, newParagon)
	--onUpgradeParagon(cid, newParagon)
    return true
  else
    return false
  end
end