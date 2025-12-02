const = {
    positionsToEnter = {
        {x=509,y=327,z=9, stackpos=253},
        {x=510,y=327,z=9, stackpos=253},
        {x=511,y=327,z=9, stackpos=253},
        {x=512,y=327,z=9, stackpos=253}
    },

    positionEnterInicial = {x=505,y=325,z=9}, --+x 4x
    clock = {x=509,y=325,z=9, time=600},
    clock2 = {x=511,y=308,z=9},
    
    monster = {
        bornPosition = {x=510,y=313,z=10},
        lifePerWave = 200,
        name = "Demoniac Destroyer"
    },

    uniqueIdEnter = 5552,
    uniqueIdMonster = 5551,

    cantUseSpells = {
        "earth track", "air boost", "water surf"
    },

    msgErrors = {
        errorEnter = {"Your team need have 4 players with level %s or more with %s gold coins each..", "O seu time precisa ter 4 players com level %s ou maior e %s gold coins cada."},
        needPutItem = {"You need put %s mutated flesh on right to start another wave.", "Você precisa por %s mutated flesh ao lado para iniciar outra wave."},
        miniGameStarted = {"This arena are in use, please try again later.", "A arena está em uso agora, por favor tente novamente mais tarde."},
        levelSomado = {"Sorry, the max team level allowed is 300.", "Desculpe, level máximo por time é 300."}
    },

    minLevel = 45,
    maxLevelTeam = 300,
    pricePerLevel = 15, --levelTotal*isso (entrada)
    rewardPerLevel = 3, --levelTotal*isso*waves (saida)

    itemToMonsterBorn = {
        id = 11225,
        position = {x=511,y=309,z=9}
    },

    topLeftPosition = {x=502,y=303,z=9},
    underRightPosition = {x=521,y=325,z=9},

    msgsStartEnd = {
        msgStart = {"Arena of Death: Kill the max of waves you can! (%s gold coins per wave)", "Arena of Death: Mate o máximo de waves que você conseguir! (%s gold coins por wave)"},
        msgEndWin = {"Congratulations, you and your team wons %s gold coins in %s wave(s) defeated!", "Parábens, você e seu time ganharam %s gold coins em %s wave(s) derrotadas."},
        msgEndLost = {"You and your team lost! (%s waves defeated(s))", "Você e seu time perderam! (%s waves derrotada(s))"}
    }
}