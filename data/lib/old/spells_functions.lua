VOCATION_FIRE  = 1
VOCATION_WATER = 2
VOCATION_AIR = 3
VOCATION_EARTH  = 4

SpellTree = {
	-- colar aqui a mesma tabela spelltree do servidor, irá poupar tempo e servirá como cache pro client
	[VOCATION_FIRE] = {
        [1] = {scroll_level = 1, scroll_type = "initial", scroll_count = 1, spells = {"fire whip", "fire recover"}},
		[2] = {scroll_level = 5, scroll_type = "bronze", scroll_count = 1, spells = {"fire recover", "fire urecover"}},
        [3] = {scroll_level = 8, scroll_type = "bronze", scroll_count = 1, spells = {"fire kick", "fire wave"}},
		[4] = {scroll_level = 12, scroll_type = "bronze", scroll_count = 1, spells = {"fire skyfall"}},
		[5] = {scroll_level = 16, scroll_type = "silver", scroll_count = 1, spells = {"fire jump", "fire blast"}},
		[6] = {scroll_level = 20, scroll_type = "silver", scroll_count = 1, spells = {"fire impulse"}},
		[7] = {scroll_level = 25, scroll_type = "silver", scroll_count = 1, spells = {"fire bolt"}},
		[8] = {scroll_level = 30, scroll_type = "silver", scroll_count = 1, spells = {"fire res"}},
		[9] = {scroll_level = 36, scroll_type = "gold", scroll_count = 1, spells = {"fire star"}},
		[10] = {scroll_level = 42, scroll_type = "gold", scroll_count = 1, spells = {"fire cannon"}},
		[11] = {scroll_level = 46, scroll_type = "gold", scroll_count = 1, spells = {"fire wrath"}},
		[12] = {scroll_level = 50, scroll_type = "gold", scroll_count = 1, spells = {"fire focus"}},
		[13] = {scroll_level = 55, scroll_type = "gold", scroll_count = 1, spells = {"fire lightning"}},
		[14] = {scroll_level = 60, scroll_type = "platinum", scroll_count = 1, spells = {"fire bomb"}},
		[15] = {scroll_level = 65, scroll_type = "platinum", scroll_count = 1, spells = {"fire clock"}},
		[16] = {scroll_level = 70, scroll_type = "platinum", scroll_count = 1, spells = {"fire thunderbolt"}},
		[17] = {scroll_level = 80, scroll_type = "platinum", scroll_count = 1, spells = {"fire meteor"}},
		[18] = {scroll_level = 90, scroll_type = "platinum", scroll_count = 1, spells = {"fire striker"}},
		[19] = {scroll_level = 100, scroll_type = "platinum", scroll_count = 1, spells = {"fire overload"}},
		[20] = {scroll_level = 110, scroll_type = "platinum", scroll_count = 1, spells = {"fire explosion"}},
		[21] = {scroll_level = 130, scroll_type = "platinum", scroll_count = 1, spells = {"fire voltage"}},
		[22] = {scroll_level = 150, scroll_type = "platinum", scroll_count = 1, spells = {"fire thunderstorm"}},
		[23] = {scroll_level = 200, scroll_type = "platinum", scroll_count = 1, spells = {"fire discharge"}},
		[24] = {scroll_level = 250, scroll_type = "platinum", scroll_count = 1, spells = {"fire conflagration"}}
	},
	[VOCATION_WATER] = {
        [1] = {scroll_level = 1, scroll_type = "initial", scroll_count = 1, spells = {"water whip"}},
		[2] = {scroll_level = 5, scroll_type = "bronze", scroll_count = 1, spells = {"water recover", "water urecover"}},
        [3] = {scroll_level = 8, scroll_type = "bronze", scroll_count = 1, spells = {"water explosion"}},
		[4] = {scroll_level = 12, scroll_type = "bronze", scroll_count = 1, spells = {"water heal", "water sheal"}},
		[5] = {scroll_level = 16, scroll_type = "silver", scroll_count = 1, spells = {"water jump", "water wave"}},
		[6] = {scroll_level = 20, scroll_type = "silver", scroll_count = 1, spells = {"water icespikes"}},
		[7] = {scroll_level = 25, scroll_type = "silver", scroll_count = 1, spells = {"water res"}},
		[8] = {scroll_level = 30, scroll_type = "silver", scroll_count = 1, spells = {"water shards"}},
		[9] = {scroll_level = 36, scroll_type = "gold", scroll_count = 1, spells = {"water surf"}},
		[10] = {scroll_level = 42, scroll_type = "gold", scroll_count = 1, spells = {"water cannon"}},
		[11] = {scroll_level = 46, scroll_type = "gold", scroll_count = 1, spells = {"water regen", "water sregen", "water mregen"}},
		[12] = {scroll_level = 50, scroll_type = "gold", scroll_count = 1, spells = {"water bloodcontrol"}},
		[13] = {scroll_level = 55, scroll_type = "gold", scroll_count = 1, spells = {"water punch"}},
		[14] = {scroll_level = 60, scroll_type = "platinum", scroll_count = 1, spells = {"water dragon"}},
		[15] = {scroll_level = 65, scroll_type = "platinum", scroll_count = 1, spells = {"water rain"}},
		[16] = {scroll_level = 70, scroll_type = "platinum", scroll_count = 1, spells = {"water bubbles"}},
		[17] = {scroll_level = 80, scroll_type = "platinum", scroll_count = 1, spells = {"water protect"}},
		[18] = {scroll_level = 90, scroll_type = "platinum", scroll_count = 1, spells = {"water icebolt"}},
		[19] = {scroll_level = 100, scroll_type = "platinum", scroll_count = 1, spells = {"water flow"}},
		[20] = {scroll_level = 110, scroll_type = "platinum", scroll_count = 1, spells = {"water water icegolem"}},
		[21] = {scroll_level = 130, scroll_type = "platinum", scroll_count = 1, spells = {"water tsunami"}},
		[22] = {scroll_level = 150, scroll_type = "platinum", scroll_count = 1, spells = {"water clock"}},
		[23] = {scroll_level = 200, scroll_type = "platinum", scroll_count = 1, spells = {"water blizzard"}},
		[24] = {scroll_level = 250, scroll_type = "platinum", scroll_count = 1, spells = {"water bloodbending"}}
	},
	[VOCATION_AIR] = {
        [1] = {scroll_level = 1, scroll_type = "initial", scroll_count = 1, spells = {"air burst", "air ball"}},
		[2] = {scroll_level = 5, scroll_type = "bronze", scroll_count = 1, spells = {"air recover", "air urecover"}},
        [3] = {scroll_level = 8, scroll_type = "bronze", scroll_count = 1, spells = {"air burst"}},
		[4] = {scroll_level = 12, scroll_type = "bronze", scroll_count = 1, spells = {"air run"}},
		[5] = {scroll_level = 16, scroll_type = "silver", scroll_count = 1, spells = {"air jump"}},
		[6] = {scroll_level = 20, scroll_type = "silver", scroll_count = 1, spells = {"air force"}},
		[7] = {scroll_level = 25, scroll_type = "silver", scroll_count = 1, spells = {"air gust"}},
		[8] = {scroll_level = 30, scroll_type = "gold", scroll_count = 1, spells = {"air gale", "air icywind"}},
		[9] = {scroll_level = 36, scroll_type = "gold", scroll_count = 1, spells = {"air boost"}},
		[10] = {scroll_level = 42, scroll_type = "gold", scroll_count = 1, spells = {"air fan"}},
		[11] = {scroll_level = 46, scroll_type = "platinum", scroll_count = 1, spells = {"air wings"}},
		[12] = {scroll_level = 50, scroll_type = "platinum", scroll_count = 1, spells = {"air suffocation", "air jail"}},
		[13] = {scroll_level = 55, scroll_type = "platinum", scroll_count = 1, spells = {"air hurricane"}},
		[14] = {scroll_level = 60, scroll_type = "platinum", scroll_count = 1, spells = {"air tempest"}},
		[15] = {scroll_level = 65, scroll_type = "platinum", scroll_count = 1, spells = {"air windblast"}},
		[16] = {scroll_level = 70, scroll_type = "platinum", scroll_count = 1, spells = {"air tornado"}},
		[17] = {scroll_level = 80, scroll_type = "platinum", scroll_count = 1, spells = {"air barrier"}},
		[18] = {scroll_level = 90, scroll_type = "platinum", scroll_count = 1, spells = {"air trap"}},
		[19] = {scroll_level = 100, scroll_type = "platinum", scroll_count = 1, spells = {"air doom"}},
		[20] = {scroll_level = 110, scroll_type = "platinum", scroll_count = 1, spells = {"air bomb"}},
		[21] = {scroll_level = 130, scroll_type = "platinum", scroll_count = 1, spells = {"air windstorm"}},
		[22] = {scroll_level = 150, scroll_type = "platinum", scroll_count = 1, spells = {"air stormcall"}},
		[23] = {scroll_level = 200, scroll_type = "platinum", scroll_count = 1, spells = {"air vortex"}},
		[24] = {scroll_level = 250, scroll_type = "platinum", scroll_count = 1, spells = {"air deflection"}}
	},
	[VOCATION_EARTH] = {
        [1] = {scroll_level = 1, scroll_type = "initial", scroll_count = 1, spells = {"earth whip", "earth crush"}},
		[2] = {scroll_level = 5, scroll_type = "bronze", scroll_count = 1, spells = {"earth recover", "earth urecover"}},
        [3] = {scroll_level = 8, scroll_type = "bronze", scroll_count = 1, spells = {"earth punch"}},
		[4] = {scroll_level = 12, scroll_type = "bronze", scroll_count = 1, spells = {"earth rock"}},
		[5] = {scroll_level = 16, scroll_type = "silver", scroll_count = 1, spells = {"earth jump"}},
		[6] = {scroll_level = 20, scroll_type = "silver", scroll_count = 1, spells = {"earth pull"}},
		[7] = {scroll_level = 25, scroll_type = "silver", scroll_count = 1, spells = {"earth growth"}},
		[8] = {scroll_level = 30, scroll_type = "silver", scroll_count = 1, spells = {"earth collapse"}},
		[9] = {scroll_level = 36, scroll_type = "gold", scroll_count = 1, spells = {"earth track"}},
		[10] = {scroll_level = 42, scroll_type = "gold", scroll_count = 1, spells = {"earth petrify"}},
		[11] = {scroll_level = 46, scroll_type = "gold", scroll_count = 1, spells = {"earth fury"}},
		[12] = {scroll_level = 50, scroll_type = "gold", scroll_count = 1, spells = {"earth control"}},
		[13] = {scroll_level = 55, scroll_type = "gold", scroll_count = 1, spells = {"earth leech"}},
		[14] = {scroll_level = 60, scroll_type = "platinum", scroll_count = 1, spells = {"earth smash"}},
		[15] = {scroll_level = 65, scroll_type = "platinum", scroll_count = 1, spells = {"earth ingrain"}},
		[16] = {scroll_level = 70, scroll_type = "platinum", scroll_count = 1, spells = {"earth fists"}},
		[17] = {scroll_level = 80, scroll_type = "platinum", scroll_count = 1, spells = {"earth arena"}},
		[18] = {scroll_level = 90, scroll_type = "platinum", scroll_count = 1, spells = {"earth curse"}},
		[19] = {scroll_level = 100, scroll_type = "platinum", scroll_count = 1, spells = {"earth quake"}},
		[20] = {scroll_level = 110, scroll_type = "platinum", scroll_count = 1, spells = {"earth cataclysm"}},
		[21] = {scroll_level = 130, scroll_type = "platinum", scroll_count = 1, spells = {"earth aura"}},
		[22] = {scroll_level = 150, scroll_type = "platinum", scroll_count = 1, spells = {"earth armor"}},
		[23] = {scroll_level = 200, scroll_type = "platinum", scroll_count = 1, spells = {"earth lavaball"}},
		[24] = {scroll_level = 250, scroll_type = "platinum", scroll_count = 1, spells = {"earth metalwall"}}
	}
}

