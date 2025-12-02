--[[
 * File destinado ao NpcSystem, preço dos equipamentos e etc.
]]--

--[[
 * InNpcs types: "all", "loot", etc (Serve para setar quais NPCs vão vender ou comprar taís itens.)
 * types: "helmet", "boot", "armor", "legs", "shield", "sword", "axe", "club", "distance", "ammunition", "conteiner", "food", "other"
]]--

routesShip = {
  {name = "Ba Sing Se", pos = {x=573,y=352,z=6}, inNpcs = "mainShip", price = 50},
  {name = "North Water Tribe", pos = {x=348,y=254,z=6}, inNpcs = "mainShip", price = 50},
  {name = "Fire Nation Capital", pos = {x=286,y=455,z=6}, inNpcs = "mainShip", price = 50},
  {name = "South Water Tribe", pos = {x=463,y=873,z=7}, inNpcs = "mainShip", price = 50},

  {name = "Ba Sing Se", pos = {x=552,y=344,z=6}, inNpcs = "appaShip", price = 50},
  {name = "South Air Temple", pos = {x=513,y=688,z=4}, inNpcs = "appaShip", price = 50}
}

itemInfosSell = { --[[Itens que o NPC irá COMPRAR do player, name precisa está em minusculo]]--

  --[[TN]]--
  
 
	{name = "amulet of loss", price=10, itemId=2173, type="amulet", inNpcs="sony"},
  {name = "dark lord amulet", price=6000, itemId=8266, type="amulet", inNpcs="loot"},
  {name = "dark lord armor", price=20000, itemId=12952, type="armor", inNpcs="loot"},
  {name = "dark lord legs", price=20000, itemId=12953, type="legs", inNpcs="loot"},
  {name = "dark lord shield", price=15000, itemId=12921, type="shield", inNpcs="loot"},
  {name = "vulcan amulet", price=5000, itemId=13379, type="amulet", inNpcs="loot"},
  {name = "vulcan robe", price=20000, itemId=11356, type="armor", inNpcs="loot"},
  {name = "vulcan armor", price=15000, itemId=12890, type="armor", inNpcs="loot"},
  {name = "vulcan legs", price=15000, itemId=12914, type="legs", inNpcs="loot"},
  {name = "vulcan axe", price=20000, itemId=13345, type="axe", inNpcs="loot"},
  {name = "firely sword", price=20000, itemId=13341, type="sword", inNpcs="loot"},
  {name = "club of dragonbreath", price=20000, itemId=13437, type="club", inNpcs="loot"},
  {name = "windy amulet", price=5000, itemId=13339, type="amulet", inNpcs="loot"},
  {name = "windy hat", price=15000, itemId=13118, type="helmet", inNpcs="loot"},
  {name = "windy robe", price=15000, itemId=13119, type="armor", inNpcs="loot"},
  {name = "windy kilt", price=12000, itemId=12959, type="legs", inNpcs="loot"},
  {name = "windy legs", price=15000, itemId=13120, type="legs", inNpcs="loot"},
  {name = "windy shield", price=12000, itemId=13300, type="shield", inNpcs="loot"},
  {name = "crystalline axe", price=20000, itemId=13132, type="axe", inNpcs="loot"},
  {name = "crystalline sword", price=20000, itemId=13136, type="sword", inNpcs="loot"},
  {name = "crystalline club", price=20000, itemId=12862, type="club", inNpcs="loot"},
  {name = "heavy helmet", price=30000, itemId=12946, type="helmet", inNpcs="loot"},
  {name = "heavy chest", price=30000, itemId=12792, type="armor", inNpcs="loot"},
  {name = "heavy legs", price=30000, itemId=12785, type="legs", inNpcs="loot"},
  {name = "heavy war axe", price=50000, itemId=12782, type="axe", inNpcs="loot"},
  {name = "heavy axe", price=25000, itemId=13458, type="axe", inNpcs="loot"},
  {name = "heavy war blade", price=50000, itemId=12806, type="sword", inNpcs="loot"},
  {name = "heavy blade", price=25000, itemId=12863, type="sword", inNpcs="loot"},
  {name = "heavy war hammer", price=50000, itemId=13432, type="club", inNpcs="loot"},
  {name = "heavy hammer", price=25000, itemId=13340, type="club", inNpcs="loot"},
  {name = "undead power blade", price=50000, itemId=12649, type="sword", inNpcs="loot"},
  {name = "spellbook of lost souls", price=9000, itemId=8903, type="shield", inNpcs="loot"},
  {name = "ruby necklace", price=2000, itemId=2133, type="amulet", inNpcs="loot"},
  {name = "golden legs", price=10000, itemId=2470, type="legs", inNpcs="loot"},
  {name = "zaoan legs", price=6200, itemId=11304, type="legs", inNpcs="loot"},
  {name = "mastermind shield", price=12150, itemId=2514, type="shield", inNpcs="loot"},
  {name = "jade hammer", price=9000, itemId=7422, type="club", inNpcs="loot"},
  {name = "bonebreaker", price=8150, itemId=7428, type="club", inNpcs="loot"},
  {name = "berserker", price=8000, itemId=7403, type="sword", inNpcs="loot"},
  {name = "epee", price=2500, itemId=2438, type="sword", inNpcs="loot"},
  {name = "demonbone amulet", price=2000, itemId=2136, type="amulet", inNpcs="loot"},
  {name = "primate legs", price=9500, itemId=2507, type="legs", inNpcs="loot"},
  {name = "banana staff", price=150, itemId=3966, type="club", inNpcs="loot"},
  {name = "boggy legs", price=6000, itemId=12957, type="legs", inNpcs="loot"},
  {name = "jungle axe", price=12000, itemId=12793, type="axe", inNpcs="loot"},
  {name = "belted cape", price=3400, itemId=8872, type="armor", inNpcs="loot"},
  {name = "ruthless axe", price=9000, itemId=6553, type="axe", inNpcs="loot"},
  {name = "silver mace", price=2505, itemId=2424, type="club", inNpcs="loot"},
  {name = "wyrmhunter robe", price=16200, itemId=11355, type="armor", inNpcs="loot"},
  {name = "focus cape", price=2500, itemId=8871, type="armor", inNpcs="loot"},
  {name = "composite hornbow", price=12200, itemId=8855, type="distance", inNpcs="loot"},
  {name = "vampire coat", price=17800, itemId=12607, type="armor", inNpcs="loot"},
  {name = "vampire chopper", price=16000, itemId=12852, type="axe", inNpcs="loot"},
  {name = "ironworker", price=7800, itemId=8853, type="armor", inNpcs="loot"},
  {name = "vile axe", price=3500, itemId=7388, type="axe", inNpcs="loot"},
  {name = "onix flail", price=2000, itemId=7421, type="club", inNpcs="loot"},
  {name = "spawn hammer", price=17505, itemId=13342, type="club", inNpcs="loot"},
  {name = "nightmare shield", price=16100, itemId=6391, type="shield", inNpcs="loot"},
  {name = "spawn legs", price=10800, itemId=12936, type="legs", inNpcs="loot"},
  {name = "tortoise shield", price=100, itemId=6131, type="shield", inNpcs="loot"},
  {name = "obsidian lance", price=1205, itemId=2425, type="axe", inNpcs="loot"},
  {name = "shield of honour", price=6100, itemId=2517, type="shield", inNpcs="loot"},
  {name = "dark trinity mace", price=10800, itemId=8927, type="club", inNpcs="loot"},
  {name = "blessed sceptre", price=4500, itemId=7429, type="club", inNpcs="loot"},
  {name = "poison dagger", price=40, itemId=2411, type="sword", inNpcs="loot"},
  {name = "eshena hat", price=7000, itemId=10570, type="helmet", inNpcs="loot"},
  {name = "eshena legs", price=7000, itemId=13120, type="legs", inNpcs="loot"},
  {name = "short sword", price=2, itemId=2406, type="sword", inNpcs="loot"},
  {name = "mercenary sword", price=3800, itemId=7386, type="sword", inNpcs="loot"},
  {name = "ornamented axe", price=4500, itemId=7411, type="axe", inNpcs="loot"},
  {name = "wyvern armor", price=4000, itemId=8891, type="armor", inNpcs="loot"},
  {name = "yol's bow", price=3500, itemId=8856, type="distance", inNpcs="loot"},
  {name = "dragon scale mail", price=11000, itemId=2492, type="armor", inNpcs="loot"},
  {name = "zaoan armor", price=13200, itemId=11301, type="armor", inNpcs="loot"},
  {name = "zaoan helmet", price=14000, itemId=11302, type="helmet", inNpcs="loot"},
  {name = "tower shield", price=2500, itemId=2528, type="shield", inNpcs="loot"},
  {name = "dragon slayer", price=2580, itemId=7402, type="sword", inNpcs="loot"},
  {name = "sapphire hammer", price=800, itemId=7437, type="club", inNpcs="loot"},
  {name = "platinum amulet", price=200, itemId=2171, type="amulet", inNpcs="loot"},
  {name = "glacier mask", price=1030, itemId=7902, type="helmet", inNpcs="loot"},
  {name = "mystic turban", price=3000, itemId=2663, type="helmet", inNpcs="loot"},
  {name = "serpent sword", price=890, itemId=2409, type="sword", inNpcs="loot"},
  {name = "goldensilver shield", price=15000, itemId=12929, type="shield", inNpcs="loot"},
  {name = "umbral fire sword", price=16000, itemId=12869, type="sword", inNpcs="loot"},
  {name = "umbral fire robe", price=15500, itemId=13305, type="armor", inNpcs="loot"},
  {name = "terra mantle", price=4500, itemId=7884, type="armor", inNpcs="loot"},
  {name = "terra legs", price=4500, itemId=7885, type="legs", inNpcs="loot"},
  {name = "titan axe", price=2800, itemId=7413, type="axe", inNpcs="loot"},
  {name = "skullcracker armor", price=6000, itemId=8889, type="armor", inNpcs="loot"},
  {name = "nightmare blade", price=3000, itemId=7418, type="sword", inNpcs="loot"},
  {name = "wolf tooth chain", price=50, itemId=2129, type="amulet", inNpcs="loot"},
  {name = "strange boots of haste", price=13200, itemId=12934, type="boot", inNpcs="loot"},
  {name = "dragon scale boots", price=13000, itemId=11118, type="boot", inNpcs="loot"},
  {name = "golden-slim axe", price=13500, itemId=12848, type="axe", inNpcs="loot"},
  {name = "savage sword", price=11000, itemId=12870, type="sword", inNpcs="loot"},
  {name = "yellow sword", price=14000, itemId=12867, type="sword", inNpcs="loot"},
  {name = "ear muffs", price=200, itemId=7459, type="helmet", inNpcs="loot"},
  {name = "garlic necklace", price=510, itemId=2199, type="amulet", inNpcs="loot"},
  {name = "dragon hammer", price=380, itemId=2434, type="hammer", inNpcs="loot"},
  {name = "cooper shield", price=30, itemId=2530, type="shield", inNpcs="loot"},
  {name = "brass armor", price=75, itemId=2465, type="armor", inNpcs="loot"},
  {name = "brass shield", price=20, itemId=2511, type="shield", inNpcs="loot"},
  {name = "hatchet", price=15, itemId=2388, type="axe", inNpcs="loot"},
  {name = "studded armor", price=15, itemId=2484, type="armor", inNpcs="loot"},
  {name = "dwarven shield", price=90, itemId=2525, type="shield", inNpcs="loot"},
  {name = "battle axe", price=65, itemId=2378, type="axe", inNpcs="loot"},
  {name = "chain armor", price=75, itemId=2464, type="armor", inNpcs="loot"},
  {name = "plate armor", price=350, itemId=2463, type="armor", inNpcs="loot"},
  {name = "plate legs", price=350, itemId=2647, type="legs", inNpcs="loot"},
  {name = "soldier helmet", price=20, itemId=2481, type="helmet", inNpcs="loot"},
  {name = "brass helmet", price=35, itemId=2460, type="helmet", inNpcs="loot"},
  {name = "leather boots", price=2, itemId=2643, type="boots", inNpcs="loot"},
  {name = "steel helmet", price=220, itemId=2457, type="helmet", inNpcs="loot"},
  {name = "battle hammer", price=120, itemId=2417, type="club", inNpcs="loot"},
  {name = "dragonbone staff", price=420, itemId=7430, type="club", inNpcs="loot"},
  {name = "battle shield", price=75, itemId=2513, type="shield", inNpcs="loot"},
  {name = "bone shield", price=75, itemId=2541, type="shield", inNpcs="loot"},
  {name = "scale armor", price=60, itemId=2483, type="armor", inNpcs="loot"},
  {name = "double axe", price=260, itemId=2387, type="axe", inNpcs="loot"},
  {name = "iron helmet", price=130, itemId=2459, type="helmet", inNpcs="loot"},
  {name = "clerical mace", price=170, itemId=2423, type="club", inNpcs="loot"},
  {name = "mammoth whopper", price=470, itemId=7381, type="club", inNpcs="loot"},
  {name = "studded legs", price=15, itemId=2468, type="legs", inNpcs="loot"},
  {name = "dark helmet", price=100, itemId=2490, type="helmet", inNpcs="loot"},
  {name = "halberd", price=470, itemId=2381, type="axe", inNpcs="loot"},
  {name = "war hammer", price=850, itemId=2391, type="club", inNpcs="loot"},
  {name = "dark armor", price=500, itemId=2489, type="armor", inNpcs="loot"},
  {name = "spiked squelcher", price=750, itemId=7452, type="club", inNpcs="loot"},  
  {name = "two handed sword", price=400, itemId=2377, type="sword", inNpcs="loot"},
  {name = "vampire shield", price=8000, itemId=2534, type="shield", inNpcs="loot"},
  {name = "ancient earth shield", price=13000, itemId=12923, type="shield", inNpcs="loot"},
  {name = "firelywood sword", price=15000, itemId=11395, type="sword", inNpcs="loot"},
  {name = "lava axe", price=15000, itemId=12855, type="axe", inNpcs="loot"},
  {name = "dragonbone shield", price=14000, itemId=12926, type="shield", inNpcs="loot"},
  {name = "dragonhunter robe", price=14000, itemId=12657, type="armor", inNpcs="loot"},
  {name = "strange helmet", price=1300, itemId=2479, type="helmet", inNpcs="loot"},
  {name = "dragon shield", price=2550, itemId=2516, type="shield", inNpcs="loot"},
  {name = "vampire helmet", price=2000, itemId=12789, type="helmet", inNpcs="loot"},
  {name = "katana", price=30, itemId=2412, type="sword", inNpcs="loot"},
  {name = "bone sword", price=20, itemId=2450, type="sword", inNpcs="loot"},
  {name = "spike sword", price=70, itemId=2383, type="sword", inNpcs="loot"},
  {name = "knight armor", price=3000, itemId=2476, type="armor", inNpcs="loot"},
  {name = "crown armor", price=5000, itemId=2487, type="armor", inNpcs="loot"},
  {name = "bloody robe", price=6100, itemId=8867, type="armor", inNpcs="loot"},
  {name = "dark shield", price=20, itemId=2521, type="shield", inNpcs="loot"},
  {name = "dwarven legs", price=4500, itemId=2504, type="legs", inNpcs="loot"},
  {name = "crown shield", price=4300, itemId=2519, type="shield", inNpcs="loot"},
  {name = "mystic blade", price=2000, itemId=7384, type="sword", inNpcs="loot"},
  {name = "orcish maul", price=2200, itemId=7392, type="club", inNpcs="loot"},
  {name = "golden armor", price=5900, itemId=2466, type="armor", inNpcs="loot"},
  {name = "crimson sword", price=700, itemId=7385, type="sword", inNpcs="loot"},
  {name = "cranial basher", price=4100, itemId=7415, type="club", inNpcs="loot"},
  {name = "crown legs", price=4150, itemId=2488, type="legs", inNpcs="loot"},
  {name = "justice seeker", price=4500, itemId=7390, type="sword", inNpcs="loot"},
  {name = "chaos mace", price=1500, itemId=7427, type="club", inNpcs="loot"},
  {name = "blue legs", price=4300, itemId=7730, type="legs", inNpcs="loot"},
  {name = "heroic axe", price=1500, itemId=7389, type="axe", inNpcs="loot"},
  {name = "war axe", price=6000, itemId=2454, type="axe", inNpcs="loot"},
  {name = "relic sword", price=3450, itemId=7383, type="sword", inNpcs="loot"},
  {name = "beholder shield", price=1000, itemId=2518, type="shield", inNpcs="loot"},
  {name = "wyvern fang", price=1200, itemId=7408, type="sword", inNpcs="loot"},
  {name = "noble armor", price=520, itemId=2486, type="armor", inNpcs="loot"},
  {name = "ornamented shield", price=130, itemId=2524, type="shield", inNpcs="loot"},
  {name = "djinn blade", price=1700, itemId=2451, type="sword", inNpcs="loot"},
  {name = "dwarven axe", price=1150, itemId=2435, type="axe", inNpcs="loot"},
  {name = "taurus mace", price=300, itemId=7425, type="club", inNpcs="loot"},
  {name = "headchopper", price=1600, itemId=7380, type="axe", inNpcs="loot"},
  {name = "heavy mace", price=7000, itemId=2452, type="club", inNpcs="loot"},
  {name = "barbarian curse elmo", price=6050, itemId=12791, type="helmet", inNpcs="loot"},
  {name = "haringer harash", price=5100, itemId=12810, type="armor", inNpcs="loot"},
  {name = "reapering", price=9500, itemId=12843, type="axe", inNpcs="loot"},
  {name = "headedness bow", price=10100, itemId=13320, type="distance", inNpcs="loot"},
  {name = "scarf", price=200, itemId=2661, type="amulet", inNpcs="loot"},
  {name = "morning star", price=70, itemId=2394, type="club", inNpcs="loot"},
  {name = "warrior helmet", price=1300, itemId=2475, type="helmet", inNpcs="loot"},
  {name = "glacier robe", price=5500, itemId=7897, type="armor", inNpcs="loot"},
  {name = "skull helmet", price=2300, itemId=5741, type="helmet", inNpcs="loot"},
  {name = "longsword", price=45, itemId=2397, type="sword", inNpcs="loot"},
  {name = "plate shield", price=40, itemId=2510, type="shield", inNpcs="loot"},
  {name = "elvish bow", price=2100, itemId=7438, type="distance", inNpcs="loot"},
  {name = "sandals", price=2, itemId=2642, type="boot", inNpcs="loot"},
  {name = "heavy machete", price=49, itemId=2442, type="sword", inNpcs="loot"},
  {name = "daramanian mace", price=75, itemId=2439, type="sword", inNpcs="loot"},
  {name = "hand axe", price=15, itemId=2380, type="club", inNpcs="loot"},
  {name = "leather helmet", price=4, itemId=2461, type="helmet", inNpcs="loot"},
  {name = "wooden shield", price=9, itemId=2512, type="shield", inNpcs="loot"},
  {name = "steel shield", price=75, itemId=2509, type="shield", inNpcs="loot"},
  {name = "chain helmet", price=15, itemId=2458, type="helmet", inNpcs="loot"},
  {name = "skull staff", price=1800, itemId=2436, type="club", inNpcs="loot"},
  {name = "dragon lance", price=8000, itemId=2414, type="axe", inNpcs="loot"},
  {name = "boots of haste", price=9000, itemId=2195, type="boots", inNpcs="loot"},
  {name = "zaoan shoes", price=3000, itemId=11303, type="boots", inNpcs="loot"},
  {name = "knight legs", price=3000, itemId=2477, type="legs", inNpcs="loot"},
  {name = "knight axe", price=1500, itemId=2430, type="axe", inNpcs="loot"},
  {name = "scarab shield", price=1000, itemId=2540, type="shield", inNpcs="loot"},
  {name = "daramanian waraxe", price=2000, itemId=2440, type="axe", inNpcs="loot"},
  {name = "scarab amulet", price=300, itemId=2135, type="amulet", inNpcs="loot"},
  {name = "royal helmet", price=12000, itemId=2498, type="helmet", inNpcs="loot"},
  {name = "medusa shield", price=6000, itemId=2536, type="shield", inNpcs="loot"},
  {name = "ancient axe", price=10000, itemId=2443, type="axe", inNpcs="loot"},
  {name = "ancient hammer of wrath", price=12000, itemId=2444, type="club", inNpcs="loot"},
  {name = "crown helmet", price=1800, itemId=2491, type="helmet", inNpcs="loot"},
  {name = "scarab shield", price=500, itemId=2540, type="shield", inNpcs="loot"},
  {name = "blue robe", price=1050, itemId=2656, type="armor", inNpcs="loot"},
  {name = "glacier kilt", price=4200, itemId=7896, type="legs", inNpcs="loot"},
  {name = "water blade", price=4500, itemId=7407, type="sword", inNpcs="loot"},
  {name = "mace", price=35, itemId=2398, type="club", inNpcs="loot"},
  {name = "axe", price=15, itemId=2386, type="axe", inNpcs="loot"},
  {name = "staff", price=50, itemId=2401, type="club", inNpcs="loot"},
  {name = "guardian shield", price=2200, itemId=2515, type="shield", inNpcs="loot"},
  {name = "fire sword", price=4500, itemId=2392, type="sword", inNpcs="loot"},
  {name = "assassin dagger", price=5500, itemId=7404, type="sword", inNpcs="loot"},
  {name = "brass legs", price=120, itemId=2478, type="legs", inNpcs="loot"},
  {name = "bone club", price=13, itemId=2449, type="club", inNpcs="loot"},
  {name = "firely armor", price=2300, itemId=12755, type="armor", inNpcs="loot"},
  {name = "zuko sword", price=1000, itemId=11307, type="sword", inNpcs="loot"},
  {name = "drakinata", price=1200, itemId=11305, type="axe", inNpcs="loot"},
  {name = "zaoan halberd", price=800, itemId=11323, type="axe", inNpcs="loot"},
  {name = "stoned elmo", price=2200, itemId=11422, type="helmet", inNpcs="loot"},
  {name = "firely hat", price=1700, itemId=12802, type="helmet", inNpcs="loot"},
  {name = "stoned cleaver", price=1700, itemId=12795, type="axe", inNpcs="loot"},
  {name = "steel boots", price=12500, itemId=2645, type="boots", inNpcs="loot"},
  {name = "giant sword", price=11000, itemId=2393, type="sword", inNpcs="loot"},
  {name = "horned armor", price=27000, itemId=12882, type="armor", inNpcs="loot"},
  {name = "beastslayer axe", price=610, itemId=3962, type="axe", inNpcs="loot"},
  {name = "fur boots", price=810, itemId=7457, type="boots", inNpcs="loot"},
  {name = "mammoth fur shorts", price=140, itemId=7464, type="legs", inNpcs="loot"},
  {name = "mammoth fur cape", price=400, itemId=7463, type="armor", inNpcs="loot"},
  {name = "krimhorn helmet", price=310, itemId=7461, type="helmet", inNpcs="loot"},
  {name = "crusader helmet", price=1610, itemId=2497, type="helmet", inNpcs="loot"},
  {name = "crystal sword", price=340, itemId=7449, type="sword", inNpcs="loot"},
  {name = "ragnir helmet", price=210, itemId=7462, type="helmet", inNpcs="loot"},
  {name = "broadsword", price=120, itemId=2413, type="sword", inNpcs="loot"},
  {name = "scimitar", price=230, itemId=2419, type="sword", inNpcs="loot"},
  {name = "magma coat", price=5700, itemId=7899, type="armor", inNpcs="loot"},
  {name = "magma monocle", price=4700, itemId=7900, type="helmet", inNpcs="loot"},
  {name = "foldbook of warding", price=6000, itemId=8901, type="shield", inNpcs="loot"},
  {name = "noble axe", price=3000, itemId=7456, type="axe", inNpcs="loot"},





  {name = "gear wheel", price=415, itemId=9690, type="other", inNpcs="loot"},
  {name = "boggy dreads", price=310, itemId=10584, type="other", inNpcs="loot"},
  {name = "small topaz", price=250, itemId=9970, type="other", inNpcs="loot"},
  {name = "dracoyle statue", price=1000, itemId=9948, type="other", inNpcs="loot"},
  {name = "violet gem", price=6000, itemId=2153, type="other", inNpcs="loot"},
  {name = "giant shimmering pearl", price=1500, itemId=7632, type="other", inNpcs="loot"},
  {name = "small ruby", price=250, itemId=2147, type="other", inNpcs="loot"},
  {name = "turtle shell", price=12, itemId=5899, type="other", inNpcs="loot"},
  {name = "thorn", price=21, itemId=10560, type="other", inNpcs="loot"},
  {name = "banshee necklace", price=210, itemId=12436, type="other", inNpcs="loot"},
  {name = "fool golden", price=12, itemId=12422, type="other", inNpcs="loot"},
  {name = "piece of orc skin", price=5, itemId=12435, type="other", inNpcs="loot"},
  {name = "witch staff", price=235, itemId=12408, type="other", inNpcs="loot"},
  {name = "bunch of troll hair", price=2, itemId=10606, type="other", inNpcs="loot"},
  {name = "bandit's backpack", price=15, itemId=12425, type="other", inNpcs="loot"},
  {name = "behemoth claw", price=520, itemId=5930, type="other", inNpcs="loot"},
  {name = "emerald bangle", price=500, itemId=2127, type="other", inNpcs="loot"},
  {name = "bear paw", price=35, itemId=5896, type="other", inNpcs="loot"},
  {name = "undead heart", price=35, itemId=11367, type="other", inNpcs="loot"},
  {name = "piece of hydra leather", price=45, itemId=11196, type="other", inNpcs="loot"},
  {name = "hydramat hearth", price=2200, itemId=12638, type="other", inNpcs="loot"},
  {name = "perfect behemoth fang", price=300, itemId=5893, type="other", inNpcs="loot"},
  {name = "strange symbol", price=3000, itemId=2174, type="other", inNpcs="loot"},
  {name = "fire egg", price=80, itemId=11400, type="other", inNpcs="loot"},
  {name = "metal bracelet", price=400, itemId=11322, type="other", inNpcs="loot"},
  {name = "wyrm scale", price=400, itemId=10582, type="other", inNpcs="loot"},
  {name = "essence of a bad dream", price=835, itemId=11223, type="other", inNpcs="loot"},
  {name = "wyvern talisman", price=105, itemId=10561, type="other", inNpcs="loot"},
  {name = "mutated bat ear", price=335, itemId=10579, type="other", inNpcs="loot"},
  {name = "red dragon leather", price=1235, itemId=5948, type="other", inNpcs="loot"},
  {name = "red dragon scale", price=1335, itemId=5882, type="other", inNpcs="loot"},
  {name = "sea serpent scale", price=135, itemId=10583, type="other", inNpcs="loot"},
  {name = "brown piece of cloth", price=200, itemId=5913, type="other", inNpcs="loot"},
  {name = "black pearl", price=230, itemId=2144, type="other", inNpcs="loot"},
  {name = "white pearl", price=230, itemId=2143, type="other", inNpcs="loot"},
  {name = "shard", price=190, itemId=7290, type="other", inNpcs="loot"},
  {name = "dwarven beard", price=9, itemId=5900, type="other", inNpcs="loot"},
  {name = "soul orb", price=235, itemId=5944, type="other", inNpcs="loot"},
  {name = "demonic essence", price=80, itemId=6500, type="other", inNpcs="loot"},
  {name = "lizard leather", price=120, itemId=5876, type="other", inNpcs="loot"},
  {name = "lizard scale", price=120, itemId=5881, type="other", inNpcs="loot"},
  {name = "red lantern", price=100, itemId=11206, type="other", inNpcs="loot"},
  {name = "spiked iron ball", price=100, itemId=11325, type="other", inNpcs="loot"},
  {name = "high guard flag", price=110, itemId=11332, type="other", inNpcs="loot"},
  {name = "bunch of ripe rice", price=110, itemId=11245, type="other", inNpcs="loot"},
  {name = "broken halberd", price=110, itemId=11335, type="other", inNpcs="loot"},
  {name = "legionnaire flag", price=115, itemId=11334, type="other", inNpcs="loot"},
  {name = "magic sulphur", price=170, itemId=5904, type="other", inNpcs="loot"},
  {name = "fish fin", price=190, itemId=5895, type="other", inNpcs="loot"},
  {name = "bloody pincer", price=130, itemId=10550, type="other", inNpcs="loot"},
  {name = "crab pincers", price=20, itemId=11189, type="other", inNpcs="loot"},
  {name = "feather headdress", price=230, itemId=3970, type="other", inNpcs="loot"},
  {name = "inkwell", price=10, itemId=2600, type="other", inNpcs="loot"},
  {name = "giant spider silk", price=130, itemId=5879, type="other", inNpcs="loot"},
  {name = "mysterious fetish", price=280, itemId=2194, type="other", inNpcs="loot"},
  {name = "mind stone", price=590, itemId=2178, type="other", inNpcs="loot"},
  {name = "scarab coin", price=3, itemId=2159, type="other", inNpcs="loot"},
  {name = "grave flower", price=14, itemId=2747, type="other", inNpcs="loot"},
  {name = "waterskin", price=13, itemId=2031, type="other", inNpcs="loot"},
  {name = "heaven blossom", price=70, itemId=5921, type="other", inNpcs="loot"},
  {name = "holy orchid", price=100, itemId=5922, type="other", inNpcs="loot"},
  {name = "piece of dead brain", price=25, itemId=10580, type="other", inNpcs="loot"},
  {name = "bat wing", price=7, itemId=5894, type="other", inNpcs="loot"},
  {name = "cyclops eye", price=50, itemId=5898, type="other", inNpcs="loot"},
  {name = "cyclops toe", price=9, itemId=10574, type="other", inNpcs="loot"},  
  {name = "iron ore", price=6, itemId=5880, type="other", inNpcs="loot"},
  {name = "lump of dirt", price=4, itemId=10609, type="other", inNpcs="loot"},
  {name = "worm", price=1, itemId=3976, type="other", inNpcs="loot"},
  {name = "small amethyst", price=150, itemId=2150, type="other", inNpcs="loot"},
  {name = "small sapphire", price=200, itemId=2146, type="other", inNpcs="loot"},  
  {name = "small diamond", price=210, itemId=2145, type="other", inNpcs="loot"},
  {name = "small emerald", price=130, itemId=2149, type="other", inNpcs="loot"},
  {name = "yellow gem", price=690, itemId=2154, type="other", inNpcs="loot"},
  {name = "green gem", price=990, itemId=2155, type="other", inNpcs="loot"},
  {name = "red gem", price=890, itemId=2156, type="other", inNpcs="loot"},
  {name = "demonic skeletal hand", price=150, itemId=10564, type="other", inNpcs="loot"},
  {name = "skeletal bone", price=20, itemId=12437, type="other", inNpcs="loot"},
  {name = "ghoul snack", price=15, itemId=12423, type="other", inNpcs="loot"},
  {name = "terrorbird beak", price=120, itemId=11190, type="other", inNpcs="loot"},
  {name = "coloured terror feather", price=170, itemId=12640, type="other", inNpcs="loot"},
  {name = "scarab pincers", price=220, itemId=10548, type="other", inNpcs="loot"},
  {name = "broken elmo", price=360, itemId=12409, type="other", inNpcs="loot"},
  {name = "ancient stone", price=150, itemId=10549, type="other", inNpcs="loot"},
  {name = "stone wing", price=75, itemId=11195, type="other", inNpcs="loot"},
  {name = "spider fang", price=11, itemId=8859, type="other", inNpcs="loot"},
  {name = "widow mandibles", price=110, itemId=11328, type="other", inNpcs="loot"},
  {name = "carrion fang", price=55, itemId=11192, type="other", inNpcs="loot"},
  {name = "vampire teeth", price=200, itemId=10602, type="other", inNpcs="loot"},
  {name = "red piece of cloth", price=570, itemId=5911, type="other", inNpcs="loot"},
  {name = "annihilator doll", price=70000, itemId=11144, type="other", inNpcs="loot"},
  {name = "silver goblet", price=100, itemId=5806, type="other", inNpcs="loot"},
  {name = "hardened bone", price=4000, itemId=5925, type="other", inNpcs="loot"},
  {name = "midnight shard", price=4000, itemId=10531, type="other", inNpcs="loot"},
  {name = "cat's paw", price=3000, itemId=5480, type="other", inNpcs="loot"},
  {name = "ape fur", price=20, itemId=5883, type="other", inNpcs="loot"},
  {name = "bundle of cursed straw", price=490, itemId=10605, type="other", inNpcs="loot"},
  {name = "wedding ring", price=300, itemId=2121, type="other", inNpcs="loot"},
  {name = "crystal ring", price=300, itemId=2124, type="other", inNpcs="loot"}



}

