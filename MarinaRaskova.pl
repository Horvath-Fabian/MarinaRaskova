% ------------------------------
% GNU Prolog-kompatible Geschichte: Marina Raskova
% ------------------------------

% Startpunkt
start :-
    intro,
    play(1).

% Einfuehrungstext
intro :-
    write_utf8('Willkommen zu der Geschichte von Marina Raskova.\n'),
    write_utf8('Ihre Entscheidungen werden ihr Schicksal bestimmen.\n\n').

% Haupt-Spielmechanik
play(end) :-
    write_utf8('\n--- The End ---\n').

play(ID) :-
    scene(ID, Text, Choices),
    write_utf8(Text),
    show_choices(Choices),
    read_choice(UserChoice),
    ( next_scene(UserChoice, Choices, NextID) ->
        play(NextID)
    ;   write_utf8('Ungueltige Wahl. Bitte erneut versuchen.\n\n'),
        play(ID)
    ).

% Lies ein Zeichen (mit Enter-Bestaetigung, funktioniert ueberall)
read_choice(Char) :-
    get_char(C),
    skip_line,
    ( char_code(C, 27) -> Char = x ; Char = C ).

% Exit-Szene
play(exit) :-
    write_utf8('\n--- Du hast das Spiel verlassen. ---\n').

% Rest der Eingabe verwerfen
skip_line :-
    get_char(C),
    ( C == '\n' -> true ; skip_line ).

% Auswahlmoeglichkeiten anzeigen
show_choices([]).
show_choices([ID-Label-_|Rest]) :-
    write_utf8(ID), write(': '), write_utf8(Label), write('\n'),
    show_choices(Rest).

% Naechste Szene anhand der Eingabe finden
next_scene(Input, Choices, NextID) :-
    member(Input-_-NextID, Choices).

% UTF-8 sichere Ausgabe (Atom -> Codepoints -> put_code)
write_utf8(Text) :-
    atom(Text),
    atom_codes(Text, Codes),
    maplist(put_code, Codes).

% ---------------------------------------------
% Szenen (ID, Text, [ChoiceID-Label-NextID])
% ---------------------------------------------

scene(1,
'Marina ist zu Hause. Es ist kein grosses Haus, aber die Nachbarn sind sehr nett.\nIhr Vater ist Opernsaenger und ihre Mutter Lehrerin.\nMarina ist 7, allein zu Hause. Ploetzlich klopft es.\nDurch den Tuerpion sieht sie ihre Mutter - traurig.\nAls sie oeffnet, bricht die Mutter in Traenen aus: Der Vater ist bei einem Motorradunfall gestorben.\nVon nun an ist Geld knapp und Marina muss sich entscheiden:\n\n',
[
    a-'Trotz geringer Erfolgschancen Musikerin werden und Vaters Traum weiterleben?'-2,
    b-'Lieber Maschinenbau/Chemie studieren, um ein sicheres Einkommen zu haben?'-3,
    x-'Beenden'-exit
]).

scene(2,
'Marina verfolgt ihren Traum und muss sich fuer eine Nische entscheiden. Das Klavier beruehrt sie tief -\naber soll sie ihrem Vater folgen oder ihren eigenen Weg gehen?\n\n',
[
    a-'Klavier spielen'-4,
    b-'Opernsaengerin werden, wie ihr Vater'-5,
    x-'Beenden'-exit
]).

scene(3,
'Sie absolviert ihr Studium mit Bravour, unterstuetzt ihre Mutter und arbeitet in einer Farbfabrik.\nDort lernt sie ihren Mann kennen. 1930 wird Tochter Tanya geboren.\nDoch die Fliegerei ruft - eine Entscheidung muss her:\n\n',
[
    a-'Ihre Ehe priorisieren'-7,
    b-'Die Karriere verfolgen'-6,
    x-'Beenden'-exit
]).

scene(4,
'Sie spielt Nacht fuer Nacht, doch es reicht kaum zum Ueberleben.\nAm Zeitungskiosk liest sie: "Deutschland greift das Mutterland an!"\nSie denkt ueber Flucht nach - wie?\n\n',
[
    a-'Mit dem Schiff nach Amerika'-8,
    b-'Mit dem Flugzeug fliehen'-9,
    c-'Mit dem Auto ueber Sibirien fliehen'-10,
    x-'Beenden'-exit
]).

