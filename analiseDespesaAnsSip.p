def var num-item-despes-aux    as char                              no-undo.
def var num-tip-despes-aux     as char                              no-undo.
def var num-sub-tip-despes-aux as char                              no-undo.
def var num-causa-intrcao-aux  as char                              no-undo.
def var num-regim-intrcao-aux  as char                              no-undo.


output to "X:\spool\analiseDespesaAnsSip.csv" append.                                   
put unformat       
"Modulo"            ";"
"Transacao"         ";"                                           
"Tipo Servico"      ";"
"Tipo Insumo"       ";"                                           
"Servico"           ";"
"Despesa"           ";"                                           
"Tipo Despesa"      ";"                                           
"Sub Tipo Despesa"  ";"                                           
"Causa Internacao"  ";"                                           
"Regime Internacao" ";" skip.                                     
output close.

function converte-despesa         returns char (input num-item-despes-ans-par       as int):
    case num-item-despes-ans-par:
        when 0 
        then return "".
        when 1 
        then return "01. Consultas Medicas".
        when 2 
        then return "02. Outros Atendimentos Ambulatoriais".
        when 3 
        then return "03. Exames".
        when 4 
        then return "04. Terapias".
        when 5 
        then return "05. Internacoes".
        when 9
        then return "09. Demais Despesas Medico-Hospitalares".
        when 10 
        then return "10. Procedimentos Odontologicos".
        when 11
        then return "11. Consultas Medicas em Pronto Socorro".
        otherwise
             return string(num-item-despes-ans-par) + ". Invalido".
    end case.
end function.

