
{$R+} 
{$B+}

program Ausgabe(input, output);

  type
    tRefListe = ^tListe; 
    tListe = record
                info : integer;
                next : tRefListe 
              end;

  
  var
  Anfang: tRefListe;  
  
  
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
      Zeiger^.info := Zahl;
      Zeiger^.next := outRefAnfang;
      outRefAnfang := Zeiger;
      readln (Zahl)
    end { while-Schleife } 
  end; { ListeAufbauen }
  
  procedure ListeDurchlaufen (inRefAnfang : tRefListe);
  { gibt die Werte der Listenelemente aus }

  var
    Zeiger : tRefListe;
  begin
    Zeiger := inRefAnfang;
    while Zeiger <> nil do
    begin
      writeln (Zeiger^.info);
      Zeiger := Zeiger^.next
    end
  end; { ListeDurchlaufen }

begin
  Anfang := nil;
  ListeAufbauen(Anfang);
  ListeDurchlaufen(Anfang);
end.
