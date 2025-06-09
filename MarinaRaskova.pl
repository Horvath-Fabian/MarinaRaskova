% ------------------------------
% GNU Prolog-kompatible Geschichte: Marina Raskova
% ------------------------------

% Startpunkt
start :-
    intro,
    play(0).

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

scene(0,
'Das Flugzeug wird wie ein Gummiball in der Luft herum geworfen.Der Wind heult und die Blitze kreischen voller Wut.\nSeit dem Start wurde man dauer beschallt von den Triebwerken, doch ploetzlich hoert man sie gar nicht mehr.\nMarina blickt aus dem kleinen Fenster auf den Antrieb er steht still. Sie schliesst die Augen.\n\n', 
[
    a-'weiter'-1,
    x-'Beenden'-exit
]).

scene(1,
'Marina ist zu Hause. Es ist kein grosses Haus aber die Nachbarn sind sehr nett.\nIhr Vater ist Opernsaenger und ihre Mutter eine Lehrerin.Sie ist zur Zeit 7 Jahre alt und alleine zu Hause.\nPloetzlich klopft es an der Tuer.Durch den Tuerspion erkennt sie ihre Mutter.\nEtwas ist komisch... Sie schaut so traurig aus.Sie oeffnet die Tuer und ihre Mutter faellt ihr in die Arme: Ihr Vater sei tot.\nEr verstarb bei einem Motorradunfall.Trauer, Angst und Wut ueberstuerzen sie.\nNach diesem Tag wuerde ihr Leben nie so sein wie es einmal war.\nDas Geld wird knapp und sie muss sich entscheiden:\n\n',
[
    a-'Soll sie ihre Musikkarriere im Namen ihres Vaters trotz der niedrigen Erfolgschancen weiter verfolgen?'-2,
    b-'Oder soll sie Maschinenbau und Chemie studieren, damit sie ein sicheres Einkommen bekommt?'-3,
    x-'Beenden'-exit
]).

scene(2,
'Marina verfolgt ihren Traum und will ihrer Mutter unter die Arme greifen,daher muss sie sich fuer eine Nische entscheiden.\nDas Klavier ist fuer sie ein Instrument, dessen Schoenheit nicht in Worten wiedergegeben werden kann.\nFolgt sie den Fussstapfen ihres Vaters oder beschreitet sie ihren eigenen?\n\n',
[
    a-'Klavier spielen'-4,
    b-'Opernsaengerin werden, wie ihr Vater'-5,
    x-'Beenden'-exit
]).

scene(3,
'Sie absolviert ihr Studium mit Bravour und kann ihre Mutter stolz unterstuetzen.\nNach dem Studium faengt sie an in einer Farbfabrik zu arbeiten und lernt dort ihren Mann kennen.\nGemeinsam haben sie im Jahr 1930 ihre Tochter Tanya.\nDies ist jedoch nicht das Ende ihrer Karriere.\nIm Gegenteil, sie hat gerade erst angefangen, weiter geht es in der Fliegerei als Luftfahrtzeichnerin.\nIhre viele Arbeit verlangt sehr viel von ihrer Ehe, so viel dass sie sich entscheiden muss: er oder die Fliegerei?\n\n',
[
    a-'Ihre Ehe'-7,
    b-'Ihre Karriere'-6,
    x-'Beenden'-exit
]).

scene(4,
'Sie spielt Tag und Nacht.Kein Tag vergeht, an dem sie nicht alles gibt, jedoch reicht es nicht.\nJeden Abend spielt sie bis frueh in den Morgen in einer Bar, um ueber die Runden zu kommen.\n In der selben Bar lernte sie ihren Mann kennen, jedoch haben sie sich auseinander gelebt und wollen sich nun scheiden.\nEines fruehen Morgens auf dem Weg nach Hause kommt sie an einem Zeitungsstand vorbei.\nAlle Zeitungen haben die gleiche Ueberschrift: "Deutschland greift das Mutterland an!".\nIhre Fuesse werden schwach. Was tun? Was soll sie nur tun?\nDie Deutschen sind auf dem Vormarsch, bisher haben sie alles und jeden dem Erdboden gleich gemacht.\nEine Idee macht sich breit. Warum nicht nach Amerika ausreisen?\nWeg von dem Krieg, ab in das Land der Freiheit!\nDoch mit welchem Mittel soll sie nach Amerika reisen?\n\n',
[
    a-'Schiff'-8,
    b-'Flugzeug'-9,
    c-'Auto'-10,
    x-'Beenden'-exit
]).

