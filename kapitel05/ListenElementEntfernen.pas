{$R+} 
{$B+} 

program ListenElementEntfernen(input, output);

  type
    tRefListe = ^tListe; 
    tListe = record
                info : integer;
                next : tRefListe 
              end;

  
  var
  Anfang: tRefListe;  
  loescheZahl: integer;
  gefunden: boolean;
  
  procedure ListenElemEntfernen ( inZahl : integer; var ioRefAnfang : tRefListe; var outGefunden : boolean);
  { entfernt aus einer Liste mit Anfangszeiger ioRefAnfang das erste Element mit dem Wert inZahl. 
  * Bei erfolgreicher Entfernung wird outGefunden auf true gesetzt, sonst auf false }
    var
    Zeiger : tRefListe;
    gefunden : boolean;
    
      procedure Abhaengen (var ioZeig : tRefListe);
      { haengt das Element ab, auf das ioZeig zeigt }
        var
          HilfsZeig : tRefListe; { Hilfsvariable }
      begin
          HilfsZeig := ioZeig;
          ioZeig := ioZeig^.next;
          dispose (HilfsZeig)
      end; { Abhaengen }

    begin
      if ioRefAnfang = nil then
          { Sonderfall: Liste ist leer }
          gefunden := false
      else
        if ioRefAnfang^.info = inZahl then 
        begin
          { Sonderfall: erstes Element ist zu entfernen }
          Abhaengen (ioRefAnfang);
          gefunden := true
      end
      else
      begin { gesuchtes Element bestimmen }
        Zeiger := ioRefAnfang;
        gefunden := false;
        while (Zeiger^.next <> nil) and not gefunden do
          if Zeiger^.next^.info = inZahl then 
          begin
            Abhaengen (Zeiger^.next);
            gefunden := true
           { wurde das letzte Element entfernt, dann gilt jetzt Zeiger^.next = nil und die while-Schleife bricht ab }
          end
          else
            { Sonderfall: gesuchtes Element kommt nicht vor; wegen der Schleifenbedingung gilt hier stets Zeiger^.next <> nil }
            Zeiger := Zeiger^.next
            { es ist hier Zeiger <> nil und damit Zeiger^.next wohldefiniert } 
        end; { Listendurchlauf }
        
      outGefunden := gefunden 
    end; { ListenElemEntfernen }
  
  
  
  

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
  writeln('Liste Aufbauen');
  ListeAufbauen(Anfang);
  writeln('Liste ausgeben');
  ListeDurchlaufen(Anfang);
  writeln('Listenelement entfernen: bitte Zahl eingeben:');
  readln(loescheZahl);
  ListenElemEntfernen(loescheZahl,Anfang,gefunden);
  writeln('Liste erneut ausgeben');
  ListeDurchlaufen(Anfang);
end. 
