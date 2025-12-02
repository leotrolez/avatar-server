local npcGen = newNpc("simpleBoatNpc")

npcGen:setHiMsg("Hello %s. I can take you around the continent, do you want see my ROUTES?", "Olá %s. Eu posso lhe transportar ao redor do continente, você deseja ver minhas ROUTES?")
npcGen:needPremium(true)
npcGen:setRoutes("simpleBoat")

npcGen:addOptionInNpc("help", {"I don't need your help, thank you.", "Eu não preciso de sua ajuda, obrigado."})

function onCreatureSay(cid, type, msg)
    local msg = msg:lower()
    npcGen:onSay(cid, type, msg, 
    function(stage)
        if stage == 1 then
            if msgcontains(msg, "routes") or msgcontains(msg, "offer") then
                if npcGen:isPlayerStageFree() then
                    npcGen:say("I can take you to: "..npcGen:getRoutesString()..".", "Eu posso levar você para: "..npcGen:getRoutesString()..".")
                    return true
                end
            end
            npcGen:loadShipRoutes(msg)
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