--[[
    Pré-Requisitos
     1. Ser premium account;
     2. Ter a montaria adquirida;
     3. Não estar voando;
     4. Não estar nadando;

    Fluxo Normal
     1. Servidor recebe a mensagem (talkaction !mount ID..Sexo (servidor que coloca o sexo;))
     2. Checagem se o player já está utilizando uma montaria;
     3. Adiciona storage value ("inMount", 1);
     4. Adiciona mount pelo comandinho de outfit (msm do fly e nadar.).

    Fluxo Alternativo
     2.1 Player recebe mensagem de erro (You already using mount., "Voocê já está utilizando uma montaria.");
     2.2 Fim.

    dataTable
     *Primeiro elemento: NOMESTORAGE+AtualOutfitID
     *sexFem, sexMasc;
]]--

moreSpeed = 40


local totalMounts = {
    "crystalwolf",
    "mantaray",
    "coralripper",
    "titanica",
    "wacoon",
    "ironblight",
    "kinglydeer",
    "noblelion",
    "nethersteed",
    "draptor",
    "magmacrawler",
    "firepanther",
    "kongra",
    "stampor",
    "carpacosaurus",
    "shockhead"
}

local mountsByVocAndId = {
[1] = {"nethersteed", "draptor", "magmacrawler", "firepanther", "horse", "blackpelt", "blazebringer", "doombringer"},
[2] = {"crystalwolf", "mantaray", "coralripper", "titanica", "ursagrodon", "jadepincer", "flitterkatzen", "jadelion"},
[3] = {"wacoon", "ironblight", "kinglydeer", "noblelion", "panda", "highlandyak", "slagsnare", "racingbird"},
[4] = {"kongra", "stampor", "carpacosaurus", "shockhead", "scorpionking", "tigerslug", "widowqueen", "dromedary"}
}

dataMounts = {
    ["crystalwolf368"] = 507,  -- water male
    ["mantaray368"] = 620,  -- water male
    ["coralripper368"] = 621,  -- water male
    ["titanica368"] = 619,  -- water male
	["ursagrodon368"] = 632,  -- water male
    ["jadepincer368"] = 631,  -- water male
    ["flitterkatzen368"] = 629,  -- water male
    ["jadelion368"] = 630,  -- water male
	["blacksheep368"] = 664,  -- water male
    ["warbear368"] = 663,  -- water male
    ["hellgrip368"] = 666,  -- water male
    ["uniwheel368"] = 662,  -- water male
    ["ladybug368"] = 665,  -- water male

    ["crystalwolf387"] = 509, -- water female
    ["mantaray387"] = 624, -- water female
    ["coralripper387"] = 623, -- water female
    ["titanica387"] = 622, -- water female
	["ursagrodon387"] = 628,  -- water female
    ["jadepincer387"] = 627,  -- water female
    ["flitterkatzen387"] = 625,  -- water female
    ["jadelion387"] = 626,  -- water female
	["blacksheep387"] = 658,  -- water female
    ["warbear387"] = 660,  -- water female
    ["hellgrip387"] = 661,  -- water female
    ["uniwheel387"] = 657,  -- water female
    ["ladybug387"] = 659,  -- water female
	
    ["wacoon457"] = 495,  -- air male
    ["ironblight457"] = 606,  -- air male
    ["kinglydeer457"] = 605,  -- air male
    ["noblelion457"] = 604,  -- air male
	["panda457"] = 649,  -- air male
    ["highlandyak457"] = 651,  -- air male
    ["slagsnare457"] = 650,  -- air male
    ["racingbird457"] = 652,  -- air male
    ["blacksheep457"] = 684,  -- air male
    ["warbear457"] = 683,  -- air male
    ["hellgrip457"] = 686,  -- air male
    ["ladybug457"] = 685,  -- air male
    ["uniwheel457"] = 682,  -- air male

    ["wacoon456"] = 496, -- air female  
    ["ironblight456"] = 602, -- air female  
    ["kinglydeer456"] = 603, -- air female  
    ["noblelion456"] = 601, -- air female  
	["panda456"] = 653,  -- air female
    ["highlandyak456"] = 655,  -- air female
    ["slagsnare456"] = 654,  -- air female
    ["racingbird456"] = 656,  -- air female
    ["blacksheep456"] = 679,  -- air female
    ["warbear456"] = 678,  -- air female
    ["hellgrip456"] = 681,  -- air female
    ["ladybug456"] = 680,  -- air female
    ["uniwheel456"] = 677,  -- air female

    ["nethersteed388"] = 518,  -- fire male 
    ["draptor388"] = 617,  -- fire male
    ["magmacrawler388"] = 618,  -- fire male
    ["firepanther388"] = 616,  -- fire male
    ["horse388"] = 633,  -- fire male 
    ["blazebringer388"] = 634,  -- fire male
    ["doombringer388"] = 635,  -- fire male
    ["blackpelt388"] = 636,  -- fire male
    ["blacksheep388"] = 689,  -- fire male 
    ["warbear388"] = 688,  -- fire male
    ["ladybug388"] = 690,  -- fire male
    ["hellgrip388"] = 691,  -- fire male
    ["uniwheel388"] = 687,  -- fire male

    ["nethersteed383"] = 519,  -- fire female 
    ["draptor383"] = 613,  -- fire female 
    ["magmacrawler383"] = 615,  -- fire female 
    ["firepanther383"] = 614,  -- fire female 
	["horse383"] = 637,  -- fire female 
    ["blazebringer383"] = 638,  -- fire female
    ["doombringer383"] = 639,  -- fire female
    ["blackpelt383"] = 640,  -- fire female
    ["blacksheep383"] = 694,  -- fire female 
    ["warbear383"] = 693,  -- fire female
    ["ladybug383"] = 695,  -- fire female
    ["hellgrip383"] = 696,  -- fire female
    ["uniwheel383"] = 692,  -- fire female

    ["kongra371"] = 523, -- earth male 
    ["stampor371"] = 612, -- earth male 
    ["carpacosaurus371"] = 610, -- earth male 
    ["shockhead371"] = 611, -- earth male 
    ["scorpionking371"] = 644, -- earth male 
    ["tigerslug371"] = 642, -- earth male 
    ["widowqueen371"] = 641, -- earth male 
    ["dromedary371"] = 643, -- earth male 
    ["blacksheep371"] = 674, -- earth male 
    ["warbear371"] = 672, -- earth male 
    ["ladybug371"] = 675, -- earth male 
    ["hellgrip371"] = 676, -- earth male 
    ["uniwheel371"] = 673, -- earth male 

    ["kongra384"] = 524, -- earth female
    ["stampor384"] = 609, -- earth female
    ["carpacosaurus384"] = 607, -- earth female
    ["shockhead384"] = 608, -- earth female
	["scorpionking384"] = 648, -- earth female 
    ["tigerslug384"] = 646, -- earth female 
    ["widowqueen384"] = 645, -- earth female 
    ["dromedary384"] = 647, -- earth female 
    ["blacksheep384"] = 669, -- earth female 
    ["warbear384"] = 668, -- earth female 
    ["ladybug384"] = 670, -- earth female 
    ["hellgrip384"] = 671, -- earth female 
    ["uniwheel384"] = 667 -- earth female 
}