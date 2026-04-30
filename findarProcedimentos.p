define variable d-novo-limite as date      no-undo.
define variable c-codigos      as character no-undo initial "40901793".
define variable i              as integer   no-undo.
define variable i-codigo       as integer   no-undo.
define variable i-alterados    as integer   no-undo.
define variable i-nao-achados  as integer   no-undo.
 
assign d-novo-limite = date(12, 31, 2025).
 
output to "finda-validade-procedimentos.log".
 
do i = 1 to num-entries(c-codigos):
    i-codigo = integer(entry(i, c-codigos)).
 
    find first valid_proced exclusive-lock
         where valid_proced.cd_procedimento = i-codigo
         no-error.
 
    if available valid_proced then do:
        if valid_proced.dt_limite <> d-novo-limite then do:
            assign valid_proced.dt_limite = d-novo-limite.
            i-alterados = i-alterados + 1.
        end.
    end.
    else
        i-nao-achados = i-nao-achados + 1.
end.
 
put unformatted
    "Alterados: " string(i-alterados) skip
    "Nao encontrados: " string(i-nao-achados) skip.
 
output close.
 
message "Processamento concluído com sucesso!" skip
        "Alterados: " i-alterados " / Não encontrados: " i-nao-achados
    view-as alert-box information. 