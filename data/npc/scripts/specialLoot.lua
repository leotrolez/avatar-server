local npcGen = newNpc("specialLootNpc")

npcGen:setHiMsg("Hello %s, brave adventurer! Can you see my OFFERS?", "Olá %s, bravo aventureiro! Você deseja ver minhas OFFERS?")
npcGen:addBuyableItens("lootSpecial")

npcGen:addOptionInNpc("job", {"I work with sale of various special things.", "Eu trabalho com a compra de itens especiais."})
npcGen:addOptionInNpc("offer", {npcLootSpecialOfferMensage[1], npcLootSpecialOfferMensage[2]})
npcGen:addOptionInNpc("help", {"No, thanks little boy.", "Não preciso de ajuda, obrigado criança."})

function onCreatureSay(cid, type, msg)
    local msg = msg:lower()
    npcGen:onSay(cid, type, msg, 
    function(stage)
        if stage == 1 then
            npcGen:loadBuyableItens(msg)
        end
        return true
    end)
end


function onThink()
    npcGen:onThink()
end

function onCreatureDisappear(cid, pos)
    npcGen:onDisappear(cid, pos)
end