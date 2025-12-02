local npcGen = newNpc("TaskInitialNpc")
local currentTask = getTaskInfosByIdentifier(1)

npcGen:setFuncStart(function(cid)
    if getPlayerHasEndTask(cid, 1) == false then
        if playerHasTaskInProgress(cid, 1) then
            npcGen:say("Hello adventurer, did you kill all "..currentTask.monsterName.."(s)?", "Olá jovem, você matou todos "..currentTask.monsterName.."(s)?")
            npcGen:setStage(2)
        else
            npcGen:say("Hello "..creatureGetName(cid).."! I see you're new here, you can prove your skills to me, making a TASK for me, do you accept?", "Olá "..creatureGetName(cid).."! Eu vejo que você é novo aqui, você pode provar suas habilidades fazendo uma pequena TASK para mim, você aceita?")
            npcGen:setStage(1)
        end
        return true
    else
        npcGen:say("Hello "..creatureGetName(cid)..", I don't have any more task for you, young warrior, good luck!", "Olá "..creatureGetName(cid)..", eu não tenho mais tasks para você, jovem guerreiro, boa sorte em sua jornada!")
        return false
    end
end)

function onCreatureSay(cid, type, msg)
    local msg = msg:lower()
    npcGen:onSay(cid, type, msg, 
    function(stage)
        if stage == 1 then
            if (msgcontains(msg, "yes") or msgcontains(msg, "sim") or msgcontains(msg, "task") or msgcontains(msg, "tasks")) and playerHasTaskInProgress(cid, 1) == false then
                npcGen:say("Ok, you need kill "..currentTask.amount.." "..currentTask.monsterName.."(s) I'm waiting for you, good luck!", "Ok, você precisa matar "..currentTask.amount.." "..currentTask.monsterName.."(s) estarei esperando por você, boa sorte!")
                startTaskInPlayer(cid, 1, getNpcName())
                npcGen:forceBye()
            end
        else
            if (msgcontains(msg, "yes") or msgcontains(msg, "sim") or msgcontains(msg, "task") or msgcontains(msg, "tasks")) and playerHasTaskInProgress(cid, 1) then
                if endTaskInPlayer(cid, 1) then
                    npcGen:say("I really underestimated you, here's your reward, good luck in your learning.", "Eu realmente subestimei você, aqui está sua recompensa, boa sorte em sua jornada.")
                else
                    npcGen:say("You haven't done this task, you need kill more "..currentTask.amount-getMonstersHasKilled(cid, 1).. " "..currentTask.monsterName.."(s) to complete this.", "Você ainda não terminou essa task, você precisa matar mais "..currentTask.amount-getMonstersHasKilled(cid, 1).. " "..currentTask.monsterName.."(s) para termina-la.")
                end
                npcGen:forceBye()
            end
        end
        return false
    end)
end

function onThink()
    npcGen:onThink()
end

function onCreatureDisappear(cid, pos)
    npcGen:onDisappear(cid, pos)
end




--[[local focus, talk_start, tableTask = 0, 0, getTaskInfosByIdentifier(1)

function onThingMove(creature, thing, oldpos, oldstackpos) return true end
function onCreatureAppear(creature) return true end
function onCreatureTurn(creature) return true end

function onCreatureDisappear(cid, pos)
    if focus == cid then
        selfSay('Good bye then.')
        focus = 0
        talk_start = 0
    end
end

function onCreatureSay(cid, type, msg)
    local msg = string.lower(msg)

    if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
        if getPlayerHasEndTask(cid, 1) == false then
            if playerHasTaskInProgress(cid, 1) then
                selfSay("Hello adventurer, did you kill all "..tableTask.monsterName.."s?")  
                talk_state = 1
            else
                selfSay("Hello "..creatureGetName(cid).."! I see you're new here, you can prove your skills to me, making a TASK for me, do you accept?")
                talk_state = 0
            end
            focus = cid
            talk_start = os.clock()
        else
            selfSay("Hello "..creatureGetName(cid)..", I don't have any more task for you, young warrior, good luck!")
            return true
        end

    elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
        selfSay(creatureGetName(cid)..", please wait for your turn.")

    elseif focus == cid then
        talk_start = os.clock()

        if msgcontains(msg, 'bye') and getDistanceToCreature(cid) < 4 then
            selfSay('Good bye, ' .. creatureGetName(cid) .. '!')
            focus = 0
            talk_start = 0
            return true
        elseif msgcontains(msg, 'hi') and talk_state == 0 then
            selfSay("I'm already talking with you.")
        end

        if talk_state == 0 then
            if (msgcontains(msg, "yes") or msgcontains(msg, "task") or msgcontains(msg, "tasks")) and playerHasTaskInProgress(cid, 1) == false then
                selfSay("Ok, you need kill "..tableTask.amount.." "..tableTask.monsterName.."s I'm waiting for you, good luck!")
                startTaskInPlayer(cid, 1, getNpcName())
                focus = 0
                talk_start = 0
                return true
            end

        elseif talk_state == 1 then
            if (msgcontains(msg, "yes") or msgcontains(msg, "task") or msgcontains(msg, "tasks")) and playerHasTaskInProgress(cid, 1) then
                if endTaskInPlayer(cid, 1) then
                    selfSay("I really underestimated you, here's your reward, good luck in your learning.")
                    focus = 0
                    talk_start = 0
                    return true
                else
                    selfSay("Oh not, you didn't kill all "..tableTask.monsterName.."s, come back when you are finished.")
                    focus = 0
                    talk_start = 0
                    return true
                end
            end
        end
    end
end


function onCreatureChangeOutfit(creature)

end


function onThink()
    doNpcSetCreatureFocus(focus)
    if (os.clock() - talk_start) > 30 then
        if focus > 0 then
            selfSay('Next please!')
        end
        focus = 0
    end
    if focus ~= 0 then
        if getDistanceToCreature(focus) > 5 then
            selfSay('How rude!')
            focus = 0
        end
    end
end --]]