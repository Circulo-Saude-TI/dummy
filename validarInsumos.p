
def temp-table  tt-teste no-undo
    field transacao as integer
    field serie as char
    field docorig as int
    field docsis as int
    field proc as char.

input from x:\spool\testelista.csv.

repeat transaction:
  create tt-teste. 
  import delimiter ';' tt-teste.
end.
input close.

for each tt-teste:
  find first docrecon where docrecon.cd-unidade            = 2900
  and docrecon.cd-unidade-prestadora = 2900
  and docrecon.cd-transacao          = tt-teste.transacao
  and docrecon.nr-serie-doc-original = tt-teste.serie
  and docrecon.nr-doc-original       = tt-teste.docorig
  and docrecon.nr-doc-sistema        = tt-teste.docsis
  no-lock no-error.


  if avail docrecon then do:
    for each moviproc where
              moviproc.cd-unidade            = docrecon.cd-unidade
    and       moviproc.cd-unidade-prestadora = docrecon.cd-unidade-prestadora
    and       moviproc.cd-transacao          = docrecon.cd-transacao         
    and       moviproc.nr-serie-doc-original = docrecon.nr-serie-doc-original
    and       moviproc.nr-doc-original       = docrecon.nr-doc-original      
    and       moviproc.nr-doc-sistema        = docrecon.nr-doc-sistema
    no-lock: 
      disp moviproc.in-liberado-pagto.
    end.
    for each mov-insu where
              mov-insu.cd-unidade            = docrecon.cd-unidade
    and       mov-insu.cd-unidade-prestadora = docrecon.cd-unidade-prestadora
    and       mov-insu.cd-transacao          = docrecon.cd-transacao         
    and       mov-insu.nr-serie-doc-original = docrecon.nr-serie-doc-original
    and       mov-insu.nr-doc-original       = docrecon.nr-doc-original      
    and       mov-insu.nr-doc-sistema        = docrecon.nr-doc-sistema
    no-lock: 
      disp mov-insu.in-liberado-pagto.
    end.
  end.

  

