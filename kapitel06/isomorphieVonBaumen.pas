{$R+}
{$B+}

program isomorphieVonBaumen(input, output);
{testet die Funktion check}
  var
  bestanden:boolean;

  type
  tRefBinBaum = ^tBinBaum;
  tBinBaum = record
               wert:integer;
               links:tRefBinBaum;
               rechts:tRefBinBaum
             end;

{----------- hier fügen Sie bitte Ihre Funktion ein --------------------------}
  function check(inBaumA:tRefBinBaum; inBaumB:tRefBinBaum):boolean;
  {entscheidet, ob zwei Bäume isomorph sind}

  begin
    check := true
  end;
{----------- hier endet Ihre Funktion ----------------------------------------}

  function pointerTo(inBaum:tRefBinBaum; inPos:integer):tRefBinBaum;
  {liefert einen Zeiger zum Knoten mit Position inPos in Levelorder}

  begin
    if inPos = 1 then
      pointerTo := inBaum
    else
      if inPos mod 2 = 0 then
        pointerTo := (pointerTo(inBaum, inPos div 2))^.links
      else
        pointerTo := (pointerTo(inBaum, inPos div 2))^.rechts;
  end;

  procedure add(var ioBaum:tRefBinBaum; inWert:integer; inPos:integer);
  {ergänzt einen Baum um einen Knoten an Position inPos in Levelorder}
    var
    papa:tRefBinBaum;

  begin
    if inPos = 1 then
    begin
      new(ioBaum);
      ioBaum^.wert := inWert;
      ioBaum^.links := nil;
      ioBaum^.rechts := nil
    end
    else
    begin
      papa := pointerTo(ioBaum, inPos div 2);
      if inPos mod 2 = 0 then
      begin
        new(papa^.links);
        papa^.links^.wert := inWert;
        papa^.links^.links := nil;
        papa^.links^.rechts := nil
      end
      else
      begin
        new(papa^.rechts);
        papa^.rechts^.wert := inWert;
        papa^.rechts^.links := nil;
        papa^.rechts^.rechts := nil
      end;
    end;
  end;

  function stringToBaum(inS:string):tRefBinBaum;
  {baut einen Baum aus einem String}
    var
    baum:tRefBinBaum;
    i:integer;
    c:char;
    r,pos:integer;

  begin
    baum := nil;
    i := 1;
    r := 0;
    pos := 1;
    while (i <= Length(inS)) do
    begin
      c := inS[i];
      if (c = 'n') then r := -1;
      if (c = '0') then r := r * 10;
      if (c = '1') then r := r * 10 + 1;
      if (c = '2') then r := r * 10 + 2;
      if (c = '3') then r := r * 10 + 3;
      if (c = '4') then r := r * 10 + 4;
      if (c = '5') then r := r * 10 + 5;
      if (c = '6') then r := r * 10 + 6;
      if (c = '7') then r := r * 10 + 7;
      if (c = '8') then r := r * 10 + 8;
      if (c = '9') then r := r * 10 + 9;
      if ((c = ',') or (c = ']')) then
      begin
      if r > 0 then
        begin
          add(baum,r,pos)
        end;
        pos := pos + 1;
        r := 0
      end;
      i := i + 1;
    end;
    stringToBaum := baum;
  end;

  function printTestDatum(inBaumA:string; inBaumB:string; inErwartet:boolean):boolean;
  {testet ein Testdatum und gibt das Ergebniss zurück}
    var
    ok:boolean;

  begin
    ok := (check(stringToBaum(inBaumA),stringToBaum(inBaumB)) = inErwartet);
    if (not ok) then
    begin
      write('Test (');
      write(inBaumA + ', ');
      write(inBaumB);
      write(') ist fehlgeschlagen. Die Funktion liefert ');
      write(check(stringToBaum(inBaumA),stringToBaum(inBaumB)));
      write(' und nicht ');
      writeln(inErwartet);
    end;
    printTestDatum := ok;
  end;

begin
  writeln('**** Funktion testen ****');
  bestanden := printTestDatum('[1]','[1]',true)
           AND printTestDatum('[]','[]',true)
           AND printTestDatum('[1]','[]',false)
           AND printTestDatum('[]','[1,2]',false)
           AND printTestDatum('[1]','[2]',false)
           AND printTestDatum('[1]','[1]',true)
           AND printTestDatum('[1]','[1,2]',false)
           AND printTestDatum('[1,2]','[1,2]',true)
           AND printTestDatum('[1,2]','[1,3]',false)
           AND printTestDatum('[1,2]','[1,nil,2]',true)
           AND printTestDatum('[1,2]','[2,2]',false)
           AND printTestDatum('[1,2,3]','[1,2,3]',true)
           AND printTestDatum('[1,2,3]','[1,2,4]',false)
           AND printTestDatum('[1,2,3]','[1,3,2]',true)
           AND printTestDatum('[1,2,3]','[1,2,2]',false)
           AND printTestDatum('[1,2,2]','[1,4,2]',false)
           AND printTestDatum('[1,nil,2,nil,nil,3,4]','[1,nil,2,nil,nil,3,4]',true)
           AND printTestDatum('[1,2,3,3,nil,3]','[1,2,4,3,nil,3]',false)
           AND printTestDatum('[1,2,4,3,nil,5]','[2,2,4,3,nil,5]',false)
           AND printTestDatum('[1,2,2,3,4,3,5]','[1,2,2,3,5,3,4]',true)
           AND printTestDatum('[1,2,2,3,4,3,5]','[1,2,2,3,4,5,3]',true)
           AND printTestDatum('[1,2,2,3,4,3,5]','[1,2,2,3,5,3,5]',false)
           AND printTestDatum('[1,2,9,nil,nil,4,5]','[1,9,2,4,5]',true)
           AND printTestDatum('[1,2,9,nil,nil,4,5]','[1,9,2,nil,nil,4,5]',false);
  if bestanden then
  begin
    writeln('Alle Tests erfolgreich!');
  end;
end.