itemInfosBuy = { --[[Itens que o NPC irá VENDER para o player, name precisa está em minusculo]]--  

  {name = "rope", price=25, itemId=2120, type="other", inNpcs="lootSuport"},
  {name = "shovel", price=10, itemId=2554, type="other", inNpcs="lootSuport"},
  {name = "pick", price=120, itemId=2553, type="other", inNpcs="lootSuport"},
  {name = "backpack", price=20, itemId=1988, type="conteiner", inNpcs="lootSuport"},
  {name = "fishing rod", price=150, itemId=2580, type="other", inNpcs="lootSuport"},
  {name = "bag", price=8, itemId=1987, type="conteiner", inNpcs="lootSuport"},
  {name = "worm", price=3, itemId=3976, type="other", inNpcs="lootSuport"},
  {name = "water pouch", price=400, itemId=4863, type="other", inNpcs="lootSuport"},



  {name = "strong mana potion", price=90, itemId=7589, type="other", inNpcs="magicSupport"},
  {name = "great mana potion", price=240, itemId=7590, type="other", inNpcs="magicSupport"},
  {name = "mana potion", price=35, itemId=7620, type="other", inNpcs="magicSupport"},



  {name = "strong health potion", price=110, itemId=13367, type="other", inNpcs="healthSupport"},
  {name = "great health potion", price=280, itemId=13368, type="other", inNpcs="healthSupport"},
  {name = "ultimate health potion", price=500, itemId=15014, type="other", inNpcs="healthSupport"},
  {name = "health potion", price=40, itemId=13366, type="other", inNpcs="healthSupport"},



  {name = "crossbow", price=210, itemId=2455, type="distance", inNpcs="simpleDistance"},
  {name = "bow", price=130, itemId=2456, type="distance", inNpcs="simpleDistance"},
  {name = "royal spear", price=70, itemId=7378, type="ammunition", inNpcs="simpleDistance"},
  {name = "enchanted spear", price=140, itemId=7367, type="ammunition", inNpcs="simpleDistance"},
  {name = "spear", price=20, itemId=2389, type="ammunition", inNpcs="simpleDistance"},
  {name = "assassin star", price=400, itemId=7368, type="ammunition", inNpcs="simpleDistance"},
  {name = "throwing star", price=70, itemId=2399, type="ammunition", inNpcs="simpleDistance"},
  {name = "throwing knife", price=20, itemId=2410, type="ammunition", inNpcs="simpleDistance"},
  {name = "viper star", price=200, itemId=7366, type="ammunition", inNpcs="simpleDistance"},
  {name = "poison arrow", price=10, itemId=2545, type="ammunition", inNpcs="simpleDistance"},
  {name = "burst arrow", price=10, itemId=2546, type="ammunition", inNpcs="simpleDistance"},
  {name = "sniper arrow", price=15, itemId=7364, type="ammunition", inNpcs="simpleDistance"},
  {name = "onyx arrow", price=20, itemId=7365, type="ammunition", inNpcs="simpleDistance"},
  {name = "piercing bolt", price=15, itemId=7363, type="ammunition", inNpcs="simpleDistance"},
  {name = "power bolt", price=35, itemId=2547, type="ammunition", inNpcs="simpleDistance"},
  {name = "infernal bolt", price=400, itemId=6529, type="ammunition", inNpcs="simpleDistance"},
  {name = "arrow", price=3, itemId=2544, type="ammunition", inNpcs="simpleDistance"},
  {name = "bolt", price=4, itemId=2543, type="ammunition", inNpcs="simpleDistance"},



  {name = "label", price=45, itemId=2599, type="other", inNpcs="postman"},
  {name = "parcel", price=55, itemId=2595, type="conteiner", inNpcs="postman"},
  {name = "letter", price=45, itemId=2597, type="other", inNpcs="postman"},



  {name = "fish", price=7, itemId=2667, type="food", inNpcs="meatFood"},
  {name = "ham", price=6, itemId=2671, type="food", inNpcs="meatFood"},
  {name = "meat", price=3, itemId=2666, type="food", inNpcs="meatFood"},



  {name = "fish", price=7, itemId=2667, type="food", inNpcs="foodFire"},
  {name = "ham", price=6, itemId=2671, type="food", inNpcs="foodFire"},
  {name = "meat", price=3, itemId=2666, type="food", inNpcs="foodFire"},
  {name = "salmon", price=19, itemId=2668, type="food", inNpcs="foodFire"},
  {name = "red apple", price=2, itemId=2674, type="food", inNpcs="foodFire"},
  {name = "banana", price=3, itemId=2676, type="food", inNpcs="foodFire"},
  {name = "pear", price=4, itemId=2673, type="food", inNpcs="foodFire"}

  --{name = "beer", price=9, itemId=2015, subType=3, type="drink", inNpcs="drink"},

}