function converte-tipo-despesa    returns char (input num-item-despes-ans-par       as int,
                                                input num-tip-despes-ans-par        as int):
    case num-item-despes-ans-par:
        when 2 
        then do:
               case num-tip-despes-ans-par:
                   when 0 
                   then return "".
                   when 1
                   then return "01. (Consultas/sessoes com Fisioterapia)".
                   when 2 
                   then return "02. (Consultas/sessoes com Fonoaudiologia)".
                   when 3 
                   then return "03. (Consultas/sessoes com Nutricao)".
                   when 4
                   then return "04. (Consultas/sessoes com Terapia Ocupacional)".
                   when 5 
                   then return "05. (Consultas/sessoes com Psicologia)".
                   when 6 
                   then return "06. (Outros)".
                   otherwise
                        return string(num-tip-despes-ans-par) + ". Invalido".
               end case.
             end.
        when 3 
        then do:
               case num-tip-despes-ans-par:
                   when 0 
                   then return "".
                   when 1 
                   then return "01. Ressonancia magnetica".
                   when 2 
                   then return "02. Tomografia computadorizada".
                   when 3 
                   then return "03. Proc diag cito cerv-vagin oncotic mulh 25-59 anos".
                   when 4 
                   then return "04. Densitometria ossea - qualquer segmento".
                   when 5 
                   then return "05. Ecodopplercardiograma transtoracico".
                   when 6 
                   then return "06. Broncoscopia com ou sem biopsia".
                   when 7 
                   then return "07. Endoscopia digestiva alta".
                   when 8 
                   then return "08. Colonoscopia".
                   when 9 
                   then return "09. Holter de 24 horas".
                   when 10
                   then return "10. Mamografia convencional e digital".
                   when 11
                   then return "11. Cintilografia miocardica".
                   when 12
                   then return "12. Cintilografia renal dinamica".
                   when 13
                   then return "13. Hemoglobina glicada".
                   when 14
                   then return "14. Pesq de sangue oculto nas fezes de 50 a 69 anos".
                   when 15
                   then return "15. Radiografia".
                   when 16
                   then return "16. Teste ergometrico".
                   when 17
                   then return "17. Ultrassonografia diagnostica de abdome total".
                   when 18
                   then return "18. Ultrassonografia diagnostica de abdome inferior".
                   when 19
                   then return "19. Ultrassonografia diagnostica de abdome superior".
                   when 20
                   then return "20. Ultrassonografia obstetrica morfologica".
                   when 21
                   then return "21. Outros".
                   otherwise
                        return string(num-tip-despes-ans-par) + ". Invalido".
               end case.
             end.
        when 4 
        then do:
               case num-tip-despes-ans-par:
                   when 0 
                   then return "".
                   when 1 
                   then return "01. Transfusao ambulatorial".
                   when 2 
                   then return "02. Quimioterapia sistemica".
                   when 3 
                   then return "03. Radioterapia megavoltagem".
                   when 4 
                   then return "04. Hemodialise aguda".
                   when 5 
                   then return "05. Hemodialise cronica".
                   when 6 
                   then return "06. Implante de dispositivo intrauterino - DIU".
                   when 7 
                   then return "07. Outros".
                   otherwise
                        return string(num-tip-despes-ans-par) + ". Invalido".
               end case.
             end.
        when 5 
        then do:
               case num-tip-despes-ans-par:
                   when 0 
                   then return "".
                   when 1 
                   then return "01. Clinica".
                   when 2 
                   then return "02. Cirurgica".
                   when 3 
                   then return "03. Obstetrica".
                   when 4 
                   then return "04. Pediatrica".
                   when 5 
                   then return "05. Psiquiatrica".
                   when 6 
                   then return "06. (Documento)".
                   otherwise
                        return string(num-tip-despes-ans-par) + ". Invalido".
               end case.
             end.
        when 10 
        then do:
               case num-tip-despes-ans-par:
                   when 0 
                   then return "".
                   when 1
                   then return "01. Consultas odontologicas iniciais".
                   when 2 
                   then return "02. Exames radiograficos".
                   when 31 
                   then return "31. Atividade educativa individual".
                   when 32
                   then return "32. Ativid topica profissional de fluor por hemi-arcada".
                   when 33
                   then return "33. Selante por elemento dentario (menores de 12 anos)".
                   when 4
                   then return "04. Rasp supra-gengival p/hemi-arcada(12 anos ou mais)".
                   when 5 
                   then return "05. Restaur em dentes deciduos p/elem (menores 12 anos)".
                   when 6 
                   then return "06. Restaur em dentes permanent p/elem(12 anos ou mais)".
                   when 7 
                   then return "07. Exodontias simples de perm (12 anos ou mais)".
                   when 8 
                   then return "08. Trat endodon concl dente perm p/elem(menor 12 anos)".
                   when 9 
                   then return "09. Trat endodon con dente perm p/elem(12 anos ou mais)".
                   when 10 
                   then return "10. Proteses odontologicas".
                   when 11 
                   then return "11. Proteses odont unit (Coroa Tot ou Restaur Met Fund)".
                   when 12
                   then return "12. Outros".
               end case.
             end.
        otherwise
             if num-tip-despes-ans-par = 0 
             then return "".
             else return string(num-tip-despes-ans-par) + ". Invalido".
    end case.

end function.

function converte-subtipo-despesa returns char (input num-item-despes-ans-par       as int,
                                                input num-tip-despes-ans-par        as int,
                                                input num-sub-tip-despes-ans-par    as int):

    if num-item-despes-ans-par = 5 
    then do:
           if num-tip-despes-ans-par = 2 /* Cirurgica */ 
           then do:
                  case num-sub-tip-despes-ans-par:
                      when 0 
                      then return "".
                      when 21 
                      then return "21. Cirurgia bariatrica".
                      when 22 
                      then return "22. Laqueadura tubaria".
                      when 23 
                      then return "23. Vasectomia".
                      when 24 
                      then return "24. Fratura de femur (60 anos ou mais)".
                      when 25 
                      then return "25. Revisao de artroplastia".
                      when 26 
                      then return "26. Implante de CDI (cardio desfibr implant)".
                      when 27
                      then return "27. Implantacao de marcapasso".
                  end case.
                end.
           else if num-tip-despes-ans-par = 4 /* Pediatrica */ 
           then do:
                  case num-sub-tip-despes-ans-par:
                      when 0 
                      then return "".
                      when 41
                      then return "41. Internacao 0-5 anos por doencas respirat".
                      when 42
                      then return "42. Internacao em UTI no periodo neonatal".
                  end case.
                end.
         end.
    
    if num-sub-tip-despes-ans-par = 0 
    then return "".
    else return string(num-sub-tip-despes-ans-par) + ". Invalido".

