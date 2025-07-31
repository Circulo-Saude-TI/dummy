DEFINE VARIABLE countDel AS INTEGER NO-UNDO.

DO TRANSACTION:
  FOR EACH motiv-negac
    WHERE motiv-negac.cd-userid = "teste ti"
          EXCLUSIVE-LOCK:
    
    DELETE motiv-negac.
    countDel = countDel + 1.
  END.
END.

MESSAGE "Registros de teste excluídos" SKIP
        "Total de registros excluídos: " countDel
VIEW-AS ALERT-BOX INFORMATION.