npcLootOfferMensage = {"I'm buying a lot of things, to know if I buy or not, say SELL + your item name or SELL ALL LOOT.", "Eu compro várias coisas, para saber o que eu compro diga SELL + nome do item ou SELL ALL LOOT."}
npclootOfferMensage = {"I'm buying a lot of things, to know if I buy or not, say SELL + your item name or SELL ALL LOOT.", "Eu compro várias coisas, para saber o que eu compro diga SELL + nome do item ou SELL ALL LOOT."}
npcLootSpecialOfferMensage = {"I'm buying a lot of things, to know if I buy or not, say SELL + your item name or SELL ALL LOOT.", "Eu compro várias coisas, para saber o que eu compro diga SELL + nome do item ou SELL ALL LOOT."}
npcLootSuportMensage = {"I'm selling rope, shovel, pick, backpack, fishing rod, bag and water pouch. You want to buy anything?", "Eu vendo rope, shovel, pick, backpack, fishing rod, bag e water pouch. Você deseja comprar algo?"}
npcLootSimpleDistanceMensage = {"I'm selling bow, crossbow, arrow, sniper arrow, poison arrow, burst arrow, onyx arrow, bolt, power bolt, piercing bolt, spear, royal spear, enchanted spear, throwing star, viper star and throwing knife.", "Eu vendo bow, crossbow, arrow, sniper arrow, poison arrow, burst arrow, onyx arrow, bolt, power bolt, piercing bolt spear, royal spear, enchanted spear, throwing star, viper star e throwing knife."}
npcPostMan = {"I'm selling letter, parcel and label, you want to buy?", "Eu vendo letter, parcel e label, deseja comprar algo?"}
npcMeetFood = {"I'm selling fish, ham and meat.", "Eu vendo fish, ham e meat, deseja comprar algo?"}
npcLootMagicMensage = {"I sell a 3 types of mana potion: normal mana potion, strong mana potion and great mana potion.", "Eu vendo 3 tipos de mana potion: normal mana potion, strong mana potion e great mana potion."}
npcLootHealthMensage = {"I have full potions: health potion (150 HP), strong health potion (300 HP), great health potion (450 HP) and ultimate health potion (600 HP).", "Eu tenho potions cheios: health potion (50 HP), strong health potion (300 HP), great health potion (450 HP) and ultimate health potion (600 HP)."}
npcDrinkStore = {"I have a looot beer.", "Eu tenho muita beer, alias, isso é o que não falta."}

