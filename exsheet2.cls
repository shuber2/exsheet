% Stefan Huber, 2022

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{exsheet2}

\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{twoside}{\PassOptionsToClass{\CurrentOption}{article}}

\DeclareOption{german}{\def \exsheetgerman{}}
\DeclareOption{ngerman}{\def \exsheetgerman{}}
\DeclareOption{austrian}{\def \exsheetgerman{}}
\DeclareOption{naustrian}{\def \exsheetgerman{}}
\DeclareOption{showanswers}{\def \exsheetshowanswers{}}
\DeclareOption{exam}{\def \exsheetexam{}}
\DeclareOption{nostudentinfo}{\def \exsheetnostudentinfo{}}
\DeclareOption{nogradeinfo}{\def \exsheetnogradeinfo{}}


\PassOptionsToClass{a4paper}{article}
\ProcessOptions\relax


\LoadClass{article}

\@ifundefined{exsheetgerman}{
  \usepackage[american]{babel}
  \newcommand{\theexercise}{Exercise}
  \newcommand{\thepoint}{Point}
  \newcommand{\thepoints}{Points}
  \newcommand{\thename}{Name}
  \newcommand{\thestudnumber}{Number}
  \newcommand{\theanswer}{Answer}
  \newcommand{\theduration}{Duration}
  \newcommand{\thegrade}{Grade}
  \newcommand{\theof}{of}
}{%
  \usepackage[ngerman]{babel}
  \newcommand{\theexercise}{Aufgabe}
  \newcommand{\thepoint}{Punkt}
  \newcommand{\thepoints}{Punkte}
  \newcommand{\thename}{Name}
  \newcommand{\thestudnumber}{Personenkennzeichen}
  \newcommand{\theanswer}{Antwort}
  \newcommand{\theduration}{Prüfungsdauer}
  \newcommand{\thegrade}{Note}
  \newcommand{\theof}{von}
}

\usepackage[useregional]{datetime2}

\RequirePackage{xifthen,geometry,fancyhdr,enumitem,comment,amssymb}

\newcounter{exsheet2@pointsum}
\def\droptotalpoints{unknown}
\AtBeginDocument{\AtEndDocument{%
    \immediate\write\@mainaux{%
      \string\gdef\string\droptotalpoints{\number\value{exsheet2@pointsum}}%
    }
}}

\newcounter{exsheet2@excounter}
\setcounter{exsheet2@excounter}{1}
\newenvironment{exercise}[1][]{%
  \vspace*{2em}%
  \textbf{\theexercise~\arabic{exsheet2@excounter}}
  \ifthenelse{\isempty{#1}}{}{%
    \addtocounter{exsheet2@pointsum}{#1}
    \ifnum#1=1%
      \hfill[#1 \thepoint]%
    \else%
      \hfill[#1 \thepoints]%
    \fi%
  }%
  \newline}
{\addtocounter{exsheet2@excounter}{1}}

\@ifundefined{exsheetshowanswers}{
  \excludecomment{answer}
}{
  \newenvironment{answer}{\vspace*{0.5em}\textit{\theanswer:} \hspace*{0.5em} }{}
}

\newenvironment{choices}{%
  \begin{itemize}[label=$\square$, labelsep=2ex]
  }{\end{itemize}}


\def\@course{}
\newcommand{\course}[1]{\def\@course{#1}}

\def\@curriculum{}
\newcommand{\curriculum}[1]{\def\@curriculum{#1}}

\def\@semester{}
\newcommand{\semester}[1]{\def\@semester{#1}}

\def\@auth{}
\renewcommand{\author}[1]{\def\@auth{#1}\def\@author{#1}}

\def\@institute{}
\newcommand{\institute}[1]{\def\@institute{#1}}

\def\@school{}
\newcommand{\school}[1]{\def\@school{#1}}

\def\@duration{}
\newcommand{\duration}[1]{\def\@duration{#1}}

\def\@instructions{}
\newcommand{\instructions}[1]{\def\@instructions{#1}}

\let\olddate\date
\DTMsavenow{exsheet2@today}
\renewcommand{\date}[1]{\olddate{#1}\DTMsavedate{exsheet2@today}{#1}}


\geometry{a4paper,textwidth=16cm,textheight=23cm}


\RequirePackage{lcg}
\reinitrand[first=10000,last=99999,counter=examnonce,quiet]
\rand

\fancypagestyle{exsheet}
{
  \fancyhf{}%
  \fancyhead[L]{%
    \@course\\
    \@semester
  }
  \fancyhead[C]{%
    {\DTMsetdatestyle{iso}\DTMusedate{exsheet2@today}}
  }
  \fancyhead[R]{%
    \@auth\\
    \@curriculum
  }
  \@ifundefined{exsheetexam}{}{%
    \fancyfoot[R]{%
      \tiny nounce: \arabic{examnonce}
    }
  }
}

\setlength{\headheight}{2.5em}
\renewcommand{\headrulewidth}{1pt}

\setlength{\parindent}{0em}


\newcommand{\makestudentinfo}{%
  {
  \thename: \underline{\hspace{5cm}}
  \hfill
  \thestudnumber: \underline{\hspace{4cm}}
  }
}

\newcommand{\makegradeinfo}{%
  {
  \thegrade: \underline{\hspace{5cm}}
  \hfill
  \thepoints: \underline{\hspace{2cm}} \theof\ \droptotalpoints
  }
}


\let\oldmaketitle\maketitle


\@ifundefined{exsheetexam}{
  \PassOptionsToClass{notitlepage}{article}
  \renewcommand{\@maketitle}{%
      \begin{center}
        \vspace*{1em}
        {\LARGE \bf \@title}
        \vspace*{2em}
      \end{center}
  }
}{%
  \renewcommand{\@maketitle}{%
    \begin{titlepage}
      \begin{center}
        \vspace*{2cm}

        \hrule
        \vspace*{1cm}
        {\LARGE \bf \@title}

        \vspace*{1cm}
        {
          \large\bf%
          \@course
          \ifthenelse{\equal{\@semester}{}}{}{ (\@semester)}
        }

        \vspace*{1cm}
        \hrule

        \vspace*{2cm}

        \@auth \\

        \vspace*{1em}

        {\DTMusedate{exsheet2@today}} \\

        \vspace*{1em}
        \@curriculum \\
        \@institute \\
        \@school \\

        \ifthenelse{\equal{\@duration}{}}{}{%
          \vspace*{1cm}
          \theduration: \@duration
        }
      \end{center}

      \vspace{4em}
      \@instructions

      \vfill

      \ifthenelse{\isundefined{\exsheetnostudentinfo}}{%
        \makestudentinfo
      }{}

      \ifthenelse{\isundefined{\exsheetnogradeinfo}}{%
        \vspace{3em}
        \makegradeinfo
      }{}
    \end{titlepage}
  }
}

\renewcommand{\maketitle}{%
  \oldmaketitle
  \thispagestyle{exsheet}
  \pagestyle{exsheet}
}

