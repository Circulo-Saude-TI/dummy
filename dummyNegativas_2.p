def new global shared var v_cod_usuar_corren as char no-undo format "x(10)".

def var count-aux             as int             no-undo.

def temp-table tmp-motiv-negac
    field in-id              as int
    field cdn-motiv-negac    like motiv-negac.cdn-motiv-negac
    field des-motiv-negac    like motiv-negac.des-motiv-negac
    field num-livre-1        like motiv-negac.num-livre-1
    field cod-livre-1        like motiv-negac.cod-livre-1.

def var ch-output-path        as char            no-undo.
ch-output-path   = "X:\coimbra\".

run main.

procedure main private:
    run imp-negativas.
end procedure.

procedure imp-negativas private:
    define variable ch-holder as character       no-undo.
    define variable in-linha  as integer         no-undo.
    
    input from value (ch-output-path + "Tabela38.csv").
    repeat:
        import unformatted ch-holder.
        
        assign in-linha = in-linha + 1.
        
        if in-linha = 1 /* Primeira linha do arquivo csv est  em branco */
        then next.
        
        create tmp-motiv-negac.
        assign tmp-motiv-negac.in-id           = integer(entry(1, ch-holder, ","))
               tmp-motiv-negac.cdn-motiv-negac = in-linha
               tmp-motiv-negac.des-motiv-negac = entry(2, ch-holder, ",")
               tmp-motiv-negac.num-livre-1     = integer(entry(3, ch-holder, ","))
               tmp-motiv-negac.cod-livre-1     = entry(4, ch-holder, ",").
        
    end.
    input close.
    
    for each tmp-motiv-negac no-lock:
        
        find motiv-negac
            where motiv-negac.in-entidade     = "AT"
              and motiv-negac.cdn-motiv-negac = tmp-motiv-negac.cdn-motiv-negac
                  no-lock no-error.
        
        if not avail motiv-negac
        then do:
            count-aux = count-aux + 1.
            
            create motiv-negac.
            assign motiv-negac.cd-userid       = "v_cod_usuar_corren"
                   motiv-negac.dt-atualizacao  = today
                   motiv-negac.in-entidade     = "AT"
                   motiv-negac.cdn-motiv-negac = tmp-motiv-negac.cdn-motiv-negac
                   motiv-negac.des-motiv-negac = caps(tmp-motiv-negac.des-motiv-negac)
                   motiv-negac.num-livre-1     = tmp-motiv-negac.num-livre-1
                   motiv-negac.cod-livre-1     = tmp-motiv-negac.cod-livre-1.
        end.
        
        
    end.
    
/* --------------------------------------------------- */    
    message "Dados importados e cadastrados com sucesso!" skip
                                                                              "Total de registros inseridos:" count-aux
                                                                              view-as alert-box information.
/* --------------------------------------------------- */
    
end procedure.