function getAdvancedList(inNpcs, npcBuys, npcSells)
  local string = "- Advanced List -\n\n"
  if npcSells == true then
    for x = 1, #itemInfosBuy do
        if itemInfosBuy[x].inNpcs == inNpcs then
          string = string.."["..itemInfosBuy[x].name.." - "..itemInfosBuy[x].price.." gold coins]\n"
        end
    end
  else
    for x = 1, #itemInfosSell do
        if itemInfosSell[x].inNpcs == inNpcs then
          string = string.."["..itemInfosSell[x].name.." - "..itemInfosSell[x].price.." gold coins]\n"
        end
    end
  end
  return string
end  


function getPriceOfMana(cid, number, fail)
    local number = number or 0
    local playerMana = getCreatureMaxMana(cid)+number

    if fail then
      playerMana = 100+fail
    end

    if playerMana >= 0 and playerMana <= 149 then
        return 1

    elseif playerMana >= 150 and playerMana <= 199 then
        return 2

    elseif playerMana >= 200 and playerMana <= 249 then
        return 3

    elseif playerMana >= 250 and playerMana <= 299 then
        return 4

    elseif playerMana >= 300 then
        return 5
    end
end

function getPriceOfHealth(cid, number, fail)
    local number = number or 0
    local playerHealth = getPointsUsedInSkill(cid, "health")+number

    if fail then
      playerHealth = fail
    end

    if playerHealth >= 0 and playerHealth <= 299 then
        return 1

    elseif playerHealth >= 300 and playerHealth <= 499 then
        return 2

    elseif playerHealth >= 500 and playerHealth <= 799 then
        return 3

    elseif playerHealth >= 800 and playerHealth <= 999 then
        return 4

    elseif playerHealth >= 1000 and playerHealth <= 1699 then
        return 5

    elseif playerHealth >= 1700 then
        return 8
    end
