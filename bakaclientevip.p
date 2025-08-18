{cpc/cpc-at0110c1.i}

/* ---------------------------------- definicao das variaveis auxiliares --- */
def    var c-versao              as char                               no-undo.
def    var lg-vip-aux            as log                                no-undo.
def    var tt-processados        as int                                no-undo.
def    var tt-atualizados        as int                                no-undo.
/* -------------------------------------------------- inicio do processo --- */
assign c-versao = "7.00.000"
       tt-processados = 0
       tt-atualizados = 0.

/* Processa todos os registros da desplaus para identificar VIPs */
for each desplaus no-lock
    where desplaus.descricao matches "*Cliente VIP*"                            
       or desplaus.descricao matches "*Cliente VIP"
       or desplaus.descricao matches "Cliente VIP*"
       or desplaus.descricao matches "Cliente VIP":

    assign tt-processados = tt-processados + 1.
    
    /* Busca o usuário correspondente */
    find first usuario where usuario.cd-modalidade = desplaus.cd-modalidade
                         and usuario.nr-ter-adesao = desplaus.nr-ter-adesao
                         and usuario.cd-usuario    = desplaus.cd-usuario
                             exclusive-lock no-error.
    
    if avail usuario
    then do:
        /* Se ainda não está marcado como VIP, marca agora */
        if usuario.log-11 <> yes
        then do:
            assign usuario.log-11 = yes
                   tt-atualizados = tt-atualizados + 1.
            
            message "Cliente VIP flagado:" skip
                    "Modalidade:" usuario.cd-modalidade skip
                    "Termo:" usuario.nr-ter-adesao skip 
                    "Usuário:" usuario.cd-usuario skip
                    "Nome:" usuario.nm-usuario
                view-as alert-box information title "Cliente Atualizado".
        end.
    end.
    else do:
        message "Usuário não encontrado para:" skip
                "Modalidade:" desplaus.cd-modalidade skip
                "Termo:" desplaus.nr-ter-adesao skip
                "Usuário:" desplaus.cd-usuario
            view-as alert-box warning title "ATENÇÃO".
    end.
end.

/* Relatório final */
message "Processamento concluído!" skip
        "Total processados:" tt-processados skip
        "Total atualizados:" tt-atualizados
    view-as alert-box information title "Resultado Final".