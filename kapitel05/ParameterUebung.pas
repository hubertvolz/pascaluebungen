

{$R+}
{$B+}

program ParameterUebung(input, output);

  var
  i : integer;
  ausgabe : integer;


function addiereZwei(i:integer):integer;
  var
  h : integer;
 
  begin
    h := 2 + i;
    addiereZwei := h;
  end;
  
  
  
  
begin

  i := 12;
  ausgabe := addiereZwei(i);
  writeln('ausgabe: ', ausgabe);
  writeln('i hat den Wert: ', i);
  
end.