scene(5,
'Die Oper macht sie reich.\nIhr Vater waere mehr als nur stolz auf sie.\nIn der Musikbranche traff sie auch ihren Mann.\nIm Jahr 1930 kommt ihre Tochter zur Welt.\nAlles ist so wie sie es immer wollte!\nDoch was jetzt? Was machen, wenn man alles machen kann?\nSie faengt ihre Fliegerausbildung an.\nIhr Mann unterstuetzt sie nicht.\nEr ist der Meinung, sie soll einfach zurueck in die Musik kommen und diesen Bloedsinn lassen.\nWill sie fuer immer Musik machen oder doch ihren neuen Traum weiterverfolgen?\nDas wuerde bedeuten, sich scheiden zu lassen?\n\n',
[
    a-'Zurueck zur Oper'-7,
    b-'Ihren neuen Traum verfolgen'-6,
    x-'Beenden'-exit
]).

scene(6,
'Nach ihrer Ausbildung bekommt sie die Moeglichkeit, an einem Langstreckenflug-Rekord teilzunehmen.\nEr soll den bisherigen Weltrekord des laengsten Fluges mit rein weiblicher Besatzung brechen und somit in die Geschichte eingehen.\nAm Vorabend wird alles noch einmal durchgecheckt.\nEs gibt zwar ein, zwei Ungereimtheiten, allerdings nichts Grobes.\nSollte man den Start und die Pressekonferenz verschieben oder sollte sie wie geplant fortfahren?\n\n',
[
    a-'Verschieben'-11,
    b-'Wie geplant weitermachen'-12,
    x-'Beenden'-exit
]).

scene(7,
'Mit der Zeit bemerkt sie, was fuer einen gigantischen Fehler sie mit ihrer Hochzeit begangen hat.\nSie wird von ihrem Mann nicht nur beschimpft, bespuckt und geschlagen.\nJeder Tag, den sie ueberlebt, ist sie dankbar.\nDoch sie sehnt sich nach einer besseren Zukunft fuer ihre Tochter.\nKeine Sekunde will sie mehr bei ihrem Mann ausharren muessen und um ihr Leben fuerchten.\nEine Freundin hilft ihr, die Flucht zu planen.\nEs soll nach Amerika gehen. Dort wuerden sie keiner Gefahr mehr ausgesetzt sein.\nWie sollen sie aus der UdSSR kommen?\n\n',
[
    a-'Schiff (Amerika)'-8,
    b-'Flugzeug (Amerika)'-9,
    c-'Auto (Sibirien)'-10,
    x-'Beenden'-exit
]).

scene(8,
'Sie flieht mit dem Schiff ueber den Pazifik.\nEs ist eine lange und zermuerbende Reise, doch die Freiheit erwartet sie und ihr Kind.\nEs ist dunkel. Marina kann nicht schlafen und steht daher an der Reling.\nSie hat keine Uhr, aber es muss circa 2 Uhr in der Frueh sein.\nDie See ist ruhig und am Horizont leuchtet ein Licht auf.\nEs scheint so friedlich, doch der Schein truegt.\nEs ist ein japanisches Schiff, sie kontrollieren alle Personen an Bord.\nFuer Marina wurde ein Haftbefehl ausgestellt.\nSie haette ihre eigene Tochter entfuehrt.\nGemeinsam mit ihrer Tochter wird sie nun mit dem Flugzeug nach Hause geschickt.\n\n',
[
    a-'End'-end,
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
'Sie starten mit einem mulmigen Gefuehl. Schon nach halbem Flug ueberrascht sie schlechtes Wetter und die Funkverbindung bricht ab.\nSollen sie versuchen, das Unwetter ueber eine Alternativroute zu umfliegen oder auf der geplanten Route bleiben?\n\n',
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
