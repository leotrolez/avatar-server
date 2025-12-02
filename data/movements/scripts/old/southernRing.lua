southernEvents = {}

local function regenWaterPouch(cid)
	if not isCreature(cid) or getPlayerSlotItem(cid, CONST_SLOT_RING).itemid ~= 2123 then
		southernEvents[cid] = nil
		return false
	end
	local waterPouch = getPlayerItemById(cid, true, 4864)
	if waterPouch.uid > 0 then
		local pouchWater = getItemAttribute(waterPouch.uid, "water")
		if pouchWater < 100 then
			setWaterOnPounchPlayer(cid, pouchWater+1, waterPouch)
		end
	end
	doCreatureAddMana(cid, 9)
	southernEvents[cid] = addEvent(function() regenWaterPouch(cid) end, 3000)
	return true
end


function onEquip(player, item, slot)
	local cid = player.uid
	if southernEvents[cid] ~= nil then 
		stopEvent(southernEvents[cid])
	end
	southernEvents[cid] = addEvent(function() regenWaterPouch(cid) end, 3000)
    return true
end
 