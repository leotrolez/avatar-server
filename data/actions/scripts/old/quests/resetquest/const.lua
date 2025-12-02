timeToQuestClose = 30 --inMinutes


firstMonsters = {
    {x=582,y=515,z=10, name = "Dragon Lord"},
    {x=583,y=501,z=10, name = "Dragon Lord"},
    {x=600,y=501,z=10, name = "Dragon Lord"}
}

guards = { --Sala que precisa mata os monstros, colocar o life crystal (será executada pelo script guards.lua (unique: ))
    --[[arquivo guardRoom.lua]]--
    lifeCrystalID = 9662,
    raiosID = 5070,
    gateIDs = {9485, 9533},
    magicEffect = 11,

    gatePositions = {
        {x=516,y=570,z=10}, {x=516,y=563,z=10}, {x=516,y=555,z=10},
        {x=516,y=548,z=10}, {x=516,y=542,z=10}, {x=513,y=540,z=10}, 
        {x=501,y=540,z=10}, {x=487,y=540,z=10}, {x=477,y=540,z=10},
        {x=468,y=540,z=10}, {x=466,y=542,z=10}, {x=466,y=549,z=10}, 
        {x=466,y=558,z=10}, {x=466,y=566,z=10}
    },

    guardPositions = {
        {x=465,y=546,z=10, name='Blue Guard'}, {x=465,y=553,z=10, name='Green Guard'}, {x=465,y=556,z=10, name='Blue Guard'}, 
        {x=465,y=560,z=10, name='Green Guard'}, {x=465,y=563,z=10, name='Green Guard'}, {x=466,y=540,z=10, name='Green Guard'}, 
        {x=466,y=545,z=10, name='Green Guard'}, {x=466,y=551,z=10, name='Green Guard'}, {x=466,y=560,z=10, name='Green Guard'}, 
        {x=466,y=565,z=10, name='Blue Guard'}, {x=467,y=538,z=10, name='Blue Guard'}, {x=467,y=548,z=10, name='Green Guard'}, 
        {x=467,y=556,z=10, name='Green Guard'}, {x=467,y=563,z=10, name='Green Guard'}, {x=470,y=538,z=10, name='Green Guard'}, 
        {x=470,y=541,z=10, name='Green Guard'}, {x=473,y=541,z=10, name='Green Guard'}, {x=475,y=538,z=10, name='Green Guard'}, 
        {x=475,y=540,z=10, name='Blue Guard'}, {x=478,y=541,z=10, name='Green Guard'}, {x=480,y=538,z=10, name='Green Guard'}, 
        {x=481,y=540,z=10, name='Blue Guard'}, {x=482,y=539,z=10, name='Green Guard'}, {x=482,y=541,z=10, name='Green Guard'}, 
        {x=484,y=540,z=10, name='Green Guard'}, {x=490,y=539,z=10, name='Green Guard'}, {x=491,y=541,z=10, name='Green Guard'}, 
        {x=492,y=540,z=10, name='Green Guard'}, {x=494,y=539,z=10, name='Blue Guard'}, {x=495,y=541,z=10, name='Green Guard'}, 
        {x=497,y=538,z=10, name='Green Guard'}, {x=503,y=539,z=10, name='Green Guard'}, {x=504,y=541,z=10, name='Green Guard'},
        {x=505,y=539,z=10, name='Green Guard'}, {x=506,y=538,z=10, name='Green Guard'}, {x=507,y=540,z=10, name='Green Guard'}, 
        {x=509,y=540,z=10, name='Blue Guard'}, {x=514,y=546,z=10, name='Green Guard'}, {x=514,y=560,z=10, name='Green Guard'}, 
        {x=515,y=541,z=10, name='Blue Guard'}, {x=515,y=552,z=10, name='Green Guard'}, {x=515,y=568,z=10, name='Green Guard'}, 
        {x=516,y=539,z=10, name='Green Guard'}, {x=516,y=544,z=10, name='Green Guard'}, {x=516,y=545,z=10, name='Blue Guard'}, 
        {x=516,y=547,z=10, name='Green Guard'}, {x=516,y=550,z=10, name='Green Guard'}, {x=516,y=553,z=10, name='Blue Guard'}, 
        {x=516,y=559,z=10, name='Blue Guard'}, {x=516,y=566,z=10, name='Green Guard'}, {x=517,y=551,z=10, name='Green Guard'}, 
        {x=517,y=557,z=10, name='Green Guard'}, {x=517,y=560,z=10, name='Green Guard'}, {x=517,y=568,z=10, name='Blue Guard'} 
    },

    initialActionID = 3470
}

