local npcGen = newNpc("npcLootSeller")

npcGen:setHiMsg("Hello my dear friend, you want DRINK something?", "Olá meu amigo, você deseja BEBER algo?")
npcGen:addSellableItens("drink")


npcGen:addOptionInNpc("job", {"I work with sale of various types of drinks.", "Eu trabalho com a venda de bebidas fermentadas para adultos!"})
npcGen:addOptionInNpc("drink", {"Sorry, but all my stock is finished, come back later.", "Me desculpe, todo meu estoque de bebidas está esgotado... Volte mais tarde."})
npcGen:addOptionInNpc("beber", {"Sorry, but all my stock is finished, come back later.", "Me desculpe, todo meu estoque de bebidas está esgotado... Volte mais tarde."})
npcGen:addOptionInNpc("help", {"I need a new stock of drink, you know someone who sells?", "Estou precisando de um novo estoque de bebidas, você conheçe alguem que venda?"})

function onCreatureSay(cid, type, msg)
    local msg = msg:lower()
    npcGen:onSay(cid, type, msg, 
    function(stage)
        if stage == 1 then
            npcGen:loadSellableItens(msg)
        end
        return true
    end)
end

function onThink()
    npcGen:onThink(function(cid)
        if math.random(1, 100) == 1 then
            npcGen:say("Hicks!", "Hicks!")
        end
    end)
end

function onCreatureDisappear(cid, pos)
    npcGen:onDisappear(cid, pos)
end
