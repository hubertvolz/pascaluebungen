{$R+} 
{$B+} 

program ListenElemSuchen2Program(input, output);

	const
	XWERTE : array [1 ..5]  of integer = (1,2,3,4,5);

	type
	tRefListe = ^tListe; 
	tListe = record
							info : integer;
							next : tRefListe 
						end;

  var
  StartZeiger, HilfsZeiger, ErgebnisZeiger: tRefListe;
  i, suchZahl: integer;


	function ListenElemSuchen2 ( inRefAnfang : tRefListe;
							 inZahl : integer): tRefListe;
		{ bestimmt das erste Element in einer Liste, bei dem
			die info-Komponente gleich inZahl ist }
		var
		Zeiger : tRefListe;
		
	begin
		Zeiger := inRefAnfang; if Zeiger <> nil then
				{ Liste nicht leer }
		begin
			while (Zeiger^.next <> nil) and
			(Zeiger^.info <> inZahl) do Zeiger := Zeiger^.next;
			if Zeiger^.info <> inZahl then
			{ dann muss Zeiger^.next = nil gewesen sein,
									d.h. Zeiger zeigt auf das letzte Element.
									Da dessen info-Komponente <> inZahl ist,
									kommt inZahl nicht in der Liste vor. }
			Zeiger := nil 
		end;
		ListenElemSuchen2 := Zeiger 
	end; { ListenElemSuchen2 }


{Hauptprogramm}
begin
	
	StartZeiger := nil;
	writeln('wir bauen Liste auf aus XWERTE-array');
	for i := 1 to 5 do
	begin
		new(HilfsZeiger);
		writeln('Element: ', XWERTE[i]);
		HilfsZeiger^.info := XWERTE[i];
		HilfsZeiger^.next := StartZeiger;
		StartZeiger := HilfsZeiger;
	end;
	
	writeln('Bitte Zahl eingeben, die in der Liste gesucht werden soll: ');
	readln(suchZahl);
	
	ErgebnisZeiger := ListenElemSuchen2(StartZeiger,suchZahl);
	if(ErgebnisZeiger = nil) then
		writeln('Zahl nicht gefunden: ', suchZahl)
	else
		writeln('Ergebnis: ', ErgebnisZeiger^.info);
	end.

end.
