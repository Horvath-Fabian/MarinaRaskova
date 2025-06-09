:- dynamic visited/1.

start :- 
    retractall(visited(_)),
    intro,
    play(1).

intro :-
    write('Willkommen zu der Geschichte von Marina Raskova.'), nl,
    write('Ihre Entscheidungen werden ihr Schicksal bestimmen'), nl, nl.

play(ID) :-
    scene(ID, Text, Choices),
    \+ visited(ID), asserta(visited(ID)),
    write(Text), nl, nl,
    show_choices(Choices),
    read(Choice),
    next_scene(Choice, Choices, NextID),
    play(NextID).

play(end) :-
    write('--- The End ---'), nl.

show_choices([]).
show_choices([ChoiceID-Label-_ | Rest]) :-
    write(ChoiceID), write(': '), write(Label), nl,
    show_choices(Rest).

next_scene(ChoiceID, Choices, NextID) :-
    member(ChoiceID-_-NextID, Choices).

% --- Scenes ---
scene(1, 'Das Flugzeug wird wie ein Gummiball in der Luft herum geworfen. Der Wind heult und die Wolken kreischen. Seit dem Start wurde man dauer beschallt von den Triebwerken, doch plötzlich hört man sie gar nicht mehr. Marina blickt aus dem kleinen Fenster auf den Antrieb er steht still. Sie schließt die Augen.')

scene(1,
'Marina ist zu Hause. Es ist kein großes Haus aber die Nachbarn sind sehr nett. Ihr Vater ist Opernsänger und ihre Mutter eine Lehrerin. Sie ist zur Zeit 7 Jahre alt und alleine zu Hause. Plötzlich klopft es an der Tür. Durch den Türspion erkennt sie ihre Mutter. Etwas ist komisch... Sie schaut so traurig aus. Sie öffnet die Tür und ihre Mutter fällt ihn in die Arme ihr Vater sei tod. Er verstarb bei einem Motorradunfall. Trauer, Angst und Wut überstürmen sie. Nach diesem Tag würde ihr Leben nie so sein wie es einmal war. Das Geld wird knapp und sie muss sich entscheiden:',
[
    a-'Soll sie ihre Musikkarriere im Namen ihres Vaters trotz der niedrigen Erfolgschancen weiter verfolgen?'-2,
    b-'Oder soll sie Maschinenbau und Chemie studieren, damit sie ein sicheres Einkommen bekommt?'-3
]).

scene(2,
'Marina verfolgt ihren Traum und will ihre Mutter unter die Arme greifen, daher muss sie sich für eine Nische entscheiden. Das Klavier ist für sie ein Instrument, dessen Schönheit nicht in Worten wiedergeben werden kann. Folgt sie in die Fußspuren ihres Vaters oder beschreitet sie ihren eigenen?',
[
    a-'Klavier spielen'-4,
    b-'Opernsängerin werden, wie ihr Vater'-5
]).

scene(3,
'Sie absolviert ihr Studium mit Bravur und kann ihre Mutter stolz unterstützen. Nach dem Studium fängt sie an in einer Farbfabrik zu arbeiten und lernt dort ihren Mann kennen. Gemeinsam haben sie im Jahr 1930 ihre Tochter Tanya. Dies ist jedoch nicht das Ende ihrer Karriere. Im Gegenteil sie hat gerade erst angefangen, weiter geht es in der Fliegerei als Luftfahrtzeichnerin. Ihre viele Arbeit verlangt sehr viel von ihrer Ehe, so viel dass sie sich entscheiden muss er oder die Fliegerei',
[
    a-'Ihre Ehe'-7,
    b-'Ihre Karriere'-6
]).

scene(4,
'Sie spielt Tag und Nacht. Kein Tag vergeht in der sie nicht alles gibt, jedoch reicht es nicht. Jeden Abend spielt sie bis früh in den Morgen in einer Bar um über die Runden zu kommen. Eines frühen Morgens auf dem Weg nach Hause kommt sie an einem Zeitungsstand vorbei. Alle Zeitungen haben die gleiche Überschrift "Deutschland greift das Mutterland an!". Ihre Füße werden schwach. Was tun? Was soll sie nur tun? Die Deutschen sind auf dem Vormarsch bisher haben sie alles und jeden dem Erdboden gleich gemacht. Eine Idee macht sich breit. Warum nicht nach Amerika ausreisen? Weg von dem Krieg ab in das Land der Freiheit! Doch mit welchem Mittel soll sie nach Amerika reisen?',
[
    a-'Schiff'-8,
    b-'Flugzeug'-9,
    c-'Auto'-10
]).