scene(5,
'\nMarina wird eine beruehmte Opernsaengerin. Sie verdient viel Geld, goennt sich eine Villa und den feinsten Schmuck.\nDoch trotz all des Reichtums fuehlt sich ihr Leben leer und eintoenig an.\nAuf der Suche nach einem neuen Sinn beginnt sie kurzerhand eine Ausbildung zur Pilotin - Geld spielt keine Rolle.\nIhr Mann jedoch versucht, sie von diesem riskanten Vorhaben abzuhalten.\nSoll sie sich scheiden lassen, um sich ganz auf die Fliegerei zu konzentrieren?\n\n',
[
    a-'Ja, sie laesst sich scheiden und widmet sich der Ausbildung'-6,
    b-'Nein, sie bleibt bei ihrem Mann'-7,
    x-'Beenden'-exit
]).

scene(6,
'Marina verlaesst ihren Mann, um sich voll und ganz auf ihre Karriere als Pilotin zu konzentrieren.\nNach intensiver Ausbildung steht sie kurz vor einem Rekordflug.\nDoch unmittelbar vor dem Start treten technische Probleme auf.\nSoll sie das Startdatum verschieben oder trotz der Unsicherheiten fliegen?\n\n',
[
    a-'Warten und Start verschieben'-11,
    b-'Trotzdem fliegen'-12,
    x-'Beenden'-exit
]).

scene(7,
'Nein, ihren Mann koennte sie nicht fuer die Fliegerei verlassen.\nSie beendet ihre Ausbildung und widmet sich der Familie.\nDoch nach und nach entpuppt sich ihr Mann als gewalttaetig. Immer wieder schlaegt er sie.\nSchliesslich bleibt ihr nur die Flucht aus der Sowjetunion. Doch wie?\nDas Schiff ist die billigste, aber langsamste Methode.\nDas Flugzeug ist teuer, aber sicherer.\nDas Auto ist riskant, da sie durch Kriegsgebiete fahren muesste.\n\n',
[
    a-'Mit dem Schiff fliehen (Amerika)'-8,
    b-'Mit dem Flugzeug fliehen (Amerika)'-9,
    c-'Mit dem Auto fliehen (Sibirien)'-10,
    x-'Beenden'-exit
]).

scene(8,
'\nMarina entscheidet sich fuer das Schiff. Es ist zwar langsam, aber sie hofft, mit dem gesparten Geld ein neues Leben beginnen zu koennen.\nDoch der Plan scheitert: Die Besatzung und sie werden von den Japanern gefangen genommen und mit dem Flugzeug ausser Landes gebracht.\nImmer wieder ruckelt das Flugzeug in Turbulenzen. Erst nach dem Krieg darf sie zurueck in die Sowjetunion, wo ihr Mann schon wartet.\nSie laesst sich nun doch scheiden, lebt aber den Rest ihres Lebens traumatisiert von Krieg und Gefangenschaft.\n\n',
[
    a-'Ende'-end,
    x-'Beenden'-exit
]).

scene(9,
'Marina entscheidet sich fuer das Flugzeug. Es ist teuer, aber sicherer.\nWWaehrend des Flugs geraet sie in heftige Turbulenzen, doch es ist nur ein Sturm.\nUeber dem Pazifik wird sie von amerikanischen Fliegern empfangen und sicher nach Amerika geleitet.\nDort baut sie sich ein neues Leben auf. Trotz der Herausforderungen des Kalten Krieges ist sie ueberzeugt, dass dieses Leben besser ist als das mit ihrem Mann.\n\n',
[
    a-'Ende'-end,
    x-'Beenden'-exit
]).

scene(10,
'Die Autofahrt ist gefaehrlich, immer wieder muss Marina Militaerposten passieren. Doch sie hat Glueck und erreicht Sibirien unversehrt. Bei der Suche nach Wasser stoesst sie auf eine Erdoelquelle, die sie reich macht. Fuer einen wichtigen Oelhandel fliegt sie mit ihrem Privatflugzeug nach Moskau. Trotz einiger Turbulenzen landet sie sicher und schliesst den groessten Erdoelhandel der sowjetischen Geschichte ab. Sie lebt fortan in Saus und Braus.\n\n',
[
    a-'Ende'-end,
    x-'Beenden'-exit
]).

scene(11,
'Marina versucht, den Start zu verschieben, doch so kurzfristig ist das nicht mehr moeglich. Sie und ihre Crew muessen das Risiko eingehen und wie geplant starten.\n\n',
[
    a-'Flug fortsetzen'-12,
    x-'Beenden'-exit
]).

