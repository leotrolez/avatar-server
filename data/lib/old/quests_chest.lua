-- [actionid] = {level = level pra poder usar o bau, premios = {{id, quantia}, {id, quantia}}, exp = exp a receber}

-- exemplo de bau que so da 1 item e exp: 
-- [3198] = {level = 20, premios = {{3891, 2}}, exp = 2500, effect = 32}
-- nesse caso o bau com actionid 3198 so vai poder ser usado por player level 20+ e vai dar como premio 2(quantia) itens de id 3891 e tb 2500 de exp. vai lançar tb o efeito 32 na pos do player q abrir
-- se quiser colocar sem exp poe exp = 0

-- exemplo de bau que da mais de 1 item:
-- [3123] = {level = 40, premios = {{3891, 1}, {4921, 4}, {2918, 6}}, exp = 4500, effect = 0}
-- nesse caso o bau com actionid 3123 vai poder ser usado por players lv 40+ e vai dar 1 item id 3891, 4 itens id 4921, 6 itens id 2918, e exp 4500. não vai lançar efeito na pos do player q abrir


-- STORAGE É PARA IMPEDIR QUE POSSAM ABRIR O MESMO BAÚ 2X! CASO QUEIRA CRIAR 2 BAÚS DIFERENTES NO QUAL SÓ PODE ABRIR 1, UTILIZE O MESMO STORAGE ENTRE AMBOS.
-- SE VOCE DEIXAR STORAGE = 0 O SISTEMA VAI USAR COMO STORAGE "questChests" + numero do actionID, 
-- no caso não tem problema deixar 0, só será util pra caso queria um storage especifico ou deixar 2 baus de 2 actionID diferente compartilhando storage pra n poder abrir ambos

-- GIVESTORAGE PODE DEIXAR EM 0 DÁ NADA NÃO. É PARA COLOCAR O STORAGE ESCOLHIDO EM 1 AO ABRIR CASO TENHA ALGUM ESPECIFICADO, 
-- EU POSSO USAR ISSO PARA ALGUM SISTEMA CASO PRECISE, COMO UM CHEST QUE TE DÊ BLESS(que é storage no avatar), SEI LÁ.

-- CUSTOMTEXT É PRA CASO QUEIRA POR UMA FRASE CUSTOM PRA QUANDO ABRIR O BAÚ 
-- SE NÃO TIVER FRASE, FOR "" ENTÃO ELE MOSTRA MENSAGEM COM OS ITENS ADQUIRIDOS

Game.ChestsInfo =
{
[25455] = {level = 5, premios = {{2152, 5}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- rotworm (500 gps)
[25456] = {level = 15, premios = {{2152, 30}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- cyclops (3k)
[25473] = {level = 20, premios = {{2152, 15}, {7425, 1}, {2486, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- elf (1.5k, noble armor e taurus mace)
[25477] = {level = 20, premios = {{2152, 20}, {7415, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- zuko disciples (cranial basher e 2k)
[25478] = {level = 20, premios = {{2152, 25}, {2488, 1}, {2487, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- water elemental (crown armor, crown legs, 2.5k)
[25479] = {level = 25, premios = {{2152, 30}, {2519, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- dwarfs quest (3k e crown shield)
[25468] = {level = 25, premios = {{2152, 35}, {2435, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- dwarf (dwarven axe e 3.5k)
[25475] = {level = 25, premios = {{2152, 30}, {7380, 1}, {7408, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- ghoul e crypt shambler (wyvern fang, 3k e headchopper)
[25476] = {level = 30, premios = {{2152, 40}, {7385, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- ghoul e demon skeleton (4k e crimson sword)
[25458] = {level = 35, premios = {{2152, 40}, {2476, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- black knight (knight armor e 4k)
[25470] = {level = 35, premios = {{2152, 50}, {7390, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- orcs (5k e justice seeker)
[25471] = {level = 35, premios = {{2152, 40}, {2451, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- black knight (4k e djin blade)
[25462] = {level = 40, premios = {{2152, 40}, {7388, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- banshee (vile axe e 4k)

[25487] = {level = 40, premios = {{7386, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- swt (mercenary sword)

[25480] = {level = 40, premios = {{2152, 40}, {2534, 1}, {12789, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- abadeer (vampire shield, vampire helmet e 4k)
[25463] = {level = 40, premios = {{2152, 40}, {7730, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- vampire (blue legs e 4k)
[25494] = {level = 40, premios = {{2152, 40}, {2477, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- giant spider (blue legs e 5k)
[25457] = {level = 45, premios = {{2152, 60}, {2536, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- hydra (medusa shield e 6k)
[25472] = {level = 45, premios = {{2152, 50}, {7384, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- quara (5k e mystic blade)
[25469] = {level = 50, premios = {{2160, 1}, {7896, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- sea serpent / frost dragon (10k e glacier kilt)
[25482] = {level = 50, premios = {{13638, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- giants (dominant legs)
[25474] = {level = 50, premios = {{2152, 60}, {2466, 1}, {7392, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- behemoth (orcish maul, 6k e golden armor)
[25481] = {level = 50, premios = {{13640, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- werewolf (dominant shield)
[25483] = {level = 50, premios = {{13637, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- son of verminor (dominant chest)
[25459] = {level = 50, premios = {{4856, 1}}, exp = 0, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- minotaur/mina (pick)
[25461] = {level = 55, premios = {{11243, 1}, {2160, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- magma crawler (magma bp e 10k)
[25460] = {level = 60, premios = {{2160, 2}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- gusslemaw (20k)

[25489] = {level = 60, premios = {{8924, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- swt (hellforged axe)

[25490] = {level = 65, premios = {{2160, 4}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- swt (40k)

[25496] = {level = 65, premios = {{2160, 2}, {2195, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- quara

[25484] = {level = 65, premios = {{15014, 60}, {2160, 2}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- swt (60 uhp, 20k)

[25491] = {level = 70, premios = {{2160, 2}, {13893, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- drakens
[25485] = {level = 70, premios = {{13630, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- swt (frozen helmet)
[25486] = {level = 70, premios = {{13633, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- swt (frozen boots)

[25488] = {level = 70, premios = {{13632, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- swt (frozen legs)

[25497] = {level = 70, premios = {{2160, 3}, {2342, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- kashek

[25495] = {level = 80, premios = {{2160, 6}, {2498, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- dragon lord

[25498] = {level = 80, premios = {{2160, 3}, {7902, 1}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- giants2

[25493] = {level = 90, premios = {{2506, 1}, {2492, 1}, {2160, 8}}, exp = 15, effect = 29, storage = 0, givestorage = 0, customText = ""}, -- bonelord

[25492] = {level = 120, premios = {{2160, 30}}, exp = 40, effect = 29, storage = 0, givestorage = 0, customText = ""} -- inq
}