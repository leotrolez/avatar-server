
function onSay(cid, words, param, channel)
  if getPlayerStorageValue(cid, "ativoBot") ~= 1 or os.time() > getPlayerStorageValue(cid, "horarioBot") then
    sendBlueMessage(cid, getLangString(cid, "You don't have any Anti-Bot verification right now.", "Você não tem nenhuma verificação Anti-Bot pendente."))
    return true
  end
  	if(param == '') then -- check question
		local valorUm = getPlayerStorageValue(cid, "valorUmBot")
		if not tonumber(valorUm) or valorUm == "" or valorUm == -1 then
			sendBlueMessage(cid, getLangString(cid, "[Error] Question not found. Generating a new question...", "[Erro] Pergunta não identificada. Gerando uma nova pergunta..."))
			verifyBot(cid)
			return true
		end
		local perguntaENG = "[Anti-Bot Question] Question shown by floating animation on top of your character, look at the screen. To respond, type in the transparent window that appeared the result of the question."
		local perguntaBR = "[Anti-Bot Question] Questão mostrada por animação flutuante em cima de seu personagem, observe na tela. Para responder, digite na janela transparente que apareceu o resultado da questão."
		sendBlueMessage(cid, getLangString(cid, perguntaENG, perguntaBR))
		doSendPlayerExtendedOpcode(cid, 168, getPlayerStorageValue(cid, "horarioBot") - os.time())
		return true
	end 
	if not tonumber(param) then 
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Resposta inválida. Faça novamente o cálculo e digite o resultado na janela.")
		doSendPlayerExtendedOpcode(cid, 168, getPlayerStorageValue(cid, "horarioBot") - os.time())
		return true
	end

	local respondeu = tonumber(param)
	local resposta = getPlayerStorageValue(cid, "respostaBot")
	if not tonumber(resposta) or tonumber(resposta) < 0 then
		sendBlueMessage(cid, getLangString(cid, "[System Error] Answer not found. Don't worry, we are generating a new question...", "[Erro no Sistema] Resposta não identificada. Não se preocupe, será gerada uma nova pergunta..."))
		verifyBot(cid)
		return true
	end
	if respondeu ~= tonumber(resposta) then
		local trys = getPlayerStorageValue(cid, "trysBot")
		if not tonumber(trys) or trys <= 0 then
			setPlayerStorageValue(cid, "trysBot", 3)
		end
		trys = trys-1
		if trys <= 0 then
			banimentoBot(cid) -- ban
			return true
		end
		setPlayerStorageValue(cid, "trysBot", trys)
		sendBlueMessage(cid, getLangString(cid, "Wrong answer. Do the calculation again and enter the result in the window. You can try again more "..trys.."x. If you miss all or finish the time, you will suffer a ban.", "Resposta errada. Faça novamente o cálculo e digite o resultado na janela. Você pode tentar mais "..trys.."x. Se errar todas ou acabar o tempo, sofrerá um banimento."))
		doSendPlayerExtendedOpcode(cid, 168, getPlayerStorageValue(cid, "horarioBot") - os.time())
		return true
	end
	sendBlueMessage(cid, getLangString(cid, "[Anti-Bot System] Verification done, have a nice game!", "[Anti-Bot System] Verificação finalizada, tenha um bom jogo!"))
	setPlayerStorageValue(cid, "ativoBot", 0)
	exhaustion.set(cid, "checkcooldownBot", math.random(2*60*60, 8*60*60)) -- se passou no test entra em um cooldown randomico entre 2h~4h pra receber novamente
	return true
end
