local alavancas = {{x=321, y=954, z=8}, {x=426, y=952, z=8}}
local stones = {{x=413, y=950, z=8},{x=416, y=950, z=8}}

local function colocarPedrass()
	for i = 1, 2 do 
		local pos = alavancas[i]
		local v = getTileItemById(pos, 1946).uid
		if v > 0 then
			doTransformItem(v, 1945)
		end
		doCreateItem(1547, 1, stones[i])
	end 
end 

local function removerPedrass()
	for i = 1, 2 do 
		local pos = alavancas[i]
		local v = getTileItemById(pos, 1945).uid
		if v > 0 then
			doTransformItem(v, 1946)
		end
		local pedra = getTileItemById(stones[i], 1547).uid
		if pedra > 0 then
			doRemoveItem(pedra)
		end	
	end 
end 


function onUse(creature, item, fromPosition, itemEx, toPosition)
  local cid = creature.uid
	if item.itemid == 1945 then 
		removerPedrass()
		addEvent(colocarPedrass, 1*60*1000)
        sendBlueMessage(cid, getLangString(cid, "You just pulled a lever! Run, you only have 1 minute!", "Você acabou de puxar uma alavanca! Corra, você só tem 1 minuto!"))
		return true
	end 
  return false 
end
