

program Check(input, output);

 var
 a: integer;
 b: integer;
 m: integer;
 d: integer;
 
 begin
 readln(a);
  readln(b);
  m := a mod b;
  d := a div b;
  writeln('m: ',m, ' d: ',d);
 end.
  
