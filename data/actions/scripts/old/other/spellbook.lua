function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid

  local t = creature:getInstantSpells()

  table.sort(t, function(a, b) return a.level < b.level end)
  local text, prevLevel = "", -1
  for i, spell in ipairs(t) do
    local line = ""
    if(prevLevel ~= spell.level) then
      if(i ~= 1) then
        line = "\n"
      end

      line = line .. "Spells for Level " .. spell.level .. "\n"
      prevLevel = spell.level
    end

    text = text .. line .. "  " .. spell.words .. " - " .. spell.name .. " : " .. spell.mana .. "\n"
  end

  doShowTextDialog(cid, item.itemid, text)
  return true
end
