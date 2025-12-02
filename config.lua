-- Combat settings
-- NOTE: valid values for worldType are: "pvp", "no-pvp" and "pvp-enforced"
worldType = "pvp"
hotkeyAimbotEnabled = true
protectionLevel = 1
killsToRedSkull = 3
killsToBlackSkull = 6
pzLocked = 60000
removeChargesFromRunes = true
removeChargesFromPotions = true
removeWeaponAmmunition = true
removeWeaponCharges = true
timeToDecreaseFrags = 24 * 60 * 60
whiteSkullTime = 15 * 60
stairJumpExhaustion = 2000
experienceByKillingPlayers = false
expFromPlayersLevelRange = 75
pzLockSkullAttacker = false

-- Connection Config
-- NOTE: maxPlayers set to 0 means no limit
-- NOTE: allowWalkthrough is only applicable to players
ip = "127.0.0.1"
bindOnlyGlobalAddress = false
loginProtocolPort = 7171
gameProtocolPort = 7172
statusProtocolPort = 7171
maxPlayers = 0
motd = "Welcome to The Forgotten Server!"
onePlayerOnlinePerAccount = true
allowClones = false
allowWalkthrough = true
serverName = "Forgotten"
statusTimeout = 5000
replaceKickOnLogin = true
maxPacketsPerSecond = 50

-- Deaths
-- NOTE: Leave deathLosePercent as -1 if you want to use the default
-- death penalty formula. For the old formula, set it to 10. For
-- no skill/experience loss, set it to 0.
deathLosePercent = -1

-- Houses
-- NOTE: set housePriceEachSQM to -1 to disable the ingame buy house functionality
-- NOTE: valid values for houseRentPeriod are: "daily", "weekly", "monthly", "yearly"
-- use any other value to disable the rent system
housePriceEachSQM = 1000
houseRentPeriod = "never"
houseOwnedByAccount = false
houseDoorShowPrice = true
onlyInvitedCanMoveHouseItems = true

-- Item Usage
timeBetweenActions = 200
timeBetweenExActions = 1000

-- Map
-- NOTE: set mapName WITHOUT .otbm at the end
mapName = "forgotten"
mapAuthor = "Komic"

-- Market
marketOfferDuration = 30 * 24 * 60 * 60
premiumToCreateMarketOffer = true
checkExpiredMarketOffersEachMinutes = 60
maxMarketOffersAtATimePerPlayer = 100

-- MySQL
mysqlHost = "127.0.0.1"
mysqlUser = "root"
mysqlPass = "root"
mysqlDatabase = "fodase"
mysqlPort = 3306
mysqlSock = ""

-- Misc.
-- NOTE: classicAttackSpeed set to true makes players constantly attack at regular
-- intervals regardless of other actions such as item (potion) use. This setting
-- may cause high CPU usage with many players and potentially affect performance!
-- NOTE: forceMonsterTypesOnLoad loads all monster types on startup to validate them.
-- You can disable it to save some memory if you don't see any errors at startup.
allowChangeOutfit = true
freePremium = false
kickIdlePlayerAfterMinutes = 15
maxMessageBuffer = 4
emoteSpells = true
classicEquipmentSlots = false
classicAttackSpeed = false
showScriptsLogInConsole = false
showOnlineStatusInCharlist = false
yellMinimumLevel = 2
yellAlwaysAllowPremium = false
minimumLevelToSendPrivate = 1
premiumToSendPrivate = false
forceMonsterTypesOnLoad = true
cleanProtectionZones = false
luaItemDesc = false
showPlayerLogInConsole = true

-- VIP and Depot limits
-- NOTE: you can set custom limits per group in data/XML/groups.xml
vipFreeLimit = 20
vipPremiumLimit = 100
depotFreeLimit = 2000
depotPremiumLimit = 10000

-- World Light
-- NOTE: if defaultWorldLight is set to true the world light algorithm will
-- be handled in the sources. set it to false to avoid conflicts if you wish
-- to make use of the function setWorldLight(level, color)
defaultWorldLight = true

-- Server Save
-- NOTE: serverSaveNotifyDuration in minutes
serverSaveNotifyMessage = true
serverSaveNotifyDuration = 5
serverSaveCleanMap = false
serverSaveClose = false
serverSaveShutdown = true

