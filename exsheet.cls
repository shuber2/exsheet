% Stefan Huber, 2010-02
% Stefan Huber, 2019-09-23
% Stefan Huber, 2020-06-23
% Stefan Huber, 2021-06-21

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{exsheet}


\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{article}}

\DeclareOption{german}{\def \exsheetgerman{}}
\DeclareOption{ngerman}{\def \exsheetgerman{}}
\DeclareOption{austrian}{\def \exsheetgerman{}}
\DeclareOption{naustrian}{\def \exsheetgerman{}}
\DeclareOption{showanswers}{\def \exsheetshowanswers{}}


\PassOptionsToClass{a4paper,notitlepage,twoside}{article}
\ProcessOptions\relax

%-------------------- This is based on the article class ----------------

\LoadClass{article}
\RequirePackage{xifthen,geometry,fancyhdr,enumitem,comment}


%------------------ Defining the most common environments ---------------

\@ifundefined{exsheetgerman}{
	\newcommand{\theexercise}{Exercise}
	\newcommand{\thepoint}{Point}
	\newcommand{\thepoints}{Points}
	\newcommand{\thestudnumber}{Number}
	\newcommand{\theanswer}{Answer}
}{%
	\newcommand{\theexercise}{Aufgabe}
	\newcommand{\thepoint}{Punkt}
	\newcommand{\thepoints}{Punkte}
	\newcommand{\thestudnumber}{Personenkennzeichen}
	\newcommand{\theanswer}{Antwort}
}

%Check whether we should show the answers
\@ifundefined{exsheetshowanswers}{
	\excludecomment{answer}
}{
	\newenvironment{answer}{\vspace*{0.5em}\textit{\theanswer:} \hspace*{0.5em} }{}
}

\newcounter{excounter}
\setcounter{excounter}{1}
\newenvironment{exercise}[1][]{%
	\vspace*{2em}%
	\textbf{\theexercise~\arabic{excounter}}:
	\ifthenelse{\isempty{#1}}{}{%
		\ifnum#1=1%
			\hfill[#1 \thepoint]%
		\else%
			\hfill[#1 \thepoints]%
		\fi%
	}%
	\newline}
{\addtocounter{excounter}{1}} 


\def\@semester{}
\newcommand{\semester}[1]{\def\@semester{#1}}

\def\@lva{}
\newcommand{\lva}[1]{\def\@lva{#1}}

\def\@auth{}
\renewcommand{\author}[1]{\def\@auth{#1}\def\@author{#1}}

\def\@institute{\ }
\newcommand{\institute}[1]{\def\@institute{#1}}

\newcommand{\studentinfo}{%
	{
	Name: \underline{\hspace{6cm}}
	\hfill
	\thestudnumber: \underline{\hspace{4cm}}
	\vspace*{2em}
	}
}




%------------------ Basic layout ----------------------------------------

\geometry{verbose,a4paper,width=16cm,height=23cm}

\fancypagestyle{exsheet}
{
	\fancyhf{}%
  \fancyhead[LO,LE]{%
			\begin{minipage}{70mm}
				\@lva\\
				\@semester
			  \vspace{1mm}
			\end{minipage}
	}
  \fancyhead[RO,RE]{%
			\begin{minipage}{70mm}
				\raggedleft
				\@institute\\
				\@auth
			  \vspace{1mm}
			\end{minipage}
	}
}

\setlength{\headheight}{2.5em}
\renewcommand{\headrulewidth}{1pt}

\setlength{\parindent}{0em}


%------------------ Common command ---------------------------------------

\let\oldmaketitle\maketitle

\renewcommand{\@maketitle}{%
	\noindent
	\begin{center}
		{\LARGE\bf\@title}\\
		\vspace{1em}\@date
	\end{center}

	\vspace{4em}
}

\renewcommand{\maketitle}{%
	\oldmaketitle
	\thispagestyle{exsheet}
	\pagestyle{exsheet}
}


\renewcommand\abstract{\it\noindent}

%------------------ Defining specific commands environments ---------------

\newenvironment{choices}{%
	\begin{itemize}[label=$\square$, labelsep=2ex]
	}{\end{itemize}}

