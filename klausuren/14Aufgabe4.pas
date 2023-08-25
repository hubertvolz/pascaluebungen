


{$R+}
{$B+}

program binaerenBaumBauen(input, output);

  type
  tRefBinBaum = ^tBinBaum; 
  tBinBaum = record
                 info : integer;
                 links : tRefBinBaum;
                 rechts : tRefBinBaum
              end;
  
  tRefListe = ^tListe;
  tListe = record
              wert:integer;
              next:tRefListe
            end;

  var
  binBaum: tRefBinBaum;

  xAusgabe: boolean;

  procedure BBKnotenEinfuegen ( inZahl : integer;
    var ioRefWurzel : tRefBinBaum);
    { fuegt in den Suchbaum, auf dessen Wurzel ioRefWurzel
        zeigt, ein Blatt mit Wert inZahl an }
    var
        RefSohn,
        RefVater : tRefBinBaum;
        gefunden : boolean;
  begin
    RefSohn := ioRefWurzel;
    gefunden := false;
    while (RefSohn <> nil) and (not gefunden) do 
    begin
      if RefSohn^.info = inZahl then gefunden := true
      else 
      begin
        RefVater := RefSohn;
        if inZahl < RefSohn^.info then
          RefSohn := RefSohn^.links
        else
          RefSohn := RefSohn^.rechts
        end
    end; { while }
    if not gefunden then
    { neuen Knoten anlegen } 
    begin
      new (RefSohn);
      RefSohn^.info := inZahl; RefSohn^.links := nil; RefSohn^.rechts := nil;
    { neu angelegten Knoten einfuegen } 
    if ioRefWurzel = nil then
      { Baum war leer, neue Wurzel zurueckgeben }
      ioRefWurzel := RefSohn
    else
      if inZahl < RefVater^.info then
        { Sohn links anhaengen }
        RefVater^.links := RefSohn
      else
        { Sohn rechts anhaengen }
        RefVater^.rechts := RefSohn
      end
  end; { BBKnotenEinfuegen }


  

  procedure BBAufbauen (var outRefWurzel : tRefBinBaum); 
  { baut fuer eine Eingabe von integer-Zahlen <> 0 einen Suchbaum auf und gibt einen Zeiger auf dessen Wurzel
      in outRefWurzel zurueck }
    var
    Zahl : integer;
    
  begin
    { outRefWurzel mit leerem Baum initialisieren } outRefWurzel := nil;
    readln (Zahl);
    while Zahl <> 0 do
    begin
      BBKnotenEinfuegen (Zahl, outRefWurzel);
      readln (Zahl)
    end
  end; { BBAufbauen }
  
  function BBAusgeben(outRefWurzel : tRefBinBaum;  schritt: integer) : tRefBinBaum;
  begin
    if(outRefWurzel <> nil) then
    begin  
      writeln('Aktueller Knoten: ',outRefWurzel^.info, ' schritt: ', schritt);
      schritt := schritt +1;
      writeln('<- ', outRefWurzel^.info);
      BBAusgeben := BBAusgeben(outRefWurzel^.links, schritt);
      writeln('-> ', outRefWurzel^.info);
      BBAusgeben := BBAusgeben(outRefWurzel^.rechts, schritt);
    end;
  end;    
  
  procedure ListeAufbauen(var outRefAnfang : tRefListe); 
  { baut eine Liste aus einzulesenden integer-Zahlen auf, hängt vorne an. S. 172 }

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
    end; { while-Schleife } 
    //writeln('outRefAnfang: ', outRefAnfang^.wert);
    //while Zeiger <> nil do
    { wird gebraucht, um outRefAnfang auf das erste Element zu setzen }
    //begin
    //  writeln('Liste1: ', Zeiger^.wert);
    //  outRefAnfang := Zeiger;
    //  Zeiger := Zeiger^.next;      
    //end;
  end; { ListeAufbauen }


  function rek2(A: tRefBinBaum; z: integer) : boolean;
  begin
    if(A <> nil) then
    begin
      if (A^.info > z) then
        z := A^.info;
    end;
    { base case } 
    if (A^.links = nil) AND (A^.rechts = nil) then
      begin
        if (A^.info >= z)then
        begin
          writeln('base case reached: ' , A^.info, ' z: ', z);
          rek2 := true
        end
        else 
          rek2 := false
      end
    else
    begin
      writeln('here ', A^.info, ' rek2: ', rek2);
      if(A^.links <> nil) then
        rek2 := rek2(A^.links, z);
      if(A^.rechts <> nil) then
        rek2 := rek2(A^.rechts,z);
    end
  end;

  function rek3(A: tRefBinBaum; z: integer) : boolean;
  begin
    if (A <> nil) then
    begin
      if(A^.info > z) then
        z := A^.info;
      if(A^.links = nil) AND (A^.rechts = nil) then
      begin
        writeln('Blatt gefunden: ', A^.info, ' z: ', z);
        if(A^.info >= z) then
          rek3 := true
        else 
          rek3 := false
      end
      else
      begin
        writeln('Absteigen: ', A^.info, ' z: ' , z);
        rek3 := rek3(A^.links, z);
        rek3 := rek3(A^.rechts, z);
      end 
        
    end
  end;

begin
  writeln('wir bauen Baum');
  BBAufbauen(binBaum);
  xAusgabe := rek3(binBaum,0);
  writeln('Ausgabe: ', xAusgabe);

end.
