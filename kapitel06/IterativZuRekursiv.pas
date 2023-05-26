
{$R+}
{$B+}

program iterativZuRekursiv(input, output);

  type
  tRefListe = ^tListe;
  tListe = record
           wert : integer;
           next : tRefListe
         end;

  var
  listeA, listeB : tRefListe;
  gleichLang: boolean;

  function c(inA : tRefListe; inB : tRefListe) : boolean;
  begin
    while ((inA <> nil) and (inB <> nil)) do
    begin
      inA := inA^.next;
      inB := inB^.next
    end;
    c := ((inA = nil) and (inB = nil))
  end;
  
  function crek(inA:tRefListe;inB:tRefListe):boolean;
  begin
    if ((inA = nil) or (inB = nil)) then
      crek := ((inA = nil) and (inB = nil))
    else
      crek := crek (inA^.next , inB^.next)
  end;
  
  procedure ListeAufbauen(var outRefAnfang : tRefListe); 
  { baut eine Liste aus einzulesenden integer-Zahlen auf }

    var
    Zeiger : tRefListe;
    Zahl : integer;
    
    begin
      { zunaechst outRefAnfang auf nil setzen, da mit der leeren Liste gestartet wird }
    outRefAnfang := nil; 
    readln (Zahl);
    while Zahl <> 0 do 
    begin
      new (Zeiger);
      Zeiger^.wert := Zahl;
      Zeiger^.next := outRefAnfang;
      outRefAnfang := Zeiger;
      readln (Zahl)
    end { while-Schleife } 
  end; { ListeAufbauen }
  
  
begin

  writeln('wir bauen Liste A');
  ListeAufbauen(listeA);
  writeln('wir bauen Liste B');
  ListeAufbauen(listeB);
  
  writeln('sind beide listen gleich lang?');
  gleichLang := c(listeA, listeB);
  writeln('c: ', gleichLang);
  
  gleichLang := crek(listeA, listeB);
  writeln('crek: ', gleichLang);
  

end.  
  
