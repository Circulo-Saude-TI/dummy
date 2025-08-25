/* Exporta campos da PRESERV para CSV:
   - preserv.cd-prestador
   - preserv.cd-unidade
   - preserv.cd-situacao
   - preserv.nr-cgc-cpf
   - preserv.nm-prestador
*/

DEFINE BUFFER bPrest FOR preserv.

/* -param opcional: nome ou caminho do CSV */
DEFINE VARIABLE pcSaida  AS CHARACTER NO-UNDO.
IF NUM-ENTRIES(SESSION:PARAMETER) > 0 THEN
  pcSaida = ENTRY(1, SESSION:PARAMETER).

/* Monta caminho de saída */
DEFINE VARIABLE cOutFile AS CHARACTER NO-UNDO.
DEFINE VARIABLE cDir     AS CHARACTER NO-UNDO.
DEFINE VARIABLE cParam   AS CHARACTER NO-UNDO.
ASSIGN cParam = TRIM(pcSaida).

IF cParam = "" THEN
  cOutFile = "X:\spool\preserv_lista.csv".
ELSE IF INDEX(cParam, "\") = 0 AND INDEX(cParam, ":") = 0 THEN
  cOutFile = "X:\spool\" + cParam + (IF R-INDEX(cParam, ".") = 0 THEN ".csv" ELSE "").
ELSE
  cOutFile = cParam.

/* Cria diretório se necessário */
ASSIGN cDir = IF INDEX(cOutFile, "\") > 0
              THEN SUBSTRING(cOutFile, 1, R-INDEX(cOutFile, "\") - 1)
              ELSE "".
IF cDir <> "" THEN
  OS-COMMAND SILENT VALUE('IF NOT EXIST "' + cDir + '" MKDIR "' + cDir + '"').

/* Abre arquivo */
DEFINE VARIABLE lOk AS LOGICAL NO-UNDO.
DO ON ERROR UNDO, LEAVE:
  OUTPUT TO VALUE(cOutFile).
  lOk = TRUE.
END.
IF NOT lOk THEN DO:
  MESSAGE "Falha ao abrir arquivo de saída:" SKIP
          "Destino: " cOutFile
      VIEW-AS ALERT-BOX ERROR.
  RETURN.
END.

/* Cabeçalho */
PUT UNFORMATTED
  "CD-PRESTADOR;CD-UNIDADE;CD-SITUACAO;NR-CGC-CPF;NM-PRESTADO;DT-EXCLUSAO;" SKIP.

DEFINE VARIABLE cDoc AS CHARACTER NO-UNDO.

FOR EACH bPrest NO-LOCK:
  ASSIGN cDoc = IF bPrest.nr-cgc-cpf = ? THEN "" ELSE STRING(bPrest.nr-cgc-cpf).

  PUT UNFORMATTED
    STRING(bPrest.cd-prestador) ";" +
    STRING(bPrest.cd-unidade)   ";" +
    STRING(bPrest.cd-situacao)  ";" +
    cDoc                        ";" +
    bPrest.nm-prestador      ";" +
    STRING(bPrest.dt-exclusao) 
    SKIP.
END.

OUTPUT CLOSE.

MESSAGE "Exportado para: " cOutFile VIEW-AS ALERT-BOX INFO.