-- Experience stages
-- NOTE: to use a flat experience multiplier, set experienceStages to nil
-- minlevel and multiplier are MANDATORY
-- maxlevel is OPTIONAL, but is considered infinite by default
-- to disable stages, create a stage with minlevel 1 and no maxlevel
experienceStages = {
	{ minlevel=1, maxlevel=28, multiplier=0.5 },
	{ minlevel=29, maxlevel=35, multiplier=0.49 },
	{ minlevel=36, maxlevel=40, multiplier=0.48 },
	{ minlevel=41, maxlevel=45, multiplier=0.47 },
	{ minlevel=46, maxlevel=50, multiplier=0.46 },
	{ minlevel=51, maxlevel=55, multiplier=0.45 },
	{ minlevel=56, maxlevel=60, multiplier=0.44 },
	{ minlevel=61, maxlevel=65, multiplier=0.43 },
	{ minlevel=66, maxlevel=70, multiplier=0.42 },
	{ minlevel=71, maxlevel=75, multiplier=0.41 },
	{ minlevel=76, maxlevel=80, multiplier=0.35 },
	{ minlevel=81, maxlevel=85, multiplier=0.33 },
	{ minlevel=86, maxlevel=90, multiplier=0.3 },
	{ minlevel=91, maxlevel=95, multiplier=0.27 },
	{ minlevel=96, maxlevel=100, multiplier=0.19 },
	{ minlevel=101, maxlevel=105, multiplier=0.15 },
	{ minlevel=106, maxlevel=110, multiplier=0.14 },
	{ minlevel=111, maxlevel=115, multiplier=0.13 },
	{ minlevel=116, maxlevel=120, multiplier=0.12 },
	{ minlevel=121, maxlevel=125, multiplier=0.11 },
	{ minlevel=126, maxlevel=130, multiplier=0.1 },
	{ minlevel=131, maxlevel=135, multiplier=0.07 },
	{ minlevel=136, maxlevel=140, multiplier=0.06 },
	{ minlevel=141, maxlevel=145, multiplier=0.05 },
	{ minlevel=146, maxlevel=150, multiplier=0.04 },
	{ minlevel=151, maxlevel=155, multiplier=0.037 },
	{ minlevel=156, maxlevel=160, multiplier=0.036 },
	{ minlevel=161, maxlevel=165, multiplier=0.035 },
	{ minlevel=166, maxlevel=170, multiplier=0.034 },
	{ minlevel=171, maxlevel=175, multiplier=0.033 },
	{ minlevel=176, maxlevel=180, multiplier=0.032 },
	{ minlevel=181, maxlevel=185, multiplier=0.031 },
	{ minlevel=186, maxlevel=190, multiplier=0.03 },
	{ minlevel=191, maxlevel=195, multiplier=0.029 },
	{ minlevel=196, maxlevel=200, multiplier=0.028 },
	{ minlevel=201, maxlevel=205, multiplier=0.02 },
	{ minlevel=206, maxlevel=210, multiplier=0.019 },
	{ minlevel=211, maxlevel=215, multiplier=0.018 },
	{ minlevel=216, maxlevel=220, multiplier=0.017 },
	{ minlevel=221, maxlevel=225, multiplier=0.016 },
	{ minlevel=226, maxlevel=230, multiplier=0.015 },
	{ minlevel=231, maxlevel=235, multiplier=0.014 },
	{ minlevel=236, maxlevel=240, multiplier=0.013 },
	{ minlevel=241, maxlevel=245, multiplier=0.012 },
	{ minlevel=246, maxlevel=250, multiplier=0.011 },
	{ minlevel=251, maxlevel=255, multiplier=0.01 },
	{ minlevel=256, maxlevel=260, multiplier=0.0095 },
	{ minlevel=261, maxlevel=265, multiplier=0.0094 },
	{ minlevel=266, maxlevel=270, multiplier=0.0093 },
	{ minlevel=271, maxlevel=275, multiplier=0.0092 },
	{ minlevel=276, maxlevel=280, multiplier=0.0081 },
	{ minlevel=281, maxlevel=285, multiplier=0.007 },
	{ minlevel=286, maxlevel=290, multiplier=0.0065 },
	{ minlevel=291, maxlevel=295, multiplier=0.0054 },
	{ minlevel=296, maxlevel=300, multiplier=0.0043 },
	{ minlevel=301, maxlevel=305, multiplier=0.0032 },
	{ minlevel=306, maxlevel=310, multiplier=0.0031 },
	{ minlevel=311, maxlevel=315, multiplier=0.0025 },
	{ minlevel=316, maxlevel=320, multiplier=0.0024 },
	{ minlevel=321, maxlevel=325, multiplier=0.0023 },
	{ minlevel=326, maxlevel=330, multiplier=0.0022 },
	{ minlevel=331, maxlevel=335, multiplier=0.0021 },
	{ minlevel=336, maxlevel=340, multiplier=0.0015 },
	{ minlevel=341, maxlevel=345, multiplier=0.0014 },
	{ minlevel=346, maxlevel=350, multiplier=0.0013 },
	{ minlevel=351, maxlevel=355, multiplier=0.0012 },
	{ minlevel=356, maxlevel=360, multiplier=0.0011 },
	{ minlevel=361, maxlevel=999, multiplier=0.0005 }
}

-- Rates
-- NOTE: rateExp is not used if you have enabled stages above
rateExp = 5
rateSkill = 3
rateLoot = 2
rateMagic = 3
rateSpawn = 1

-- Monster Despawn Config
-- despawnRange is the amount of floors a monster can be from its spawn position
-- despawnRadius is how many tiles away it can be from its spawn position
-- removeOnDespawn will remove the monster if true or teleport it back to its spawn position if false
-- walkToSpawnRadius is the allowed distance that the monster will stay away from spawn position when left with no targets, 0 to disable
deSpawnRange = 2
deSpawnRadius = 50
removeOnDespawn = true
walkToSpawnRadius = 15

-- Stamina
staminaSystem = true

-- Scripts
warnUnsafeScripts = true
convertUnsafeScripts = true

-- Startup
-- NOTE: defaultPriority only works on Windows and sets process
-- priority, valid values are: "normal", "above-normal", "high"
defaultPriority = "high"
startupDatabaseOptimization = false

-- Status Server Information
ownerName = ""
ownerEmail = ""
url = "https://otland.net/"
location = "Sweden"
