define variable d-novo-limite as date      no-undo.
define variable c-codigos      as character no-undo initial "40901793".
define variable i              as integer   no-undo.
define variable i-codigo       as integer   no-undo.
define variable i-alterados    as integer   no-undo.
define variable i-nao-achados  as integer   no-undo.
define variable i-ja-existentes as integer   no-undo.

define buffer b-valid-proced for valid_proced.

assign d-novo-limite = 12/31/5000.
 
output to "finda-validade-procedimentos.log".
 
do i = 1 to num-entries(c-codigos):
    i-codigo = integer(entry(i, c-codigos)).
 
    find first valid_proced exclusive-lock
         where valid_proced.cd_procedimento = i-codigo
           and valid_proced.dt_limite < d-novo-limite
         no-error.
 
    if available valid_proced then do:
        find first b-valid-proced no-lock
             where b-valid-proced.cd_procedimento = i-codigo
               and b-valid-proced.dt_limite = d-novo-limite
             no-error.

        if available b-valid-proced then do:
            i-ja-existentes = i-ja-existentes + 1.
        end.
        else do:
            assign valid_proced.dt_limite = d-novo-limite.
            i-alterados = i-alterados + 1.
        end.
    end.
    else
        i-nao-achados = i-nao-achados + 1.
end.
 
put unformatted
    "Alterados: " string(i-alterados) skip
    "Ja existentes: " string(i-ja-existentes) skip
    "Nao encontrados: " string(i-nao-achados) skip.
 
output close.
 
message "Processamento concluído com sucesso!" skip
        "Alterados: " i-alterados " / Já existentes: " i-ja-existentes " / Não encontrados: " i-nao-achados
    view-as alert-box information. 