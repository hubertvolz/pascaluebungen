
{$R+}
{$B+}

program tiefeDerKnoten(input, output);

  type
  tRefBinBaum = ^tBinBaum;
  tBinBaum = record
               wert:integer;
               li:tRefBinBaum;
               re:tRefBinBaum
             end;
  var
  binBaum : tRefBinBaum; 
  schritt: integer;          
  t: integer;
//----------------
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
      if RefSohn^.wert = inZahl then gefunden := true
      else 
      begin
        RefVater := RefSohn;
        if inZahl < RefSohn^.wert then
          RefSohn := RefSohn^.li
        else
          RefSohn := RefSohn^.re
        end
    end; { while }
    if not gefunden then
    { neuen Knoten anlegen } 
    begin
      new (RefSohn);
      RefSohn^.wert := inZahl; RefSohn^.li := nil; RefSohn^.re := nil;
    { neu angelegten Knoten einfuegen } 
    if ioRefWurzel = nil then
      { Baum war leer, neue Wurzel zurueckgeben }
      ioRefWurzel := RefSohn
    else
      if inZahl < RefVater^.wert then
        { Sohn links anhaengen }
        RefVater^.li := RefSohn
      else
        { Sohn rechts anhaengen }
        RefVater^.re := RefSohn
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
      writeln('Aktueller Knoten: ',outRefWurzel^.wert, ' schritt: ', schritt);
      schritt := schritt +1;
      writeln('wir gehen links in Knoten: ', outRefWurzel^.wert);
      BBAusgeben := BBAusgeben(outRefWurzel^.li, schritt);
      writeln('wir gehen rechts in Knoten: ', outRefWurzel^.wert);
      BBAusgeben := BBAusgeben(outRefWurzel^.re, schritt);
    end;
  end;  
//----------------             
             
             

  function tiefe(t:integer;A:tRefBinBaum):integer;
    
    var 
    x:integer;
    y:integer;
    
  begin 
    if (A = nil) then 
      tiefe := t //hier muss was rein
    else 
    begin
      A^.wert := t;
      x :=  tiefe(t+1, A^.li); //hier muss was rein
      y :=  tiefe(t+1, A^.re); //hier muss was rein
      if (x < y) then 
        tiefe := y
      else 
        tiefe := x;
    end
  end;

begin
  schritt :=0;
  t :=0;
  BBAufbauen(binBaum);
  BBAusgeben(binBaum, schritt);
  t := tiefe(t, binBaum);
  writeln('tiefe: ', t);
  BBAusgeben(binBaum, schritt);
end.
