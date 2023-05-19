{$R+} 
{$B+} 

{ Programm zur Veranschaulichung von SortiertEinfuegen auf Seite 176-177 : Absteigend sortierten Listen}
program SortiertEinfuegenProgram(input, output);


	type
	tRefListe = ^tListe; 
	tListe = record
							info : integer;
							next : tRefListe 
						end;
						
	var
  Anfang: tRefListe;
  einfuegeZahl: integer;
  
  procedure ListeAufbauen(var outRefAnfang : tRefListe); 
  { baut eine Liste aus einzulesenden integer-Zahlen auf }

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
      Zeiger^.info := Zahl;
      Zeiger^.next := outRefAnfang;
      outRefAnfang := Zeiger;
      readln (Zahl)
    end { while-Schleife } 
  end; { ListeAufbauen }
  

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
			writeln('wir machen neue Liste');
			RefNeu^.next := ioRefAnfang;
			ioRefAnfang := RefNeu
		end
		else
			if ioRefAnfang^.info > inZahl then
			{ Sonderfall: Einfuegen am Listenanfang } 
			begin
				write('Einfuegen am Listenanfang: ', ioRefAnfang^.info);
				writeln(' wir wollen einfuegen: ' , inZahl);
				RefNeu^.next := ioRefAnfang;
				ioRefAnfang := RefNeu
			end
			else
			{ Einfuegeposition suchen } 
			begin
				gefunden := false;
				Zeiger := ioRefAnfang;
				while (Zeiger^.next <> nil) and40
				(not gefunden) do
					if Zeiger^.next^.info > inZahl then
						gefunden := true
					else
						Zeiger := Zeiger^.next;
				if gefunden then
				{ Normalfall: Einfuegen in die Liste } 
				begin
					write('Normalfall: ', ioRefAnfang^.info);
					writeln(' wir wollen einfuegen: ' , inZahl);
					RefNeu^.next := Zeiger^.next;
					Zeiger^.next := RefNeu
				end
				else
				{ Sonderfall: Anhaengen an das Listenende } 
				begin
					write('Anhaengen an das Listenende: ', ioRefAnfang^.info);
					writeln(' wir wollen einfuegen: ' , inZahl);
					Zeiger^.next := RefNeu;
					RefNeu^.next := nil end
				end
			end; { SortiertEinfuegen }

	procedure ListeDurchlaufen (inRefAnfang : tRefListe);
  { gibt die Werte der Listenelemente aus }

  var
    Zeiger : tRefListe;
  begin
    Zeiger := inRefAnfang;
    while Zeiger <> nil do
    begin
      writeln (Zeiger^.info);
      Zeiger := Zeiger^.next
    end
  end; { ListeDurchlaufen }

{Hauptprogramm}
begin
	
	
	Anfang := nil;
  writeln('Liste Aufbauen');
  ListeAufbauen(Anfang);
  	
	writeln('Die Liste vor der Bearbeitung');
	ListeDurchlaufen(Anfang);
	
	writeln('Bitte Zahl eingeben, die in die Liste eingefuegt werden soll: ');
	readln(einfuegeZahl);
	
	SortiertEinfuegen(einfuegeZahl,Anfang);
	
	writeln('Die Liste nach der Bearbeitung');
	ListeDurchlaufen(Anfang);


end.
