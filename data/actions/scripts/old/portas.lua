function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
local doors = {[1219]={id=1220}}

local config = {
actionid = 62120, -- Uma action normal, só para a portar nao abrir.
keyaid = 62121 -- A action que deve ter na key
}
			for i, x in pairs(doors) do
			  if ((itemEx.itemid == i) and (itemEx.actionid == config.actionid) and (item.actionid == config.keyaid)) then
			   doTransformItem(itemEx.uid, x.id)
			   doItemSetAttribute(itemEx.uid, "aid", 0)
			  elseif (itemEx.itemid == x.id) and (itemEx.actionid == 0) and (item.actionid == config.keyaid) then
			   doTransformItem(itemEx.uid, i)
			   doItemSetAttribute(itemEx.uid, "aid", config.actionid)
			  elseif (itemEx.itemid == i) and (itemEx.actionid == 0) and (item.actionid == config.keyaid) then
			   doTransformItem(itemEx.uid, i)
			   doItemSetAttribute(itemEx.uid, "aid", config.actionid)
			  end
			end
return true
end