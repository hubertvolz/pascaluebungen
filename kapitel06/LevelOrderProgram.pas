{$R+}
{$B+}

program levelOrderProgram(input, output);

  type
  tRefBinBaum = ^tBinBaum;
  tBinBaum = record
               wert:integer;
               li:tRefBinBaum;
               re:tRefBinBaum;
               next:tRefBinBaum
             end;

  var
  binBaum: tRefBinBaum;



  procedure setLevelOrder(inBaum:tRefBinBaum);

    var
    lauf :tRefBinBaum;
    listenEnde :tRefBinBaum;

  begin
    //hier muss was rein
    lauf := inBaum;
    listenEnde := inBaum;
    while (lauf <> nil) do
    begin
      writeln('setLevel: ', lauf^.wert);
      if (lauf^.li <> nil) then
      begin
        listenEnde^.next := lauf^.li;
        listenEnde := listenEnde^.next;
        writeln('li, listenEnde: ', listenEnde^.wert);
      end;
      if (lauf^.re <> nil) then
      begin
        listenEnde^.next := lauf^.re;
        listenEnde := listenEnde^.next;
        writeln('re, listenEnde: ', listenEnde^.wert);
      end;
      //hier fehlt was;
      lauf:= lauf^.next;
      
    end;
  end;

  procedure levelOrder(inBaum:tRefBinBaum);
  begin
    if (inBaum <> nil) then
    begin
      writeln(inBaum^.wert);
      //hier fehlt was;
      levelOrder(inBaum^.next);
    end
  end;
  
  procedure buildTree(var ioRefWurzel : tRefBinBaum);
    var
    knoten : tRefBinBaum;
    subKnoten: tRefBinBaum;
  begin
    new(ioRefWurzel);
    ioRefWurzel^.wert :=1;
    new(knoten);
    knoten^.wert :=2;
    ioRefWurzel^.li := knoten;
    new(subKnoten);
    subKnoten^.wert := 4;
    knoten^.li := subKnoten; 
    
    new(knoten);
    knoten^.wert := 3;
    ioRefWurzel^.re := knoten;
    new(subKnoten);
    subKnoten^.wert := 5;
    knoten^.li := subKnoten;
    new(subKnoten);
    subKnoten^.wert := 6;
    knoten^.re := subKnoten;
  end;

begin
  buildTree(binBaum);
  writeln('binBaum: ', binBaum^.wert);
  writeln('setLevel startet');
  setLevelOrder(binBaum);
  writeln('nun ausgabe: ');
  levelOrder(binBaum);

end.
