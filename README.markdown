## Präamble

Die LaTeX Klasse `exsheet2` ist zur Erstellung von Aufgabenblättern und
Klausuren, also im weitesten Sinne "exercise sheets". Sie geht aus einer
älteren Version `exsheet` hervor, die bislang nicht publiziert wurde und welche
ich in den letzten 10 Jahren für diese Anwedungen verwendete.

Viele Entwurfsaspekte von `exsheet2` stammen aus einer Erhebung am Department
for Information Technologies and Digitalisation an der FH Salzburg.

Ich verwende die Klasse für zwei Kategorien von Anwendungsfällen:

   * Prüfungen, Tests oder Abschlussklausuren
   * Aufgabenblätter oder Übungsblätter


## Installation

Die einfache Lösung ist, dass man `exsheet2.cls` lokal in jedes Verzeichnis
gibt, wo es verwendet wird, d.h. wo die betreffenden LaTeX Dokumente liegen.

Die nachhaltige Lösung ist das Kopieren der Datei `exsheet2.cls` in ein
[TEXINPUTS](https://www2.ph.ed.ac.uk/~wjh/tex/documents/environmental.pdf)
Verzeichnis. Alternativ bietet sich das Klonen dieses Repositories und das
Verlinken von `exsheet2.cls` in ein Verzeichnis in `TEXINPUTS` an. Das macht
ein Update über git einfacher.

Das originale Repository findet sich auf
[git.sthu.org](https://git.sthu.org/?p=exsheet.git;a=summary). Ein Klon auf
[github.com/shuber2/exsheet](https://github.com/shuber2/exsheet) macht das
Verwalten von Issues und Pull Requests einfacher.


## Allgemeine Features

Es wird eine Umgebung `exercises` zur Verfügung gestellt, um Aufgaben zu
formulieren. Man kann auch die Antwort mitformulieren und über die Option
`showanswers` an die Dokumentenklasse diese anzeigen lassen.

```latex
\begin{exercise}
  An exercise.
\end{exercise}

\begin{answer}
  $\vec{a} = \frac{\vec{F}}{m}$
\end{answer}
```

Ein optionales Argument erlaubt es die Punkteanzahl bekanntzugeben. Die
Umgebung `choices` erlaubt es single- oder multiple-choice Fragen zu
formulieren:

```latex
\begin{exercise}[4]  % Frage mit vier Punkten
  Kreuzen Sie die richtigen Anworten an:
  \begin{choices}
    \item $1 + 1 = 0 \pmod 2$
    \item $1 + 1 = 1 \pmod 2$
    \item $1 + 1 = 1 \pmod 3$
    \item $1 + 1 = 5 \pmod 7$
  \end{choices}
\end{exercise}
```


Über die Optionen `german`, `ngerman` oder `austrian` wird die Sprache
entsprechend umgestellt. Die betreffenden Pakete werden geladen.

Über die Option `exam` lassen sich Klausuren erstellen. Sie weitere
Informationen unten.

Die Optionen `10pt`, `12pt` und `twoside` werden an die Klasse `article`
weitergeleitet.

Es können über folgende Befehle entsprechend die Daten zur Klausur gesetzt
werden: `\title`, `\author`, `\date`, `\course`, `\curriculum`, `\semester`,
`\institute`, `\school`, `\duration`, `\instructions`. Achtung, `\date` muss
das Datum im ISO-Format erhalten, also yyyy-mm-dd. Wenn kein Datum gesetzt
wird, dann wird das aktuelle Datum verwendet.


## Aufgabenblätter

Die Klassse `exsheet2` erzeugt ohne weitere Optionen einfache Aufgabenblätter.
Es werden zwei Sprachen unterstützt und notwendige Pakete entsprechend geladen:

* american
* german, ngerman

Ein Beispiel [exsheet2-demo-aufgabenblatt.tex](exsheet2-demo-aufgabenblatt.tex)
befindet sich als Demo im Repository. Ein einfaches Beispiel für ein
Aufgabenblatt mit einer Aufgabe lautet wie folgt:

```latex
\documentclass[ngerman]{exsheet2}

\usepackage{fontspec}

\title{Aufgabenblatt 7}
\course{ILV Numerik und Industrielle Algorithmen}
\curriculum{ITS}

\date{2022-10-21}
\semester{WS 2022}

\author{Stefan Huber}
\institute{Department IT}
\school{FH Salzburg}

\begin{document}

\maketitle

\begin{exercise}
  Welche Beschleunigung $\vec{a}$ erfährt eine träge Masse $m$ im Kraftfeld
  $\vec{F}$ nach Newton?
  \vspace{2cm}
\end{exercise}

\end{document}
```


## Klausuren

Klausuren werden durch die Option `exam` für die Klasse `exsheet2`erzeugt. Das
führt zu folgendem zusätzlichem Verhalten:

* Für Klausuren wird ein Deckblatt erzeugt.
* Die Punktesumme der Aufgaben wird am Deckblatt angezeigt.
* Es wird eine Zufallszahl als
  [Nonce](https://en.wikipedia.org/wiki/Cryptographic_nonce) generiert, die
  rechts unten auf den Blättern bedruckt wird. Das ermöglicht die Zuordnung von
  losen Blättern zu Klausuren und verhindert, dass Blätter von Student·innen
  vorgeschrieben werden können.

Durch die automatische Berechnung der Punktesummen wird das **effiziente
Generieren von Klausuren** über Fragenkataloge erleichtert: Man kann in einem
Sammeldokumente Fragen sammeln, die vom Umfang mehrere Klausuren füllen und für
die Erstellung konkreter Klausuren fragen löschen, um auf die gewünschte
Punktezahl zu kommen.

Die Kopfzeile enthält jene Informationen, welche rasch erkennen lassen sollen,
um welche Klausur es sich handelt. Das ist für Sammelklausuren, wo gleichzeitig
viele verschiedene Klausuren durchgeführt werden, für die Beaufsichtigung
wichtig.

Zwei Beispiele befinden sich als Demo im Repository:

* [exsheet2-demo-klausur.tex](exsheet2-demo-klausur-en.tex) ist eine deutsche Klausur
* [exsheet2-demo-klausur-en.tex](exsheet2-demo-klausur-en.tex) ist eine englische Klausur


## Abschlussprüfungen

Abschlussprüfungen, etwa eine Bachelorprüfung, ist ähnlich zu einer Klausur,
mit wenigen Unterschieden. Da die Prüfung in unserer Anwendung für
Student·innen individualisiert ist, ist der Studierendenname im Titel. Die
Formularelement für die Benotung und die Studierendeninformationen sind
obsolet. Die Dauer ist durch den Prüfungsprozess vorgegeben und muss nicht am
Deckblatt angegeben werden. Auch die Semesterangabe hat keine Bedeutung.

Um diesen Fall abzubilden werden folgende Features unterstützt:
* Wenn `\duration` oder `\semester` nicht gesetzt werden, dann wird die
  Information nicht angezeigt.
* Durch die Option `nostudentinfo` und `nogradeinfo` werden die jeweiligen
  Formularelemente auf dem Deckblatt nicht angezeigt.

Ein Beipsiel [exsheet2-demo-bapruefung.tex](exsheet2-demo-bapruefung.tex)
befindet sich im Repository.
