local npcGen = newNpc("IceBoatNpc")

npcGen:setHiMsg("Hello %s. My boat is very cooooold haha, can you see my ROUTES?", "Olá %s. Nossa, aqui no meu boat é muito frioooo, você deseja ver minhas ROUTES?")
npcGen:needPremium(true)
npcGen:setRoutes("iceBoat")

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