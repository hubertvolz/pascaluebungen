{$R+} 
{$B+} 

{ Programm zur Veranschaulichung von SortiertEinfuegen auf Seite 176-177 }
program SortiertEinfuegenProgram(input, output);

	const
	XWERTE : array [1 ..5]  of integer = (10, 7,6,3,1);

	type
	tRefListe = ^tListe; 
	tListe = record
							info : integer;
							next : tRefListe 
						end;
						
	var
  StartZeiger, HilfsZeiger: tRefListe;
  i, einfuegeZahl: integer;

	procedure SortiertEinfuegen ( inZahl : integer;	var ioRefAnfang : tRefListe);
		{ fuegt ein neues Element fuer inZahl in eine sortierte Liste ein }
		var
		Zeiger,
		RefNeu : tRefListe;
		gefunden : boolean;
	
	begin
		{ neues Element erzeugen } 
		new(RefNeu);
		RefNeu^.info := inZahl;
		if ioRefAnfang = nil then
		{ Sonderfall: Liste ist leer } 
		begin
			RefNeu^.next := ioRefAnfang;
			ioRefAnfang := RefNeu
		end
		else
			if ioRefAnfang^.info > inZahl then
			{ Sonderfall: Einfuegen am Listenanfang } 
			begin
				RefNeu^.next := ioRefAnfang;
				ioRefAnfang := RefNeu
			end
			else
			{ Einfuegeposition suchen } 
			begin
				gefunden := false;
				Zeiger := ioRefAnfang;
				while (Zeiger^.next <> nil) and
				(not gefunden) do
					if Zeiger^.next^.info > inZahl then
						gefunden := true
					else
						Zeiger := Zeiger^.next;
				if gefunden then
				{ Normalfall: Einfuegen in die Liste } 
				begin
					RefNeu^.next := Zeiger^.next;
					Zeiger^.next := RefNeu
				end
				else
				{ Sonderfall: Anhaengen an das Listenende } 
				begin
					Zeiger^.next := RefNeu;
					RefNeu^.next := nil end
				end
			end; { SortiertEinfuegen }

	procedure printListe(inRefAnfang: tRefListe);
	var
	Zeiger : tRefListe;
	
	begin
		writeln('Ausgabe der Liste:');
		Zeiger := inRefAnfang;
		while (Zeiger^.next <> nil) do 
		begin
			writeln('element.info: ',Zeiger^.info);
			Zeiger := Zeiger^.next;
		end;
		writeln('element.info: ',Zeiger^.info);
	end;


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
	writeln('Die Liste vor der Bearbeitung');
	printListe(StartZeiger);
	
	writeln('Bitte Zahl eingeben, die in die Liste eingefuegt werden soll: ');
	readln(einfuegeZahl);
	
	SortiertEinfuegen(einfuegeZahl,StartZeiger);
	
	writeln('Die Liste nach der Bearbeitung');
	printListe(StartZeiger);


end.