function getScrollIdByType(type)
	type = type and string.lower(type)
	if type == "initial" then
		return 18244
	elseif type == "bronze" then
		return 18244
	elseif type == "silver" then
		return 18245
	elseif type == "gold" then
		return 18246
	elseif type == "platinum" then
		return 18247
	end
	return nil
end

local function returnElement(spellName)
	return string.explode(spellName, " ")[1]
end
  
local function returnSpell(spellName)
	return string.explode(spellName, " ")[2]
end

function getSpellCooldown(cid, spellName)
  local currentTime, delayTime = os.time(), getPlayerStorageValue(cid, "exausted"..returnElement(spellName)..returnSpell(spellName))
  if delayTime >= currentTime then
    return delayTime-currentTime
  end
  return 0
end

function canPlayerLearnSpellTree(cid, name)
	if getPlayerLearnedInstantSpell(cid, name) then
		doPlayerSendCancel(cid, "You already learned this spell.")
		return false
	end

	local tree = SpellTree[getPlayerVocation(cid)]
	if tree == nil then
		doPlayerSendCancel(cid, "Something has gone wrong. Contact a GM.")
		return false
	end

	for k, v in pairs(tree) do
		if isInArray(v.spells, name) then
			for _, spell in pairs(v.spells) do
				if getPlayerLearnedInstantSpell(cid, spell) then -- check if player has learned a spell before
					doPlayerSendCancel(cid, "You already learned a spell from this tree.")
					return false
				end
			end
		end
	end
	return true