leverDL = {
    --[[arquivo leverDL.lua]]--
    poses = {
        [3485] = {x=572,y=523,z=9},
        [3486] = {x=573,y=523,z=9}
    },

    stoneID = 1304
}

warHorn = {
    --[[logica no item 4, arquivo warHorn.lua]]--
    positionToSong = {x=557,y=511,z=10},
    bossName = "warholder",
    bossBorn = {x=557,y=516,z=10},
    effect = 10,
}

bosses = {
    --[[arquivo bossRoom.lua]]--
    posesPotions = {
        [3495] = {x=0,y=2,z=10, monsterName = "Hydramat", item=5909, eff=2}, --normal
        [3496] = {x=0,y=2,z=10, monsterName = "Dragon Lord", item=11246, eff=2}, --normal
        [3497] = {x=0,y=2,z=10, monsterName = "Zero", item=10555, eff=86}, --contrario
        [3498] = {x=0,y=2,z=10, monsterName = "Arachinid", item=5912, eff=86}, --contrario
        [3499] = {x=0,y=-2,z=10, monsterName = "Hydramat", item=5911, eff=CONST_ME_FIREAREA}, --normal
        [3500] = {x=0,y=-2,z=10, monsterName = "Dragon Lord", item=10553, eff=CONST_ME_FIREAREA}, --normal
        [3501] = {x=0,y=-2,z=10, monsterName = "Zero", item=12413, eff=34}, --contrario
        [3502] = {x=0,y=-2,z=10, monsterName = "Arachinid", item=5910, eff=34} --contrario
    },


    altarPositions = {
        {x=483,y=555,z=10, actionid=3502}, {x=483,y=559,z=10, actionid=3495}, 
        {x=487,y=554,z=10, actionid=3501}, {x=487,y=560,z=10, actionid=3496}, 
        {x=492,y=554,z=10, actionid=3500}, {x=492,y=560,z=10, actionid=3497}, 
        {x=496,y=555,z=10, actionid=3499}, {x=496,y=559,z=10, actionid=3498}
    },

    gatePos = {x=498,y=557,z=10},
    gateID = 1546,
}

elementalRoom = {
    [3504] = {element = "water", position = {x=121,y=145,z=14}},
    [3505] = {element = "air", position = {x=125,y=145,z=14}},
    [3506] = {element = "fire", position = {x=129,y=145,z=14}},
    [3507] = {element = "earth", position = {x=133,y=145,z=14}},
    positionBorn = {x=505,y=342,z=7},

    --Posições referentes a sala do raio--
    topLeftPos = {x=120,y=145,z=14},
    underRightPos = {x=134,y=150,z=14},
    delayToGo = 900, --InMS
}

warlockRoom = {
    uniqueIdDoor = 4598,
    newDoorId = 6254
}

bossFinal = {
    name = "Elemental",
    statueActionId = 3510,
    rewardItemId = 12325
}

limboPosition = {x=505,y=342,z=7}
posExitFinal = {x=505,y=342,z=7}

cantUseSpells = {
    "earth track", "air boost", "water surf", "fire field", "fire impulse"
}

function clearAllItems(cid)
    local listItemsCheck = {}

    for _, v in pairs(bosses.posesPotions) do
        table.insert(listItemsCheck, v.item)
    end

    table.insert(listItemsCheck, guards.lifeCrystalID)
    table.insert(listItemsCheck, 5468) --firebug
    table.insert(listItemsCheck, 11197) --giant Eye

    for y = 1, #listItemsCheck do
        local count = getPlayerItemCount(cid, listItemsCheck[y])

        if count > 0 then
            doPlayerRemoveItem(cid, listItemsCheck[y], count)
        end
    end
end



--[[
    1 *parte de cortar o chão está em (actions/scripts/mining/default.lua), chão actionid 3488
    2 *parte de colocar stone está no evento onMoveItem (actionids: 3489, 3490, 3491, 3492)
    3 *parte de pisar nos pisos falsos e aparecer monstro, feita (movements/scripts/resetQuest.lua), chão actionid 3493
    4 *parte de colocar o item na sala warHorn (11197), feita no evento onMoveItem(actionid: 3494)
    5 *parte de colocar o book na sala das bruxas (11134), feita no evento onMoveItem(actionid: 3508)
    6 *parte de quebrar estante na actionid (3509)
    7 *parte de liberar boss final na actionid (3510), com o fire bug.
    8 *parte de abrir bau actionid (3511). Parte de liberar bau está na func onKill, (tasks), creaturescript.
    9 *parte de trancar bau novamente está no onServerStart

    Pós-Condições:
    1* Limpar os items do player, de acordo com a tabela (bosses.posesPotion[x].item), guards.lifeCrystalID, 
]]--