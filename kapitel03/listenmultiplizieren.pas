{$R+}
{$B+}

program ListenMultiplizieren(input,output);

	const
	//XWERTE : array [1 ..5]  of integer = (5,4,3,2,2);
	//YWERTE : array [1 ..3]  of integer = (4,4,1);
	//ZWERTE : array [1 ..3]  of integer = (1,2,4);
	XWERTE : array [1 ..5]  of integer = (2,2,3,4,5);
	YWERTE : array [1 ..3]  of integer = (1,4,4);
	ZWERTE : array [1 ..3]  of integer = (4,2,1);
	

	type
	tRefListe = ^tListe;
	tListe = record
						 wert : integer;
						 next : tRefListe
					 end;

	var
	x,y,z,startx, starty, startz : tRefListe;
	i,fwert, gwert: integer;



	function c(inA : tRefListe; inB : tRefListe) : boolean;
	begin
		while ((inA <> nil) and (inB <> nil)) do
		begin
			inA := inA^.next;
			inB := inB^.next
		end;
		c := ((inA = nil) and (inB = nil))
	end;

	function m(inA : tRefListe; inB : tRefListe) : integer;
		var
		e:integer;
	begin
		e := 0;
		while (inA <> nil) do
		begin
			e := e + inA^.wert * inB^.wert;
			inA := inA^.next;
			inB := inB^.next
		end;
		m := e
	end;

	function f(inA : tRefListe; inB : tRefListe) : integer;
	begin
	  //writeln('in f');
		if c(inA,inB) then
			f := m(inA,inB)
		else
			f := 0
	end;
	
	begin
		writeln('laeuft erstmal');
		startx := nil;
		
		writeln('wir bauen x');
		for i :=1 to 5 do
		begin
			new(x);
			writeln(XWERTE[i]);
			x^.wert := XWERTE[i];
			x^.next := startx;
			startx := x;
		end;

		starty := nil;
		
		writeln('wir bauen y');
		for i :=1 to 3 do
		begin
			new(y);
			writeln(YWERTE[i]);
			y^.wert := YWERTE[i];
			y^.next := starty;
			starty := y;
		end;
		
		
		startz := nil;
		
		writeln('wir bauen z');
		for i :=1 to 3 do
		begin
			new(z);
			writeln(ZWERTE[i]);
			z^.wert := ZWERTE[i];
			z^.next := startz;
			startz := z;
		end;
		
		writeln('fertig mit Eingabe');
		fwert := f(x,y);
		writeln('f(x,y): ', fwert);
		gwert := f(y,z);
		writeln('f(y,z): ', gwert);
	end.
