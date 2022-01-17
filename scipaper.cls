% MIT License
%
% Copyright (c) [2022] [Pau Machetti Vallverdú]
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{scipaper}[2022/01/15 Generic Sci Paper]

% Load base scrartcl class on top of which this class is going to be built.
\LoadClass[
	twocolumn,
	headings=normal,
	9pt
]{scrartcl}

% Set text area width to .85 of page witdth
\RequirePackage[scale=0.85]{geometry}

\RequirePackage[linktoc=none]{hyperref}

\RequirePackage{setspace, tocloft}
\setlength\cftparskip{-1.2pt}
\setlength\cftbeforesecskip{1.3pt}
\setlength\cftaftertoctitleskip{2pt}
\makeatletter
\renewcommand{\@seccntformat}[1]{\csname the#1\endcsname.\quad}
\makeatother
\let \savenumberline \numberline
\def \numberline#1{\savenumberline{#1.}}
\makeatletter
\renewcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\makeatother

\let\oldtableofcontents\tableofcontents
\renewcommand{\tableofcontents}{
	\begingroup
		\let\clearpage\relax
		\oldtableofcontents
	\endgroup
}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{marvosym}

\RequirePackage{environ}

\RequirePackage{cuted}
\RequirePackage{lipsum}

\RequirePackage{tikz}
\usetikzlibrary{shapes,arrows}
\usetikzlibrary{arrows.meta}
\RequirePackage{tikz-network}

\RequirePackage{pgfplots}


\RequirePackage{parselines}

\RequirePackage{varwidth}
\tikzset{
	maximum width/.style args={#1}{
		execute at begin node={\begin{varwidth}{#1}},
			execute at end node={\end{varwidth}}
	}

}

\newcommand\halfbox[1]{
	\tikz[baseline=(n.base)]{\node(n)[inner sep=1pt]{$#1$};
		\draw[line cap=round](n.north west)--(n.north east)--(n.south east);
	}
}

\setlength{\columnsep}{1cm}

\newenvironment{define}[1]{
	\begin{center}
		\begin{tabular}{|p{0.9\linewidth}|}
			\hline\vspace{3pt}
			\textbf{Definition:} #1\\
			\rule{\linewidth}{.1pt}\\
		}
		{
			\\\hline
		\end{tabular} 
	\end{center}
}

\newenvironment{titledbox}[1]{
	\begin{center}
		\begin{tabular}{|p{0.9\linewidth}|}
			\hline\vspace{3pt}
			\textbf{#1}\\
			\rule{\linewidth}{.1pt}\\
		}
		{
			\\\hline
		\end{tabular} 
	\end{center}
}

\NewEnviron{example}[1]{
	\begin{center}
		\begin{tikzpicture}
			\node (table) [inner sep=0pt] {
				\begin{tabular}{p{0.9\linewidth}}
					\vspace{3pt}
					\textbf{Example:} #1\\
					\rule{\linewidth}{.1pt}\\
					\BODY
					\\
				\end{tabular}
			};
			\draw [rounded corners=.5em] (table.north west) rectangle (table.south east);
		\end{tikzpicture}
	\end{center}
}

\newenvironment{bulletlist}[0]{
	\begin{enumerate}
		\begin{parse lines}[]{\item[$\bullet$] ##1}
		}
		{
		\end{parse lines}
	\end{enumerate}
}

\newenvironment{checklist}[0]{
	\begin{enumerate}
		\begin{parse lines}[]{\item[\Checkedbox] ##1}
		}
		{
		\end{parse lines}
	\end{enumerate}
}

\newenvironment{crosslist}[0]{
	\begin{enumerate}
		\begin{parse lines}[]{\item[\CrossedBox] ##1}
		}
		{
		\end{parse lines}
	\end{enumerate}
}

\RequirePackage{float}

\RequirePackage{graphicx}

\RequirePackage{minted}
\RequirePackage[most]{tcolorbox}
\colorlet{LightGray}{gray!20!}
\tcbset{on line, 
	boxsep=1pt, left=0pt,right=0pt,top=0pt,bottom=0pt,
	colframe=white,colback=LightGray, fontupper=\small\ttfamily, 
	highlight math style={enhanced}
}
\tcbuselibrary{listings}
\tcbuselibrary{minted}

\RequirePackage{xparse}
\DeclareTCBListing{codelisting}{m}{
	listing engine=minted,
	minted style=trac,
	minted language=#1,
	listing only,
	left=0mm,
	colframe=LightGray,
	colback=LightGray,
	minted options={
		breaklines,
		autogobble,
		linenos,
		numbersep=3mm,
		tabsize=2,
		obeytabs
	},
}

\let\oldabstract\abstract
\let\oldendabstract\abstract
\renewenvironment{abstract}{%
	\oldabstract
	\textbf{ABSTRACT -}
}
{%
	\oldendabstract
}

\let\oldstrip\strip
\let\oldendstrip\endstrip
\RenewDocumentEnvironment{strip}{o}{%
	\oldstrip
	\IfNoValueTF{#1}{%
		\hrule\hspace{0pt}\\
	}{}
}
{%
	\IfNoValueTF{#1}{%
		\\\hrule
	}{}
	\oldendstrip
}

\NewDocumentEnvironment{code}{m m}{%
	\figure[H]
	\centering
	\codelisting{#1}
}
{%
	\endcodelisting
	\caption{#2}
	\endfigure
}