scene(12,
'Sie starten mit einem mulmigen Gefuehl. Schon nach halbem Flug ueberrascht sie schlechtes Wetter und die Funkverbindung bricht ab. Sollen sie versuchen, das Unwetter ueber eine Alternativroute zu umfliegen oder auf der geplanten Route bleiben?\n\n',
[
    a-'Alternativroute waehlen'-13,
    b-'Geplante Route beibehalten'-14,
    x-'Beenden'-exit
]).

scene(13,
'Lieber den Umweg! Nach ueber zwei Stunden erreichen sie wieder den urspruenglichen Kurs, doch der Treibstoff wird knapp. Sie schaffen es nicht bis zum Ziel.\n\n',
[
    a-'Weiter'-15,
    x-'Beenden'-exit
]).

scene(14,
'Sie fliegen die geplante Route, doch Eis auf den Tragflaechen macht eine Notlandung unausweichlich.\n\n',
[
    a-'Weiter'-15,
    x-'Beenden'-exit
]).

scene(15,
'\nMarina funkt die Zentrale an. Diese befiehlt ihr, mit dem Fallschirm abzuspringen, da sie sich besonders ungeschuetzt in der Glasnase des Flugzeugs befindet.\nDer Rest der Besatzung soll notlanden.\nSoll Marina ihrer Crew bei der Notlandung helfen und den Befehl verweigern oder wie befohlen abspringen?\n\n',
[
    a-'Mit dem Fallschirm abspringen'-16,
    b-'Bei der Notlandung helfen'-17,
    x-'Beenden'-exit
]).

scene(16,
'\nMarina nimmt den Befehl an und springt mit dem Fallschirm aus dem Flugzeug.\nSie landet unversehrt in der endlosen Taiga.\nZehn Tage lang kaempft sie sich durch das Dickicht, bis sie endlich gerettet wird.\nZu ihrer Erleichterung erfaehrt sie, dass auch der Rest der Besatzung ueberlebt hat.\nTrotz aller Strapazen haben sie den Rekord gebrochen - Stalin zeichnet die drei Frauen persoenlich als *Heldinnen der Sowjetunion* aus.\n\n',
[
    a-'Ende'-end,
    x-'Beenden'-exit
]).

scene(17,
'\nMarina missachtet den Absprungbefehl und entscheidet sich, gemeinsam mit der Crew eine Landung zu versuchen.\nUnter ihnen erstrecken sich dichter Wald und ein breiter Fluss.\nWo sollen sie landen?\n\n',
[
    a-'Fluss'-18,
    b-'Wald'-19,
    x-'Beenden'-exit
]).

scene(18,
'\nSie steuern das Flugzeug auf den Fluss zu.\nBeim Aufprall zerbirst die Maschine - die gesamte Besatzung stirbt augenblicklich.\n\n',
[
    a-'Ende'-end,
    x-'Beenden'-exit
]).

scene(19,
'\nSie waehlen den Wald. Das Flugzeug bleibt in den Baumkronen haengen, nur die Nase bleibt unversehrt.\nMarina ueberlebt als Einzige, indem sie sich mit dem Fallschirm aus den Baumkronen auf den Waldboden schwingt.\nAllein kaempft sie sich durch die Taiga, immer auf der Suche nach Nahrung oder anderen Menschen.\nPloetzlich entdeckt sie eine dunkle Hoehle.\nSoll sie sie betreten?\n\n',
[
    a-'Ja'-20,
    b-'Nein'-21,
    x-'Beenden'-exit
]).

scene(20,
'\nAuf einmal ueberrascht sie ein Baerenjunges von hinten.\nMit einem kraeftigen Hieb toetet es sie auf der Stelle.\n\n',
[
    a-'Ende'-end,
    x-'Beenden'-exit
]).

scene(21,
'\nMarina durchsucht vorsichtig die Hoehle.\nPloetzlich steht ein riesiger Baer vor ihr.\nIm letzten Moment gelingt ihr ein gezielter Messerstich - sie besiegt das Tier.\nSie ekelt sich vor dem Blut und moechte am liebsten sofort verschwinden, doch das Fleisch koennte ihr das Leben retten.\nSoll sie das Fleisch mitnehmen oder schnell fliehen?\n\n',
[
    a-'Fleisch nehmen'-20,
    b-'Fliehen'-22,
    x-'Beenden'-exit
]).

scene(22,
'\nMarina verlaesst die Hoehle so schnell wie moeglich.\nDoch sie findet weder Beeren noch andere Nahrung und verhungert schliesslich in der Wildnis.\n\n',
[
    a-'Ende'-end,
    x-'Beenden'-exit
]).
