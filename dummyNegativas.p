def var tt-aux AS int .
def new global shared var v_cod_usuar_corren as char no-undo format "x(10)".
define buffer b-usuario  for usuario.
def TEMP-TABLE tmp-motiv-negac
  field numLivre         like motiv-negac.num-livre-1
  field desMotivNegac    like motiv-negac.des-motiv-negac
  field codLivre         like motiv-negac.cod-livre-1
  field cdnMotivNegac    like motiv-negac.cdn-motiv-negac.


INPUT FROM C:\Users\gabriel.oliveira\Documents\dummy\Tabela38.csv.

REPEAT TRANSACTION:
  CREATE tmp-motiv-negac.
  import delimiter ',' tmp-motiv-negac.
end.
input close.
//ate aqui a sintaxe ta ok 

/* --------------------------------------------------- */                          
for each tmp-motiv-negac exclusive-lock:
  ASSIGN tt-aux = tt-aux + 1.
  create motiv-negac.
    IF AVAIL motiv-negac THEN DO:
      ASSIGN 
        motiv-negac.in-entidade     = "AT"
        motiv-negac.cdn-motiv-negac = STRING(tmp-motiv-negac.numLivre, "9999")
        exclusive-lock.
    END.

    ASSIGN
      motiv-negac.cd-userid            = v_cod_usuar_corren
      motiv-negac.dt-atualizacao      = TODAY
      motiv-negac.des-motiv-negac     = CAPS(tmp-motiv-negac.desMotivNegac)
      motiv-negac.num-livre-1         = tmp-motiv-negac.numLivre
      motiv-negac.cod-livre-1         = CAPS(tmp-motiv-negac.desMotivNegac).
      
  END.
END.

/* --------------------------------------------------- */    
disp tt-aux.
MESSAGE "Dados importados e cadastrados com sucesso!" SKIP
        "Total de registros inseridos:" tt-aux
        VIEW-AS ALERT-BOX INFORMATION.
pause.


/* --------------------------------------------------- */