end

function getPriceOfDodge(cid, number, fail)
    local number = number or 0
    local dodge = getPointsUsedInSkill(cid, "dodge")+number

    if fail then
      dodge = fail
    end

    if dodge >= 0 and dodge <= 5 then
        return 1
    elseif dodge >= 6 and dodge <= 8 then
        return 2
    elseif dodge >= 9 and dodge <= 10 then
        return 3
    elseif dodge == 11 then
        return 5
    elseif dodge == 12 then
        return 7
    elseif dodge == 13 then
        return 9
    elseif dodge == 14 then
        return 18
    elseif dodge >= 15 then
        return 29
    end
end

function getPriceOfBendLevel(cid, number, fail)
  local number = number or 0
    local bendLevel = getPointsUsedInSkill(cid, "bend")+number

    if fail then
      bendLevel = fail
    end

    if bendLevel >= 0 and bendLevel <= 19 then
        return 1

    elseif bendLevel >= 20 and bendLevel <= 29 then
        return 2

    elseif bendLevel >= 30 and bendLevel <= 49 then
        return 4

    elseif bendLevel >= 50 and bendLevel <= 59 then
        return 7

    elseif bendLevel >= 60 and bendLevel <= 69 then
        return 10

    elseif bendLevel >= 70 then
        return 15
    end