end function.

function converte-regime          returns char (input num-regim-intrcao-ans-par     as int):
    case num-regim-intrcao-ans-par:
        when 0 
        then return "".
        when 1
        then return "01. Hospitalar".
        when 2 
        then return "02. Hospital-dia".
        when 21
        then return "21. Hospital-dia para saude mental".
        when 3
        then return "03. Domiciliar".
        otherwise
             return string(num-regim-intrcao-ans-par) + ". Invalido".
    end case.
end function.

function converte-causa           returns char (input num-causa-intrcao-ans-par     as int):
    case num-causa-intrcao-ans-par:
        when 0 
        then return "".
        when 1 
        then return "001. Neoplasias".
        when 11 
        then return "011. Cancer de mama feminino".
        when 111 
        then return "111. Tratamento cirurgico de cancer de mama feminino".
        when 12 
        then return "012. Cancer de colo de utero".
        when 121
        then return "121. Tratamento cirurgico de cancer de colo de utero".
        when 13 
        then return "013. Cancer de colon e reto".
        when 131 
        then return "131. Tratamento cirurgico de cancer de colon e reto".
        when 14 
        then return "014. Cancer de prostata".
        when 141 
        then return "141. Tratamento cirurgico de cancer de prostata".
        when 2 
        then return "002. Diabetes mellitus".
        when 3 
        then return "003. Doencas do aparelho circulatorio".
        when 31 
        then return "031. Infarto agudo do miocardio".
        when 32 
        then return "032. Doencas hipertensivas".
        when 33 
        then return "033. Insuficiencia cardiaca congestiva".
        when 34 
        then return "034. Doencas cerebrovasculares".
        when 341 
        then return "341. Acidente vascular cerebral".
        when 4 
        then return "004. Doencas do aparelho respiratorio".
        when 41 
        then return "041. Doenca pulmonar obstrutiva cronica".
        when 5 
        then return "005. Causas externas".
    end case.
end function.