end

function getPlayerSpells(cid)
	local player = Player(cid)

	local list = {}
	local spells = player:getInstantSpells()
	for _, spell in pairs(spells) do
		if spell.level > 0 then
			table.insert(list, spell.name)
		end
	end
	return list
end

--[[TFS 1.x
function getPlayerSpells(cid)
	local list = {}
	local count = getPlayerInstantSpellCount(cid)-1
	for i = 0, count do
		local spell = getPlayerInstantSpellInfo(cid, i)
		if spell and spell.level > 0 then
			table.insert(list, {name = spell.name, level = spell.level})
		end
	end

	table.sort(list, function(a,b) return a.level < b.level end) -- sort by level

	local spells = {}
	for i = 1, #list do
		spells[#spells + 1] = list[i].name
	end
	return spells
end
--]]

function doPlayerLearnSpellTree(cid, pos, spell)
	local voc = getPlayerVocation(cid)
	local t = SpellTree[voc] and SpellTree[voc][pos] or nil

	if t == nil or getPlayerLevel(cid) < t.scroll_level then
		return false
	end

	if not canPlayerLearnSpellTree(cid, spell) then
		return false
	end

	local scroll_id = getScrollIdByType(t.scroll_type)
	if not doPlayerRemoveItem(cid, scroll_id, t.scroll_count) then
		doPlayerSendCancel(cid, "You need " .. t.scroll_count .. "x " .. t.scroll_type .. " Scroll" .. (t.scroll_count > 1 and 's' or '') .. " to learn this spell.")
		return false
	end

	doPlayerLearnInstantSpell(cid, spell)
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, 'Congratulations! You have learned a new spell (' .. spell .. ').')
	sendPlayerSpells(cid)

	return true
