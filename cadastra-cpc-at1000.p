/*----------------------------------------------------------------------------*/
/*   Programa .....: cadastra-cpc-at1000.p                                    */
/*   Data .........: 14/08/2025                                               */
/*   Descricao ....: Tela de cadastro e carga automatica de procedimentos.    */
/*   Notas ........: Deve ser salvo na pasta 'dep' para ser uma utilidade.    */
/*   Autor ........: Gabriel Coimbra                                          */
/*----------------------------------------------------------------------------*/

/* ------------------------------------------------------------------------- */
/*  NOTA: A tabela 'procedimentos' deve ser criada previamente no Data Dictionary */
/*  com os seguintes campos:                                                 */
/*      - cd-esp-amb        (like procguia.cd-esp-amb)                        */
/*      - cd-grupo-proc-amb (like procguia.cd-grupo-proc-amb)                 */
/*      - cd-procedimento   (like procguia.cd-procedimento)                   */
/*      - dv-procedimento   (like procguia.dv-procedimento)                   */
/* ------------------------------------------------------------------------- */

/* Definiá∆o da tabela tempor†ria */
DEFINE TEMP-TABLE procedimentos NO-UNDO
    FIELD cd-esp-amb        AS INTEGER
    FIELD cd-grupo-proc-amb AS INTEGER  
    FIELD cd-procedimento   AS INTEGER
    FIELD dv-procedimento   AS INTEGER
    INDEX idx1 IS PRIMARY UNIQUE cd-esp-amb cd-grupo-proc-amb cd-procedimento dv-procedimento.

/* Vari†veis para entrada de dados */
DEFINE VARIABLE v-cd-esp-amb        AS INTEGER NO-UNDO.
DEFINE VARIABLE v-cd-grupo-proc-amb AS INTEGER NO-UNDO.
DEFINE VARIABLE v-cd-procedimento   AS INTEGER NO-UNDO.
DEFINE VARIABLE v-dv-procedimento   AS INTEGER NO-UNDO.

/* Frame principal */
DEFINE FRAME f-main
       v-cd-esp-amb        LABEL "Especialidade"
       v-cd-grupo-proc-amb LABEL "Grupo Proc."
       v-cd-procedimento   LABEL "Procedimento"
       v-dv-procedimento   LABEL "D°gito Verif."
       WITH SIDE-LABELS ROW 3.

/* ------------------------------------------------------------------------- */
/* BLOCO PRINCIPAL */
MAIN-BLOCK:
DO ON ENDKEY UNDO, LEAVE:
    ENABLE ALL WITH FRAME f-main.

    MESSAGE 
        "F1 = Incluir" SKIP
        "F2 = Alterar" SKIP
        "F3 = Excluir" SKIP
        "ESC = Sair"
        VIEW-AS ALERT-BOX.

    REPEAT:
        PROMPT-FOR v-cd-esp-amb
                   v-cd-grupo-proc-amb
                   v-cd-procedimento
                   v-dv-procedimento
                   WITH FRAME f-main.

        CASE LASTKEY:
            WHEN KEYCODE("F1") THEN RUN incluir-registro.
            WHEN KEYCODE("F2") THEN RUN alterar-registro.
            WHEN KEYCODE("F3") THEN RUN excluir-registro.
            WHEN KEYCODE("ESC") THEN LEAVE.
            OTHERWISE MESSAGE "Tecla inv†lida. Use F1, F2, F3, F4 ou ESC.".
        END CASE.
    END.
END.

/* ------------------------------------------------------------------------- */
/* INCLUIR REGISTRO */
PROCEDURE incluir-registro:
    FIND FIRST procedimentos
         WHERE procedimentos.cd-esp-amb        = v-cd-esp-amb
           AND procedimentos.cd-grupo-proc-amb = v-cd-grupo-proc-amb
           AND procedimentos.cd-procedimento   = v-cd-procedimento
           AND procedimentos.dv-procedimento   = v-dv-procedimento
         NO-LOCK NO-ERROR.

    IF AVAILABLE procedimentos THEN DO:
        MESSAGE "Registro j† existe!" VIEW-AS ALERT-BOX ERROR.
        RETURN.
    END.

    CREATE procedimentos.
    ASSIGN
        procedimentos.cd-esp-amb        = v-cd-esp-amb
        procedimentos.cd-grupo-proc-amb = v-cd-grupo-proc-amb
        procedimentos.cd-procedimento   = v-cd-procedimento
        procedimentos.dv-procedimento   = v-dv-procedimento.

    MESSAGE "Registro inclu°do com sucesso!" VIEW-AS ALERT-BOX INFO.
END.

/* ------------------------------------------------------------------------- */
/* ALTERAR REGISTRO */
PROCEDURE alterar-registro:
    FIND FIRST procedimentos
         WHERE procedimentos.cd-esp-amb        = v-cd-esp-amb
           AND procedimentos.cd-grupo-proc-amb = v-cd-grupo-proc-amb
           AND procedimentos.cd-procedimento   = v-cd-procedimento
           AND procedimentos.dv-procedimento   = v-dv-procedimento
         EXCLUSIVE-LOCK NO-ERROR.

    IF NOT AVAILABLE procedimentos THEN DO:
        MESSAGE "Registro n∆o encontrado para alteraá∆o." VIEW-AS ALERT-BOX ERROR.
        RETURN.
    END.

    UPDATE v-cd-esp-amb
           v-cd-grupo-proc-amb
           v-cd-procedimento
           v-dv-procedimento
           WITH FRAME f-main.

    ASSIGN
        procedimentos.cd-esp-amb        = v-cd-esp-amb
        procedimentos.cd-grupo-proc-amb = v-cd-grupo-proc-amb
        procedimentos.cd-procedimento   = v-cd-procedimento
        procedimentos.dv-procedimento   = v-dv-procedimento.

    MESSAGE "Registro alterado com sucesso!" VIEW-AS ALERT-BOX INFO.
END.

/* ------------------------------------------------------------------------- */
/* EXCLUIR REGISTRO */
PROCEDURE excluir-registro:
    FIND FIRST procedimentos
         WHERE procedimentos.cd-esp-amb        = v-cd-esp-amb
           AND procedimentos.cd-grupo-proc-amb = v-cd-grupo-proc-amb
           AND procedimentos.cd-procedimento   = v-cd-procedimento
           AND procedimentos.dv-procedimento   = v-dv-procedimento
         EXCLUSIVE-LOCK NO-ERROR.

    IF AVAILABLE procedimentos THEN DO:
        DELETE procedimentos.
        MESSAGE "Registro exclu°do com sucesso!" VIEW-AS ALERT-BOX INFO.
    END.
    ELSE
        MESSAGE "Registro n∆o encontrado para exclus∆o." VIEW-AS ALERT-BOX ERROR.
END.