end

function getPriceOffNumber(cid, point, number, fail)
    local funcCheck, numberPlus = nil, 0
    if point == "health" then
        funcCheck = getPriceOfHealth
        numberPlus = 20
    elseif point == "mana" then
        funcCheck = getPriceOfMana
        numberPlus = 5
    elseif point == "bend" then
        funcCheck = getPriceOfBendLevel
        numberPlus = 1
    elseif point == "dodge" then
        funcCheck = getPriceOfDodge
        numberPlus = 1
    end

    local numberAggred = 0
    for x = 1, number do
      if fail then
          numberAggred = numberAggred+funcCheck(cid, numberPlus*x, numberPlus*x)
        else
          numberAggred = numberAggred+funcCheck(cid, numberPlus*x)
      end
    end
    return numberAggred
end

function getPointsWasted(cid, skill)
  local numberExact = 0

  if skill == "health" then
    numberExact = getPointsUsedInSkill(cid, "health")/20
  elseif skill == "mana" then
    numberExact = getPointsUsedInSkill(cid, "mana")/5
  elseif skill == "bend" then
    numberExact = getPointsUsedInSkill(cid, "bend")/1
  elseif skill == "dodge" then
    numberExact = getPointsUsedInSkill(cid, "dodge")/1
  end

  return getPriceOffNumber(cid, skill, math.ceil(numberExact), true)
end