end

function getSpellScrollCount(cid, spell)
	local tree = SpellTree[getPlayerVocation(cid)]
	if tree == nil then
		return nil
	end

	for _, v in pairs(tree) do
		if isInArray(v.spells, spell) then
			return getScrollIdByType(v.scroll_type), v.scroll_count
		end
	end
	return nil
end

function doPlayerResetSpellTree(cid)
	local list = getPlayerSpells(cid)
	if not list or #list < 1 then
		doPlayerSendCancel(cid, "You don't have spells to unlearn.")
	end

	for _, spell in pairs(getPlayerSpells(cid)) do
		if getPlayerLearnedInstantSpell(cid, spell) then
			local scrollId, scrollCount = getSpellScrollCount(cid, spell)
			if scrollId and scrollCount then
				doPlayerAddItem(cid, scrollId, scrollCount)
			end
			doPlayerUnlearnInstantSpell(cid, spell)
		end
	end

	doRemoveCreature(cid)
	return true
end

function sendPlayerSpells(cid)
	local spells = getPlayerSpells(cid)
	doSendPlayerExtendedOpcode(cid, 50, serialize(spells))
	sendSpellsCooldown(cid, spells)
end

function sendPlayerWeaponSpells(cid, ...)
	doSendPlayerExtendedOpcode(cid, 52, serialize({...}))
