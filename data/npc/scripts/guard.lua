function onCreatureAppear(cid)
    return true
end

function onCreatureDisappear(cid)
    return true
end

function onCreatureSay(cid, type, msg)
        local msg = string.lower(msg)

        if (msgcontains(msg, "hi") or msgcontains(msg, "oi")) and getDistanceToCreature(cid) < 3 then
            selfSay(getLangString(cid, "The city gates are very strong, but if someone or something open them, we will be here to protect you.", "Os portões da cidade são bem fortes, porém se alguem ou alguma coisa os abrir, nós estaremos aqui para proteger você!"))
        elseif msgcontains(msg, "help") and getDistanceToCreature(cid) < 3 then
            selfSay(getLangString(cid, "I don't need help, I have help of the all city army.", "Eu não preciso de ajuda, eu já tenho ajuda de todo exercito dessa cidade."))
        end
        
        return false
end

function onThink()
    return true
end