scene(5,
'Die Oper macht sie reich. Ihr Vater wäre mehr als nur stolz auf sie. In der Musikbranche traff sie auch ihren Mann. Im Jahr 1930 kommt ihre Tochter zu Welt. Alles ist so wie sie es immer wollte! Doch was jetzt? Was machen, wenn man alles machen kann? Sie fängt ihre Fliegerausbildung an. Ihr Mann unterstützt sie nicht. Er ist der Meinung sie soll einfach zurück in die Musik kommen und diesen Blödsinn lassen. Will sie für immer Musik machen oder doch ihren neuen Traum weiterverfolgen, dass würde bedeuten sich scheiden zu lassen?',
[
    a-'Zurück zur Oper'-7,
    b-'Ihren neuen Traum verfolgen'-6
]).

scene(6,
'Nach ihrer Ausbildung bekommt sie die Möglichkeit an einem Langstreckenflug Rekord teilzuhaben. Er soll den bisherigen Weltrekord des längsten Fluges mit rein weiblicher Besatzung brechen und somit in die Geschichte eingehen. Am Vorabend wird alles nocheinmal durchgecheckt. Es gibt zwar ein zwei ungereimtheiten, allerdings nichts grobes sollten man den Start und die Pressekonferenz verschieben oder sollte sie wie geplant fortfahren?',
[
    a-'Verschieben'-11,
    b-'Wie geplant weiter machen'-12
]).

scene(7,
'Mit der Zeit bemerkt sie was für einen gigantischen Fehler sie begangen hat mit ihrer Hochzeit. Sie wird von ihrem Mann nicht nur beschimpft, bespuckt und geschlagen. Jeder Tag den sie überlebt ist sie dankbar. Doch sie sehnt sich eine besser Zukunft für ihre Tochter. Keine Sekunde will sie mehr bei ihrem Mann ausharren müssen und um ihr Leben fürchten. Eine Freudin hilft ihr die Flucht zu planen. Es soll nach Amerika gehen. Dort würden sie keiner Gefahr mehr ausgesetzt sein. Wie sollen sie aus der UDSSR kommen?',
[
    a-'Schiff (Amerika)'-8,
    b-'Flugzeug (Amerika)'-9,
    c-'Auto (Siberien)'-10
]).

scene(8,
'Sie flieht mit dem Schiff über den Pazifik. Es ist eine lange und zermürbende Reise, doch die Freiheit erwartet sie und ihr Kind. Es ist dunkel. Marina kann nicht schlafen und steht daher an der Railing. Sie hat keine Uhr aber es muss circa 2 Uhr in der Früh sein. Die See ist ruhig und am Horizont leuchtet ein Licht auf. Es scheint so friedlich, doch der Schein trügt. Es ist ein Japanisches Schiff sie kontrollieren alle Personen anboard. Für Marina wurde ein Haftbefehlt ausgestehlt. Sie hätte ihre eigene Tochter entführt. Gemeinsam mit ihrer Tochter wird sie nun mit dem Flugzeug nach Hause geschickt.',
[
    a-'End'-end
]).

scene(9,
'Flies to America, survives storm. Starts new life despite Cold War.',
[
    a-'End'-end
]).

scene(10,
'Drives to Siberia, finds oil. Becomes rich, flies to Moscow.',
[
    a-'End'-end
]).

scene(11,
'Delay fails, must fly with risks.',
[
    a-'Continue flight'-12
]).

scene(12,
'Bad weather. Follow planned or alternate route?',
[
    a-'Alternate route'-13,
    b-'Planned route'-14
]).

scene(13,
'Ran out of fuel after detour. Could not reach destination.',
[
    a-'Continue'-15
]).

scene(14,
'Icing forces landing. Must decide next move.',
[
    a-'Continue'-15
]).

scene(15,
'Order: Marina must parachute. Help crew or jump?',
[
    a-'Jump'-16,
    b-'Help land'-17
]).

scene(16,
'Parachutes into Taiga, survives 10 days. All survive. Honored as heroes.',
[
    a-'End'-end
]).

scene(17,
'Must land. Choose terrain:',
[
    a-'River'-18,
    b-'Forest'-19
]).

scene(18,
'Crash into river. All perish.',
[
    a-'End'-end
]).

scene(19,
'Plane stuck in trees. Marina escapes. Finds cave. Enter?',
[
    a-'Yes'-20,
    b-'No'-21
]).

scene(20,
'Attacked by bear cub. Dies instantly.',
[
    a-'End'-end
]).

scene(21,
'Finds bear, kills it. Take meat or flee?',
[
    a-'Take meat'-20,
    b-'Flee'-22
]).

scene(22,
'Leaves quickly, finds no food, starves.',
[
    a-'End'-end
]).