for each cadastro-despes-ans 
   where cadastro-despes-ans.cd-transacao     >= 0
     and cadastro-despes-ans.in-tipo-movimento = "P"
	 and cadastro-despes-ans.cd-tipo-insumo    = 0
	    no-lock,
	each ambproce 
   where ambproce.cd-procedimento-completo  = cadastro-despes-ans.cd-proc-insumo 
        no-lock:
		
	if not can-find(first trmodamb 
	                where trmodamb.cd-transacao      = cadastro-despes-ans.cd-transacao
                      and trmodamb.dt-limite         >= 01/01/2023 
                      and trmodamb.cd-esp-amb        = ambproce.cd-esp-amb
                      and trmodamb.cd-grupo-proc-amb = ambproce.cd-grupo-proc-amb 
                      and trmodamb.cd-proced         = ambproce.cd-procedimento   
                      and trmodamb.dv-procedimento   = ambproce.dv-procedimento)

    then next.
	
   
    assign num-item-despes-aux    = converte-despesa (cadastro-despes-ans.num-item-despes-ans)
           num-tip-despes-aux     = converte-tipo-despesa (cadastro-despes-ans.num-item-despes-ans,   
                                                           cadastro-despes-ans.num-tip-despes-ans)
           num-sub-tip-despes-aux = converte-subtipo-despesa(cadastro-despes-ans.num-item-despes-ans,   
                                                             cadastro-despes-ans.num-tip-despes-ans,    
                                                             cadastro-despes-ans.num-sub-tip-despes-ans)
           num-causa-intrcao-aux  = converte-regime (cadastro-despes-ans.num-regim-intrcao-ans) 
           num-regim-intrcao-aux  = converte-causa  (cadastro-despes-ans.num-causa-intrcao-ans).
    
	
      output to "X:\spool\analiseDespesaAnsSip.csv" append.                                   
      put unformat       
      cadastro-despes-ans.cd-modulo         ";"
      cadastro-despes-ans.cd-transacao      ";"                                          
      cadastro-despes-ans.in-tipo-movimento ";"
	  cadastro-despes-ans.cd-tipo-insumo    ";"
	  cadastro-despes-ans.cd-proc-insumo    ";"                                           
      num-item-despes-aux                   ";"                                           
      num-tip-despes-aux                    ";"                                           
      num-sub-tip-despes-aux                ";"                                           
      num-causa-intrcao-aux                 ";"                                           
      num-regim-intrcao-aux                 ";" skip.                                     
      output close.  	
     
 end.
 
 for each cadastro-despes-ans 
   where cadastro-despes-ans.cd-transacao     >= 0
     and cadastro-despes-ans.in-tipo-movimento = "I"
	    no-lock:
		
	if not can-find(first trmodtpi 
				    where trmodtpi.cd-transacao   = cadastro-despes-ans.cd-transacao
                      and trmodtpi.cd-tipo-insumo = cadastro-despes-ans.cd-tipo-insumo 
                      and trmodtpi.cd-insumo      = cadastro-despes-ans.cd-proc-insumo )

    then next.
	
   
    assign num-item-despes-aux    = converte-despesa (cadastro-despes-ans.num-item-despes-ans)
           num-tip-despes-aux     = converte-tipo-despesa (cadastro-despes-ans.num-item-despes-ans,   
                                                           cadastro-despes-ans.num-tip-despes-ans)
           num-sub-tip-despes-aux = converte-subtipo-despesa(cadastro-despes-ans.num-item-despes-ans,   
                                                             cadastro-despes-ans.num-tip-despes-ans,    
                                                             cadastro-despes-ans.num-sub-tip-despes-ans)
           num-causa-intrcao-aux  = converte-regime (cadastro-despes-ans.num-regim-intrcao-ans) 
           num-regim-intrcao-aux  = converte-causa  (cadastro-despes-ans.num-causa-intrcao-ans).
    
	
      output to "X:\spool\analiseDespesaAnsSip.csv" append.                                   
      put unformat       
      cadastro-despes-ans.cd-modulo         ";"
      cadastro-despes-ans.cd-transacao      ";"                                          
      cadastro-despes-ans.in-tipo-movimento ";"
	  cadastro-despes-ans.cd-tipo-insumo    ";"
	  cadastro-despes-ans.cd-proc-insumo    ";"                                           
      num-item-despes-aux                   ";"                                           
      num-tip-despes-aux                    ";"                                           
      num-sub-tip-despes-aux                ";"                                           
      num-causa-intrcao-aux                 ";"                                           
      num-regim-intrcao-aux                 ";" skip.                                     
      output close.  	
     
 end.
 
 // Modulo
 for each cadastro-despes-ans 
    where cadastro-despes-ans.cd-modulo > 0
	    no-lock:
		
	
   
    assign num-item-despes-aux    = converte-despesa (cadastro-despes-ans.num-item-despes-ans)
           num-tip-despes-aux     = converte-tipo-despesa (cadastro-despes-ans.num-item-despes-ans,   
                                                           cadastro-despes-ans.num-tip-despes-ans)
           num-sub-tip-despes-aux = converte-subtipo-despesa(cadastro-despes-ans.num-item-despes-ans,   
                                                             cadastro-despes-ans.num-tip-despes-ans,    
                                                             cadastro-despes-ans.num-sub-tip-despes-ans)
           num-causa-intrcao-aux  = converte-regime (cadastro-despes-ans.num-regim-intrcao-ans) 
           num-regim-intrcao-aux  = converte-causa  (cadastro-despes-ans.num-causa-intrcao-ans).
    
	
      output to "X:\spool\analiseDespesaAnsSip.csv" append.                                   
      put unformat       
      cadastro-despes-ans.cd-modulo         ";"
      cadastro-despes-ans.cd-transacao      ";"                                          
      cadastro-despes-ans.in-tipo-movimento ";"
	  cadastro-despes-ans.cd-tipo-insumo    ";"
	  cadastro-despes-ans.cd-proc-insumo    ";"                                           
      num-item-despes-aux                   ";"                                           
      num-tip-despes-aux                    ";"                                           
      num-sub-tip-despes-aux                ";"                                           
      num-causa-intrcao-aux                 ";"                                           
      num-regim-intrcao-aux                 ";" skip.                                     
      output close.  	
     
 end.
 

MESSAGE "Export concluído!"
    VIEW-AS ALERT-BOX INFO BUTTONS OK.