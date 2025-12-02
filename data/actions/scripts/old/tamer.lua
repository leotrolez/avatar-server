local tamers = {
[17953] = "black sheep",
[17944] = "lady bug",
[5907] = "bear",
[17949] = "boar",
[17946] = "crustacea gigantica",
[17942] = "crystal wolf",
[17938] = "donkey",
[17941] = "dragonling",
[17948] = "draptor",
[17943] = "dromedary",
[17947] = "enraged white deer",
[17950] = "ironblight",
[17961] = "magma crawler",
[17945] = "manta ray",
[17951] = "midnight panther",
[17956] = "noble lion",
[17939] = "panda",
[17954] = "sandstone scorpion",
[17963] = "shock head",
[17955] = "slug",
[17940] = "terror bird",
[17952] = "undead cavebear",
[17964] = "wailing widow",
[17962] = "water buffalo"
}

local toMountId = 
{
["black sheep"] = 1,
["crystal wolf"] = 2,
["donkey"] = 3,
["dragonling"] = 4,
["draptor"] = 5,
["dromedary"] = 6,
["ironblight"] = 7,
["enraged white deer"] = 8,
["lady bug"] = 9,
["magma crawler"] = 10,
["manta ray"] = 11,
["midnight panther"] = 12,
["noble lion"] = 13,
["terror bird"] = 14,
["boar"] = 15,
["sandstone scorpion"] = 16,
["shock head"] = 17,
["panda"] = 18,
["slug"] = 19,
["crustacea gigantica"] = 20,
["undead cavebear"] = 21,
["bear"] = 22,
["water buffalo"] = 23,
["wailing widow"] = 24
}

local toDomarChance = 
{ -- as chances comentadas sao caso passe pelo test do monstro nao fugir
["black sheep"] = 50, -- em media a cada 3 domagens sem fugir, somente 1 vai quebrar sem domar e os outros 2 itens vao domar, 70% de conseguir se o mob n fugir
["donkey"] = 50,
["dromedary"] = 20,
["ironblight"] = 20,
["enraged white deer"] = 20,
["lady bug"] = 20,
["magma crawler"] = 20,
["terror bird"] = 20,
["shock head"] = 20,
["undead cavebear"] = 20,
["bear"] = 20,
["water buffalo"] = 20,
["wailing widow"] = 20,
["crustacea gigantica"] = 20,
["slug"] = 20,
["boar"] = 15,
["manta ray"] = 10,
["sandstone scorpion"] = 10,
["noble lion"] = 8, -- em media gastara 9 pra conseguir
["draptor"] = 8,
["midnight panther"] = 5, -- em media gastara 14 pra conseguir, pois tem 7% de conseguir se o mob n fugir
["panda"] = 5,
["dragonling"] = 5,
["crystal wolf"] = 5
}

local forbiddenMusicBox = {2, 11, 12, 16, 13, 18, 4, 5}

function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if item.itemid == 17965 and isCreature(itemEx.uid) and isMonster(itemEx.uid) and toMountId[string.lower(getCreatureName(itemEx.uid))] then -- Music box system
		local mount = toMountId[string.lower(getCreatureName(itemEx.uid))]
		if isInArray(forbiddenMusicBox, mount) then
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você não pode domar este animal com a music box.")
			return true
		end 
		if canPlayerRideMount(cid, mount) then
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já possui esta montaria.")
			return true
		end
		doRemoveItem(item.uid, 1)
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Você conseguiu domar a "..getCreatureName(itemEx.uid)..".")
		doPlayerAddMount(cid, mount)
		doRemoveCreature(itemEx.uid)
		return true
	end
	local monsterTamer = tamers[item.itemid]

  if monsterTamer and isCreature(itemEx.uid) and isMonster(itemEx.uid) and string.lower(getCreatureName(itemEx.uid)) == monsterTamer then
		if canPlayerRideMount(cid, toMountId[string.lower(getCreatureName(itemEx.uid))]) then
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você já possui esta montaria.")
			return true
		end
		local random = math.random(1, 100)
		if random >= 71 then 
			-- ele fugiu
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você não obteve sucesso em domar, a "..getCreatureName(itemEx.uid).." fugiu.")
			doSendMagicEffect(toPosition, CONST_ME_POFF)
			doRemoveCreature(itemEx.uid)
		elseif random >= 71-(toDomarChance[string.lower(getCreatureName(itemEx.uid))]) then
			-- yes
			doRemoveItem(item.uid, 1)
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabéns! Você conseguiu domar a "..getCreatureName(itemEx.uid)..".")
			doSendMagicEffect(fromPosition, 30)
			local mount = toMountId[string.lower(getCreatureName(itemEx.uid))]
			doPlayerAddMount(cid, mount)
			doRemoveCreature(itemEx.uid)
		else 
			--broken 
			doRemoveItem(item.uid, 1)
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você não obteve sucesso em domar, o seu item quebrou.")
			doSendMagicEffect(fromPosition, CONST_ME_POFF)
		end 
    return true
	elseif isCreature(itemEx.uid) and toMountId[string.lower(getCreatureName(itemEx.uid))] then
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você não pode domar com este item.")
			return true
  end
  return false
end