end

function sendSpellCooldown(cid, ...)
	doSendPlayerExtendedOpcode(cid, 53, serialize({...}))
end

function sendSpellsCooldown(cid, spells)
	spells = spells or getPlayerSpells(cid)
	for _, spell in pairs(spells) do
		local time = getSpellCooldown(cid, spell)
		if time > 0 then
			sendSpellCooldown(cid, spell, time)
		end
	end
end

--[[
* Faz todas verificações necessarias para as spells, porém ainda não funciona em spells complexas,
pois elas precisam fazer varias verificações a parte, para serem tratadas individualmente.
]]--

local function returnElement(spellName)
    return string.explode(spellName, " ")[1]
end

local function returnSpell(spellName)
    return string.explode(spellName, " ")[2]
end

function allSpellChecks(cid, spellName, exaustTime, alreadyStarted)
    local spellElement = returnElement(spellName)

    if alreadyStarted then
        return false
    end

    if getSpellCancels(cid, spellElement) then
        return false
    end

    local spellName = returnSpell(spellName)

    if not getPlayerExaust(cid, spellElement, spellName) then
        return false
    end

    doPlayerAddExaust(cid, spellElement, spellName, exaustTime or 1)

    if getPlayerHasStun(cid) then
        return true
    end

    return "ready"
end

function isPzPos(pos)
    if not hasSqm(pos) then
        return false
    end
    return getTileInfo(pos).protection
end

function isImune(cid, creature)
    local skulls = {1,3,4,5,6}
    if isMonster(creature) or isMonster(cid) then
        return false
    end
    if isPlayer(cid) and isPlayer(creature) and (getPlayerStorageValue(cid, "canAttackable") == 1 or getPlayerStorageValue(creature, "canAttackable") == 1) then
        return true
    end
    local modes = getPlayerModes(cid)
    if isInArray(skulls, getCreatureSkullType(creature)) then
        return false
    end
    if (modes.secure == SECUREMODE_OFF) then
        return false
    end
    return true
end

function isInPvpZone(cid)
    local pos = getCreaturePosition(cid)
    if getTileInfo(pos).hardcore then
        return true
    end
    return false
end

function isInSameGuild(cid, target)
    if isPlayer(target) and not (isInPvpZone(target) and not castleWar.isOnCastle(target)) then
        local cidGuild = getPlayerGuildId(cid)
        local targGuild = getPlayerGuildId(target)
        if cidGuild > 0 and cidGuild == targGuild then
            return true
        end
    end
    return false
end

function isPzPos(pos)
    if not hasSqm(pos) then
        return false
    end
    return getTileInfo(pos).protection
end

function isAndavel(pos, cid)
    return getPlayerCanWalk({player = cid, position = pos, checkPZ = false, checkHouse = true, createTile = itsFlySpell and isPlayer(cid)})
end

function isProjectable(pos)
    if not hasSqm(pos) then
        return true
    end
    return isSightClear({x=pos.x-1, y=pos.y, z=pos.z}, {x=pos.x+1, y=pos.y, z=pos.z}, true) and not getTileInfo(pos).protection
end
