% ------------------------------
% GNU Prolog-kompatible Geschichte: Marina Raskova
% ------------------------------

% Startpunkt
start :-
    intro,
    play(1).

% Einführungstext
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
    ;   write_utf8('Ungültige Wahl. Bitte erneut versuchen.\n\n'),
        play(ID)
    ).

% Benutzer-Eingabe lesen (1 Zeichen)
read_choice(Char) :-
    get_char(Char),
    skip_line.  % restliche Zeile verwerfen (inkl. Enter)

% Rest der Eingabe verwerfen
skip_line :-
    get_char(C),
    ( C == '\n' -> true ; skip_line ).

% Auswahlmöglichkeiten anzeigen
show_choices([]).
show_choices([ID-Label-_|Rest]) :-
    write_utf8(ID), write(': '), write_utf8(Label), write('\n'),
    show_choices(Rest).

% Nächste Szene anhand der Eingabe finden
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
'Marina ist zu Hause. Es ist kein großes Haus, aber die Nachbarn sind sehr nett. Ihr Vater ist Opernsänger und ihre Mutter Lehrerin. Marina ist 7, allein zu Hause. Plötzlich klopft es. Durch den Türspion sieht sie ihre Mutter – traurig. Als sie öffnet, bricht die Mutter in Tränen aus: Der Vater ist bei einem Motorradunfall gestorben. Von nun an ist Geld knapp und Marina muss sich entscheiden:\n\n',
[
    a-'Trotz geringer Erfolgschancen Musikerin werden und Vaters Traum weiterleben?'-2,
    b-'Lieber Maschinenbau/Chemie studieren, um ein sicheres Einkommen zu haben?'-3
]).

scene(2,
'Marina verfolgt ihren Traum und muss sich für eine Nische entscheiden. Das Klavier berührt sie tief – aber soll sie ihrem Vater folgen oder ihren eigenen Weg gehen?\n\n',
[
    a-'Klavier spielen'-4,
    b-'Opernsängerin werden, wie ihr Vater'-5
]).

scene(3,
'Sie absolviert ihr Studium mit Bravour, unterstützt ihre Mutter und arbeitet in einer Farbfabrik. Dort lernt sie ihren Mann kennen. 1930 wird Tochter Tanya geboren. Doch die Fliegerei ruft – eine Entscheidung muss her:\n\n',
[
    a-'Ihre Ehe priorisieren'-7,
    b-'Die Karriere verfolgen'-6
]).

scene(4,
'Sie spielt Nacht für Nacht, doch es reicht kaum zum Überleben. Am Zeitungskiosk liest sie: "Deutschland greift das Mutterland an!" Sie denkt über Flucht nach – wie?\n\n',
[
    a-'Mit dem Schiff nach Amerika'-8,
    b-'Mit dem Flugzeug fliehen'-9,
    c-'Mit dem Auto über Sibirien fliehen'-10
]).

scene(5,
'Ihr Opernerfolg erfüllt sie – Vater wäre stolz. Doch die Fliegerei lockt. Ihr Mann ist dagegen. Musik oder Fliegen?\n\n',
[
    a-'Zurück zur Oper'-7,
    b-'Ihren neuen Traum verfolgen'-6
]).

scene(6,
'Ein Rekordflug steht bevor. Einige technische Ungereimtheiten bleiben. Flug verschieben oder wie geplant starten?\n\n',
[
    a-'Verschieben'-11,
    b-'Wie geplant weiter machen'-12
]).

scene(7,
'Ihr Mann wird zum Albtraum – Gewalt, Angst, Hoffnungslosigkeit. Eine Freundin hilft: Flucht nach Amerika. Welches Fluchtmittel?\n\n',
[
    a-'Schiff (Amerika)'-8,
    b-'Flugzeug (Amerika)'-9,
    c-'Auto (Sibirien)'-10
]).

scene(8,
'Die Schifffahrt ist zermürbend. Nachts ein japanisches Schiff – sie wird festgenommen: Kindesentführung. Beide werden zurückgeschickt.\n\n',
[
    a-'Ende'-end
]).

scene(9,
'Fliegt nach Amerika, übersteht Sturm. Beginnt neues Leben trotz Kaltem Krieg.\n\n',
[
    a-'Ende'-end
]).

scene(10,
'Sie fährt nach Sibirien, entdeckt Öl, wird reich und fliegt nach Moskau.\n\n',
[
    a-'Ende'-end
]).

scene(11,
'Verspätung schlägt fehl. Sie muss trotz Risiken starten.\n\n',
[
    a-'Flug fortsetzen'-12
]).

scene(12,
'Schlechtes Wetter. Alternative Route oder geplante?\n\n',
[
    a-'Alternative Route wählen'-13,
    b-'Geplante Route wählen'-14
]).

scene(13,
'Nach Umweg reicht der Treibstoff nicht. Ziel verfehlt.\n\n',
[
    a-'Weiter'-15
]).

scene(14,
'Vereisung zwingt sie zur Notlandung. Wohin?\n\n',
[
    a-'Weiter'-15
]).

scene(15,
'Absprungbefehl! Crew helfen oder abspringen?\n\n',
[
    a-'Springen'-16,
    b-'Helfen zu landen'-17
]).

scene(16,
'Springt in die Taiga, überlebt 10 Tage. Alle überleben. Heldin!\n\n',
[
    a-'Ende'-end
]).

scene(17,
'Landung nötig. Terrain wählen:\n\n',
[
    a-'Fluss'-18,
    b-'Wald'-19
]).

scene(18,
'Absturz im Fluss. Alle sterben.\n\n',
[
    a-'Ende'-end
]).

scene(19,
'Flugzeug bleibt in Baumkronen hängen. Marina findet Höhle. Betreten?\n\n',
[
    a-'Ja'-20,
    b-'Nein'-21
]).

scene(20,
'Höhle enthält Bärenjunges. Angriff. Marina stirbt.\n\n',
[
    a-'Ende'-end
]).

scene(21,
'Marina tötet Bär. Fleisch mitnehmen oder fliehen?\n\n',
[
    a-'Fleisch nehmen'-20,
    b-'Fliehen'-22
]).

scene(22,
'Sie flieht, findet kein Essen und verhungert.\n\n',
[
    a-'Ende'-end
]).
