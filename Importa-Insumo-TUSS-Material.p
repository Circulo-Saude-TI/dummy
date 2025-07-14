 
/* Insumos-TUSS */

DEF VAR tt-aux      AS INT.

/* --------------------------------------------------- */                          
DEF TEMP-TABLE tmp-tuss-medi
    FIELD cd-insumo             LIKE insumos.cd-insumo  
    field ds-insumo             like insumos.ds-insumo.
    
    //FIELD cd-anvisa             as char format "x(15)". 


/* --------------------------------------------------- */                          
input FROM v:/ABC/saude.csv.

repeat transaction:

    CREATE tmp-tuss-medi.
    import delimiter ';' tmp-tuss-medi.

end.
input close.

/* --------------------------------------------------- */                          
FOR EACH tmp-tuss-medi exclusive-lock:

    find insumos where insumos.cd-tipo-insumo   = 01
                   and insumos.cd-insumo        = tmp-tuss-medi.cd-insumo
                       no-lock no-error.
    IF   not avail insumos
    THEN do:
           find insumos where insumos.cd-tipo-insumo   = 05
                          and insumos.cd-insumo        = tmp-tuss-medi.cd-insumo
                              no-lock no-error.
           IF   not avail insumos
           then do: 
                  ASSIGN tt-aux = tt-aux + 1.
           
                  
                  
                  /* -------------------------------------------------- */
                  create insumos.
                  assign insumos.cd-tipo-insumo           = 01
                         insumos.cd-insumo                = tmp-tuss-medi.cd-insumo
                         
                         //insumos.cd-anvisa                = tmp-tuss-medi.cd-anvisa

                         insumos.ds-insumo                = tmp-tuss-medi.ds-insumo 
                         insumos.dat-inic-vigenc          = 01/01/1900
                         insumos.dat-fim-vigenc           = 12/31/9999
                         insumos.um-insumo                = "UN"
                         insumos.ds-sigla-um              = "UN"
                         insumos.nr-fator-conversao       = 1

                         insumos.int-1                    = 26       /*tabela*/
                         insumos.char-14                  = "29"     /*grupo monit*/

                         insumos.cd-userid                = "T-health" 
                         insumos.dt-atualizacao           = TODAY.
                    
                    
                END.          
          end.    
end.


/* --------------------------------------------------- */    
DISP tt-aux.
PAUSE.

/* --------------------------------------------------- */                          




/* --------------------------------------------------- */                          


  

  


 



/* --------------------------------------------------- */                          


  

  
