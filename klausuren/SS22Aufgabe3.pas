

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
  liste: tRefListe;
  schritt: integer;
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

  function x(A:tRefListe; B:tRefBinBaum; schritt:integer) : boolean;
  
  begin
    if A = nil then
      x:= true
    else 
    begin
      //writeln('A: ' , A^.wert, ' B: ', B^.info);
      x := false;
      if B = nil then
        x := false
      else
      begin
        if A^.wert = B^.info then
        begin
          writeln(' = A: ' , A^.wert, ' B: ', B^.info, ' schritt: ', schritt);
          x := x(A^.next, B^.links, schritt+1) OR x(A^.next, B^.rechts, schritt+1);
        end
        else
        begin
          writeln('!= A: ' , A^.wert, ' B: ', B^.info, ' schritt: ', schritt);
          x:= false;
        end
      end
      
    end
  end; 

  

begin
  writeln('wir bauen Baum');
  BBAufbauen(binBaum);
  writeln('wir bauen Liste (bitte in umgekehrter Reihenfolge eingeben');
  ListeAufbauen(liste);
  writeln('Liste erstes Element: ', liste^.wert);
  //writeln('wir geben Baum nun aus');
  schritt := 0;
  BBAusgeben(binBaum,schritt);
  writeln('----- wir rufen x auf ----');
  schritt := 0;
  xAusgabe := x(liste, binBaum, schritt);
  //xAusgabe := x(binBaum, 0, 'w');
  writeln('Ausgabe von x: ', xAusgabe);

end.
