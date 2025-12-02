local npcGen = newNpc("tasksIceNpc")

npcGen:setHiMsg("Hello %s! I have some TASKs brave adventurer! Are you interested?", "Olá %s! Eu tenho algumas TASKs jovem aventureiro, você está interresado?")

npcGen:addOptionInNpc("help", {"I need money, can you give me? haha", "Eu preciso de grana, quer fazer uma doação? haha"})
npcGen:addOptionInNpc("job", {"My job is to offer various tasks, and reward those who achieve complete them.", "Meu trabalho é oferecer diversas tasks e recompensar quem completa-las."})
npcGen:setTasks("iceTasks")
npcGen:needPremium(true)

function onCreatureSay(cid, type, msg)
    local msg = msg:lower()
    npcGen:onSay(cid, type, msg, 
    function(stage)
        if stage == 1 then
            if msgcontains(msg, "task") or msgcontains(msg, "tasks") then
                if npcGen:isPlayerStageFree() then
                    npcGen:say(npcGen:getTasksString()[1], npcGen:getTasksString()[2])
                end
            end
            npcGen:loadTasks(msg)
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