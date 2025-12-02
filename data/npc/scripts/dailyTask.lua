local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
npcHandler.talkRadius = 4
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) 			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) 		end
function onCreatureSay(cid, type, msg) 		npcHandler:onCreatureSay(cid, type, msg) 	end
function onThink() 							npcHandler:onThink() 						end
function onPlayerEndTrade(cid)				npcHandler:onPlayerEndTrade(cid)			end
function onPlayerCloseChannel(cid)			npcHandler:onPlayerCloseChannel(cid)		end

npcHandler:setMessage(MESSAGE_GREET, "")

function addDailysByTime(cid)
local storages = {"TimeDailyUm", "TimeDailyDois", "TimeDailyTres", "TimeDailyQuatro"}
for i = 1, #storages do 
	if os.time() >= getPlayerStorageValue(cid, storages[i]) then 
		setPlayerStorageValue(cid, storages[i], os.time()+24*60*60)
		break;
	end
end 
end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local playerPos, lang, taskCourse = getThingPos(cid), getLang(cid), getDailyCourse(cid)
	if taskCourse >= 4 then
		selfSay(getLangString(cid, "Haha, you already did your tasks, come back tomorrow!", "Haha, você já terminou suas tasks de hoje, volte amanhã!"), cid)
        return false
    else
      --  local canDoAgain = checkDelayIsFree(cid)

      --  if not canDoAgain.state then
       --     local stringDelay = getSecsString(canDoAgain.time)
			--	selfSay(getLangString(cid, "Sorry, you need wait "..stringDelay.." to do daily task again.", "Desculpe, você precisa esperar "..stringDelay.." para fazer suas daily tasks novamente.")
		--	selfSay(getLangString(cid, "Haha, you already did your tasks, come back tomorrow!", "Haha, você já terminou suas tasks de hoje, volte amanhã!"), cid)
         --   return false
     --   end
    end

    if getPlayerSkullType(cid) > 3 then
        selfSay(getLangString(cid, "Sorry, i don't talk with violent people.", "Desculpe, eu não falo com pessoas violentas."), cid)
        return false
    end
	
	if getPlayerLevel(cid) < 10 then 
		selfSay(getLangString(cid, "You need to reach level 10 first.", "Você precisa alcançar o nível 10 primeiro! Mate alguns monstros e depois volte à falar comigo."), cid)
		return true
	end
	
    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid 
	msg = string.lower(msg)
	if not talkState[talkUser] or talkState[talkUser] <= 0 then
		talkState[talkUser] = 1 
	end
	if talkState[talkUser] == 1 then
            local taskCourse = getDailyCourse(cid)

            if msgcontains(msg, "task") then
                if taskCourse < 4 and getPlayerStorageValue(cid, "isInDailyTask") ~= 1  then
                    local taskInfo = getDailyTaskInfos(cid, getDailyDificult(cid))
					local string = startDailyTask(cid)
					local textoFala = getLangString(cid, "In your "..(taskCourse+1).."º today's task you need kill "..taskInfo.count.." "..taskInfo.monster.."(s), to earn your reward. Come back when you did this, your current task dificult is "..string..".", "Na sua "..(taskCourse+1).."º task de hoje você vai precisar matar "..taskInfo.count.." "..taskInfo.monster.."(s), para ganhar a sua recompensa. Volte aqui quando isso estiver feito, você está na dificuldade "..string..".")  
					if taskCourse+1 < 4 then
						textoFala = textoFala .. getLangString(cid, " If you don't want to make this task, you can always {skip}, but it will count in your total daily tasks limit.", " Caso não queira fazê-la, você pode {pular}, mas ela ainda irá contar como completada no seu limite diário.")	
					end
				   selfSay(textoFala, cid)
					talkState[talkUser] = 2
                elseif taskCourse < 5 and getPlayerStorageValue(cid, "isInDailyTask") == 1 then
                    selfSay(getLangString(cid, "Did you kill all monsters?", "Você já matou todos os monstros?"), cid)
                    talkState[talkUser] = 3
                else			
						selfSay(getLangString(cid, "Haha, you already did your tasks, come back tomorrow!", "Haha, você já terminou suas tasks de hoje, volte amanhã!"), cid)
                end
			elseif (msgcontains(msg, "pular") or msgcontains(msg, "skip")) and getPlayerStorageValue(cid, "isInDailyTask") == 1  then
				local dailyAtual = getDailyCourse(cid)
				dailyAtual = dailyAtual+1
				if dailyAtual >= 4 then
                    selfSay(getLangString(cid, "You cant skip the last daily task. If you want another one, come back tomorrow!", "Você não pode pular a última daily task. Se quer uma diferente, volte amanhã!"), cid)
					talkState[talkUser] = 1
				end
				local nextDailyInfos = getDailyTaskInfos(cid, getDailyDificult(cid), dailyAtual)
                selfSay(getLangString(cid, "You really want to skip to your "..(dailyAtual+1).." daily task? In your "..(dailyAtual+1).."º today's task you will need to kill "..nextDailyInfos.count.." "..nextDailyInfos.monster.."(s), to earn your reward. Are you sure?", "Tem certeza que deseja pular para a sua "..(dailyAtual+1).."º daily task? Na sua "..(dailyAtual+1).."º task de hoje, você vai precisar matar "..nextDailyInfos.count.." "..nextDailyInfos.monster.."(s), para ganhar a sua recompensa. Deseja mesmo pular?"), cid)
				talkState[talkUser] = 4
            else
                selfSay(getLangString(cid, "Ok, I think.", "Ok então."), cid)
            end

        elseif talkState[talkUser] == 2 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
				local theFala = getLangString(cid, "Ok, come back when you finish!", "Ok, volte aqui quando terminar!")
                if getDailyCourse(cid) < 4 then
					theFala = theFala .. getLangString(cid, " If you don't want to make this task, you can always {skip}, but it will count in your total daily tasks limit.", " Caso não queira fazê-la, você pode {pular}, mas ela ainda irá contar como completada no seu limite diário.")	
				end
				selfSay(theFala, cid)
                talkState[talkUser] = 1
			elseif msgcontains(msg, "pular") or msgcontains(msg, "skip") then
				local dailyAtual = getDailyCourse(cid)
				dailyAtual = dailyAtual+1
				if dailyAtual >= 4 then
                    selfSay(getLangString(cid, "You cant skip the last daily task. If you want another one, come back tomorrow!", "Você não pode pular a última daily task. Se quer uma diferente, volte amanhã!"), cid)
					talkState[talkUser] = 1
				end
				local nextDailyInfos = getDailyTaskInfos(cid, getDailyDificult(cid), dailyAtual)
                selfSay(getLangString(cid, "You really want to skip to your "..(dailyAtual+1).." daily task? In your "..(dailyAtual+1).."º today's task you will need to kill "..nextDailyInfos.count.." "..nextDailyInfos.monster.."(s), to earn your reward. Are you sure?", "Tem certeza que deseja pular para a sua "..(dailyAtual+1).."º daily task? Na sua "..(dailyAtual+1).."º task de hoje, você vai precisar matar "..nextDailyInfos.count.." "..nextDailyInfos.monster.."(s), para ganhar a sua recompensa. Deseja mesmo pular?"), cid)
				talkState[talkUser] = 4
            else
                selfSay(getLangString(cid, "Ok, I think.", "Ok então."), cid)
                talkState[talkUser] = 1
            end
        elseif talkState[talkUser] == 3 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
                local hasEnd = endDailyTask(cid)

                if hasEnd then
                    selfSay(getLangString(cid, "Congratulations! Get your reward.", "Parabéns! Pegue sua recompensa."), cid)
                    doSendMagicEffect(getThingPos(cid), 28)
					addDailysByTime(cid)
					talkState[talkUser] = 1
                else
                    selfSay(getLangString(cid, "You didn't do it yet... Do it and come back.", "Você ainda não completou a task... Volte aqui quando ela estiver terminada."), cid)
                end
            else
                selfSay(getLangString(cid, "Ok, I think.", "Ok então."), cid)
                talkState[talkUser] = 1
            end

        elseif talkState[talkUser] == 4 then
            if msgcontains(msg, "yes") or msgcontains(msg, "sim") or msgcontains(msg, "pular") or msgcontains(msg, "skip") then	
				doPlayerSetStorageValue(cid, "getCompletedDaily"..getDayID(), getPlayerStorageValue(cid, "getCompletedDaily"..getDayID())+1)
				doPlayerSetStorageValue(cid, "isInDailyTask", 0)			
				addDailysByTime(cid)
				talkState[talkUser] = 2
				local taskCourse = getDailyCourse(cid)
				local taskInfo = getDailyTaskInfos(cid, getDailyDificult(cid))
				local string = startDailyTask(cid)
                selfSay(getLangString(cid, "Alright! In your "..(taskCourse+1).."º today's task you need kill "..taskInfo.count.." "..taskInfo.monster.."(s), to earn your reward. Come back when you did this, your current task dificult is "..string..".", "Certo então, vamos para a próxima! Na sua "..(taskCourse+1).."º task de hoje você vai precisar matar "..taskInfo.count.." "..taskInfo.monster.."(s), para ganhar a sua recompensa. Volte aqui quando isso estiver feito, você está na dificuldade "..string.."."), cid)
            else
                selfSay(getLangString(cid, "Ok, I think.", "Ok então."), cid)
                talkState[talkUser] = 1
            end
        end
	return true
end

function onGreet(cid) 
	talkState[cid] = 1 	
    selfSay(getLangString(cid, "Hello "..getCreatureName(cid)..", are you interested in some {task} for rewards? I can offer you 4 each day!", "Olá "..getCreatureName(cid)..", eu sou simplesmente fascinado por conquistas e realizações pessoais, por isso eu vou lhe ajudar! Deseja iniciar uma {task}? Eu posso te oferecer 4 por dia!"), cid)
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:addModule(FocusModule:new())
