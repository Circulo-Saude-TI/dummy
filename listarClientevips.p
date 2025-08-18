{cpc/cpc-at0110c1.i}

def temp-table tt-vips no-undo
    field cd-modalidade as char format "x(30)" label "Modalidade" 
    field nr-ter-adesao as char format "x(30)" label "Termo"
    field cd-usuario    as char format "x(30)" label "Usuário"  
    field nm-usuario    as char format "x(30)" label "Nome" 
    index idx-principal cd-modalidade nr-ter-adesao cd-usuario.

def var c-arquivo as char no-undo.
def var c-caminho-destino as char no-undo.
def var tt-total as int no-undo.

/* Carrega os dados dos clientes VIP (baseado na mesma lógica do seu código) */
for each usuario no-lock where usuario.log-11 = yes:
    create tt-vips.
    assign tt-vips.cd-modalidade = string(usuario.cd-modalidade) 
           tt-vips.nr-ter-adesao = string(usuario.nr-ter-adesao)
           tt-vips.cd-usuario    = string(usuario.cd-usuario)
           tt-vips.nm-usuario    = string(usuario.nm-usuario)
           tt-total = tt-total + 1.
end.

/* Interface do menu */
def frame f-opcoes
    "Gerenciamento de Clientes VIP" at 10 skip(2)
    "Total de clientes VIP cadastrados:" tt-total skip(2)
    "Escolha uma opção:" skip
    "1 - Listar na tela" skip
    "2 - Exportar para CSV" skip
    "3 - Sair" skip(2)
    with centered title "Menu VIP".

def var i-opcao as int no-undo.

repeat:
    display tt-total with frame f-opcoes.
    update i-opcao label "Opção" with frame f-opcoes.
    
    case i-opcao:
        when 1 then do:
            /* Lista na tela */
            for each tt-vips:
                display tt-vips.cd-modalidade format "x(30)"
                        tt-vips.nr-ter-adesao format "x(30)"
                        tt-vips.cd-usuario format "x(30)"
                        tt-vips.nm-usuario format "x(30)".
            end.
            message "Pressione qualquer tecla para continuar..." view-as alert-box.
        end.
        
        when 2 then do:
            /* Exportar para CSV com caminho customizado */
            def frame f-destino
                "Digite o caminho completo para salvar o arquivo CSV:" skip
                "Exemplo: C:\temp\vips.csv" skip(2)
                with centered title "Destino do Arquivo".
            
            /* Valor padrão */
            assign c-caminho-destino = "C:\temp\clientes-vip-" + 
                                      string(today, "99999999") + ".csv".
            
            update c-caminho-destino label "Caminho do arquivo" 
                   with frame f-destino.
            
            /* Valida se o caminho termina com .csv */
            if not c-caminho-destino matches "*.csv" then
                assign c-caminho-destino = c-caminho-destino + ".csv".
            
            /* Exporta o arquivo */
            output to value(c-caminho-destino).
            
            if error-status:error then do:
                output close.
                message "Erro ao criar o arquivo!" skip
                        "Verifique se o caminho está correto e se você tem permissão de escrita."
                    view-as alert-box error title "ERRO".
            end.
            else do:
                /* Cabeçalho do CSV */
                put "Modalidade;Termo;Usuario;Nome;Data_Exportacao" skip.
                
                /* Dados dos VIPs */
                for each tt-vips:
                    put tt-vips.cd-modalidade ";"
                        tt-vips.nr-ter-adesao ";"
                        tt-vips.cd-usuario ";"   
                        tt-vips.nm-usuario ";"   
                        string(today, "99/99/9999") skip.
                end.
                
                output close.
                
                message "Arquivo exportado com sucesso!" skip
                        "Local:" c-caminho-destino skip
                        "Total de registros:" tt-total
                    view-as alert-box information title "Exportação Concluída".
            end.
        end.
        
        when 3 then leave.
        
        otherwise do:
            message "Opção inválida! Digite 1, 2 ou 3."
                view-as alert-box warning.
        end.
    end case.
end.

message "Programa finalizado." view-as alert-box information.