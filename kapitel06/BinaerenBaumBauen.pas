
{$R+}
{$B+}

program binaerenBaumBauen(input, output);

  type
  tRefBinBaum = ^tBinBaum; tBinBaum = record
                 info : integer;
                 links : tRefBinBaum;
                 rechts : tRefBinBaum
  end;

  var
  binBaum: tRefBinBaum;
  schritt: integer;

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
  
  function BBAusgeben(var outRefWurzel : tRefBinBaum;  var schritt: integer) : tRefBinBaum;
  begin
    if(outRefWurzel <> nil) then
    begin  
      writeln('Aktueller Knoten: ',outRefWurzel^.info, ' schritt: ', schritt);
      schritt := schritt +1;
      writeln('wir gehen links in Knoten: ', outRefWurzel^.info);
      BBAusgeben := BBAusgeben(outRefWurzel^.links, schritt);
      writeln('wir gehen rechts in Knoten: ', outRefWurzel^.info);
      BBAusgeben := BBAusgeben(outRefWurzel^.rechts, schritt);
    end;
  end;    
  

begin
  writeln('wir bauen Baum');
  BBAufbauen(binBaum);
  writeln('wir geben Baum nun aus');
  schritt := 0;
  BBAusgeben(binBaum,schritt);

end.
