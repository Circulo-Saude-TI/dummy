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
  
  DO TRANSACTION ON ERROR UNDO, LEAVE:
    CREATE motiv-negac.
    ASSIGN
      motiv-negac.cd-userid            = v_cod_usuar_corren
      motiv-negac.dt-atualizacao      = TODAY
      motiv-negac.in-entidade         = "AT"
      motiv-negac.cdn-motiv-negac     = STRING(tmp-motiv-negac.numLivre, "9999")
      motiv-negac.des-motiv-negac     = CAPS(tmp-motiv-negac.desMotivNegac)
      motiv-negac.num-livre-1         = tmp-motiv-negac.numLivre
      motiv-negac.cod-livre-1         = CAPS(tmp-motiv-negac.desMotivNegac).
      
    IF ERROR-STATUS:ERROR THEN DO:
      MESSAGE "Erro ao criar registro:" SKIP
              "Linha:" tt-aux SKIP
              "Erro:" ERROR-STATUS:GET-MESSAGE(1) VIEW-AS ALERT-BOX ERROR.
      UNDO, LEAVE.
    END.
  END.
END.

/* --------------------------------------------------- */    
disp tt-aux.
MESSAGE "Dados importados e cadastrados com sucesso!" SKIP
        "Total de registros inseridos:" tt-aux
        VIEW-AS ALERT-BOX INFORMATION.
pause.


/* --------------------------------------------------- */



