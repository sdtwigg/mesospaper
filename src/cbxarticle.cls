%=========================================================================
% CBX Article Class
%=========================================================================
% This class file formats a paper according to the IEEE Computer Society
% Guidelines for 8.5 x 11 proceedings. You should use \conference,
% \title, \author, and \affiliation in your front matter and use
% \cbxbib right before you use \bibliography{}. The relevant guidelines
% are listed below. Note that I don't try to implement centered captions
% nor positioning the table captions above the tables since these just
% don't seem to make sense for captions which are more than just a
% title. Although this class can be used for IEEE Computer Society
% publications I also have code below which breaks the guidelines but
% makes it look better in my opinion.
%
% Class Options
%  - appearsin  : add appears in header
%  - submitted  : add submitted & do not dist. header, draft watermark
%  - draftcopy  : add draft copy & do not dist. header, draft watermark
%  - blind      : remove author and affiliation information
%  - pagenum    : add a page number to every page
%
% Author : Christopher Batten
% Date : February 3, 2009
%

%-------------------------------------------------------------------------
% Releveant IEEE Computer Society Guidelines
%-------------------------------------------------------------------------
% All printed material, including text, illustrations, and charts, must
% be kept within a print area of 6.5in x 8.875in. All text must be in
% two column format. Columns are to be separated by 0.375in.
%
% The primary title should begin 1.375in from the top of the page,
% centered, in Times 14pt boldface type. Leave two 12pt blank lines
% after the title. Author names and affiliations are to be centered
% beneath the title and printed in Times 12pt non-boldface type.
% Multiple authors may be shown in a two- or three-column forma, with
% their affiliations italicized and centered below their respective
% names. Author information should be followed by two 12pt blank lines.
%
% Abstract is to be in fully-justified italicized text, at the top of
% the first left-hand column. Use the word "Abstract" as the title in
% 12pt Times, boldface type, centered relative to the column, initially
% capitalized. The abstract is to be in 10pt, single-spaced type, and up
% to 150 words in length. Leave two blank lines after the abstract, then
% begin the main text.
%
% Main text should be 10pt Times, single-spaced All paragraphs should
% be indented 0.25in. Figure and table captions should be 10pt boldface
% helvetica. Callouts should be 9pt non-boldface Helvetica. Initially
% capitalize only the first word of each figure caption or table title.
% Figures and tables must be numbered separately. Figure captions are
% to be centered below the figures. Table titles are to be centered
% above the tables.
%
% Section headers should be Times 12pt boldface, initially capitalized,
% flush left, with one blank line before, and one blank line after. Use
% a period after the heading number, not a colon. Subsection headers
% should be Times 11pt boldface, initially capitalized, flush left, with
% one blank line before, and one after.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cbxarticle}[2009/02/04 ver 0.1]
\LoadClass[11pt]{article}

%-------------------------------------------------------------------------
% Options
%-------------------------------------------------------------------------
% These are the options which you can pass when you call \documentclass.
%
%  - annotate   : show margin annotations
%  - appearsin  : appears in header
%  - submitted  : submitted & do not distribute header, draft watermark
%  - draftcopy  : draft copy & do not distribute header, draft watermark
%  - blind      : remove author and affiliation information
%  - pagenum    : add a page number to every page
%

\gdef\cbxarticle@annotate{false}
\gdef\cbxarticle@draftcopy{false}
\gdef\cbxarticle@appearsin{false}
\gdef\cbxarticle@submitted{false}
\gdef\cbxarticle@pagenum{false}
\gdef\cbxarticle@blind{false}

\DeclareOption{annotate}{\gdef\cbxarticle@annotate{true}}
\DeclareOption{appearsin}{\gdef\cbxarticle@appearsin{true}}
\DeclareOption{submitted}{\gdef\cbxarticle@submitted{true}}
\DeclareOption{draftcopy}{\gdef\cbxarticle@draftcopy{true}}
\DeclareOption{pagenum}{\gdef\cbxarticle@pagenum{true}}
\DeclareOption{blind}{\gdef\cbxarticle@blind{true}}
\ProcessOptions

%-------------------------------------------------------------------------
% Packages
%-------------------------------------------------------------------------
% We use the mathptmx package to load the Times and Helvetica fonts. The
% main text font size is set as an option when we load the article
% class. We used scaled helvetica so that the caption font size is
% comparable to the main text Times font size. I also load packages
% which I pretty much always use (eg. graphicx, textcomp, booktabs, etc)

\RequirePackage{geometry}     % Page layout

\RequirePackage[T1]{fontenc}  % Make sure we use T1 font encoding
\RequirePackage{mathptmx}     % Use times for serif font
\RequirePackage[scaled=0.92]{helvet} % Use helvetica for sans serif font
%\RequirePackage{courier}      % Use courier for fixed width font

\RequirePackage{caption}      % updated version of caption
\RequirePackage{subcaption}   %  ... which includes the subcaption pkg
\RequirePackage{graphicx}     % To include graphics
\RequirePackage{fancyvrb}     % Pretty code formatting
\RequirePackage{dblfloatfix}  % Fixes some issues with dbl col floats
\RequirePackage{textcomp}     % For non-math characters (eg. mu)
\RequirePackage{cite}         % Sort cite lists [1,2,3]
\RequirePackage{balance}      % Balance last columns
\RequirePackage{fancyhdr}     % For headers and footers
\RequirePackage{booktabs}     % Very nice table formatting
\RequirePackage{xcolor}       % Colored text

\RequirePackage{calc}         % Basic math operations
\RequirePackage{xifthen}      % Conditional code

% This makes the document double spaced

\usepackage{setspace}
\newcommand{\cbxsetspace}{\setstretch{1.5}}
%\doublespacing
\cbxsetspace

%-------------------------------------------------------------------------
% \cbxarticle@setfontsize{pts} Macro
%-------------------------------------------------------------------------
% We explicitly set the font sizes in points so that we know exactly how
% big each font. Subsection headers are supposed to be 11pt, but there
% is no equivalent built-in LaTeX font size which corresponds to 11pt
% (normalsize is 10pt and large is 12pt). Notice we always calculate the
% the line spacing to be 1.2 times the font size.

\newlength{\cbxarticle@Templen}
\newcommand{\cbxsetfontsize}[1]
{%
  \setlength{\cbxarticle@Templen}{#1 * \real{1.19}}%
  \fontsize{#1}{\the\cbxarticle@Templen}\selectfont%
}

%-------------------------------------------------------------------------
% Caption Fontsizes
%-------------------------------------------------------------------------

\DeclareCaptionFont{slightlysmaller}{\cbxsetfontsize{10pt}}
\DeclareCaptionFont{muchsmaller}{\cbxsetfontsize{9pt}}
\newcommand{\cbxcaptionsize}{\cbxsetfontsize{9pt}}

% Main caption setup

\captionsetup
{%
  font={muchsmaller},%
  labelfont={bf},%
  skip=10pt,%
  hypcapspace=\baselineskip%
}

% Subcaption setup

\captionsetup[sub]
{%
  font={muchsmaller},%
  labelfont={},%
  skip=8pt,%
  justification=centering,%
  labelformat=simple%
}

% Parens

\DeclareCaptionSubType{figure}
\renewcommand{\thesubfigure}{(\alph{subfigure})}

\DeclareCaptionSubType{table}
\renewcommand{\thesubtable}{(\alph{subtable})}

\newcommand{\subrefs}[3]
{%
  \mbox{\ref{#1}\subref{#1-#2}--\subref{#1-#3}}%
}

%-------------------------------------------------------------------------
% Assembly block formatting
%-------------------------------------------------------------------------

\renewcommand{\FancyVerbFormatLine}[1]
{%
  \parbox{1.5ex}{\raggedleft\theFancyVerbLine} #1%
}

%-------------------------------------------------------------------------
% Page layout
%-------------------------------------------------------------------------
% Technically the margins should all be 1in except for the bottom margin
% which should be 1.125in and the column separation should be 0.375in.
% This corresponds to these parameters:
%
%  hmargin=1in,tmargin=1in,bmargin=1.125in,columnsep=0.375in
%
% You can play with these margins a bit and they probably won't notice
% 0.05in here or there.

% If we have annotate turned on then leave extra room in the right margin
% for the margin notes.

\ifthenelse{\equal{\cbxarticle@annotate}{true}}%
{%
  \geometry
  {%
    paperheight=11in,
    paperwidth=9.5in,
    headheight=15pt,
    lmargin=1in,
    rmargin=2in,
    tmargin=1in,
    bmargin=1in,
    columnsep=0.3in,
    marginpar=1.6in,
  }
}{%
  \geometry
  {%
    paperheight=11in,
    paperwidth=8.5in,
    headheight=15pt,
    hmargin=1in,
    tmargin=1in,
    bmargin=1in,
    columnsep=0.3in
  }
}

%-------------------------------------------------------------------------
% Title block
%-------------------------------------------------------------------------
% The title should have an extra 0.375in of vspace above it and be in
% 14pt bold Times. Then 24pt of white space before the author names and
% affiliations which should be in 12pt Times. Affiliations should be
% italicized. After the affiliations there should be another 24pt of
% white space.

\gdef\cbxarticle@conference{}%
\newcommand{\conference}[1]
{%
  \gdef\cbxarticle@conference{#1}%
}

\gdef\cbxarticle@affiliation{}%
\newcommand{\affiliation}[1]
{%
  \gdef\cbxarticle@affiliation{#1}%
}

\renewcommand{\@maketitle}
{%
  % Technically this top vspace should be 0.375in to be conforming
  \singlespacing
  %\ifthenelse{ \equal{\cbxarticle@blind}{false} }
  %{%
  %  \vspace*{0.2in}%
  %}{%
  %  \vspace*{0.0in}%
  %}
  \centering
  {\cbxsetfontsize{16pt}\bf\@title\par}
  %\ifthenelse{ \equal{\cbxarticle@blind}{false} }
  %{%
  %  % Technically this top vspace should be 24pt to be conforming
  %  \vspace{20pt}%
  %  {\cbxsetfontsize{12pt}\@author\par}\vspace{6pt}
  %  {\cbxsetfontsize{12pt}\itshape\cbxarticle@affiliation\par}
  %}{}
  %\vspace{20pt}
  \cbxsetspace
}

%-------------------------------------------------------------------------
% Abstract
%-------------------------------------------------------------------------
% The word abstract needs to be bold, centered, and in 12pt font. The
% abstract should be italicized. The space below the abstract should
% be 24pt but here I only leave one line.

\renewenvironment{abstract}
{%
  %\centerline{\cbxsetfontsize{12pt}\bf Abstract}%
  %\vspace*{5pt}%
  \setstretch{1.25}%
  \itshape%
  \begin{list}{}%
  {%
    \setlength{\leftmargin}{0.1in}%
    \setlength{\rightmargin}{0.1in}%
    \item
  }%
}{%
  \end{list}%
  \cbxsetspace%
}

%-------------------------------------------------------------------------
% Section headers
%-------------------------------------------------------------------------
% We need to change the spacing around the section headers and also
% make sure the numbers have an extra dot at the end. Both headers are
% bold and section headers are 12pt while subsection headers are 11pt.
% The space below the two headers is not really a whole line but using
% the same space above and below a section header seems like bad
% practice since it makes it harder to see the structure.

\renewcommand{\section}
{%
  \@startsection{section}{1}{\z@}%
                {8pt plus 2pt minus 2pt}%
                {6pt plus 2pt minus 3pt}%
                {\cbxsetfontsize{14pt}\bf}%
}

\renewcommand{\subsection}
{%
  \@startsection{subsection}{2}{\z@}%
                {8pt plus 2pt minus 2pt}%
                {6pt plus 2pt minus 3pt}%
                {\cbxsetfontsize{13pt}\bf}%
}

\renewcommand{\@seccntformat}[1]{\csname the#1\endcsname.\hspace{0.5em}}
\renewcommand{\@seccntformat}[2]{\csname the#1\endcsname.\hspace{0.5em}}

%-------------------------------------------------------------------------
% Float spacings
%-------------------------------------------------------------------------

\renewcommand{\dbltopfraction}{0.9}
\renewcommand{\topfraction}{0.9}
\renewcommand{\dblfloatpagefraction}{0.7}
\renewcommand{\floatpagefraction}{0.7}

\newcommand{\bsk}{\baselineskip}
\setlength{\dbltextfloatsep}{0.8\bsk plus 0.2\bsk minus 0.2\bsk}
\setlength{\floatsep}{0.8\bsk plus 0.2\bsk minus 0.2\bsk}
\setlength{\textfloatsep}{0.8\bsk plus 0.2\bsk minus 0.2\bsk}

%-------------------------------------------------------------------------
% Bibliography
%-------------------------------------------------------------------------
% Make sure the final page is balanced and change inter-item spacing.

\let\cbxarticle@oldthebibliography\thebibliography
\renewcommand{\thebibliography}[1]
{%
  \balance%
  \singlespacing%
  \cbxarticle@oldthebibliography{#1}%
  \setlength{\itemsep}{-1ex}%
  \cbxsetfontsize{9pt}%
  \vspace{0.2ex}%
}

%-------------------------------------------------------------------------
% Process class options
%-------------------------------------------------------------------------

% Default headers

\renewcommand{\headrulewidth}{0.0in}
\newcommand{\cbxarticle@firstpageheader}{}
\newcommand{\cbxarticle@mainpageheader}{}
\newcommand{\cbxarticle@footer}{}

% Appears

\ifthenelse{ \equal{\cbxarticle@appearsin}{true} }
{%
  \renewcommand{\cbxarticle@firstpageheader}
  {%
    \vspace{0.1in}\itshape%
    Appears in the Proceedings of the \cbxarticle@conference%
  }
}{}

% Submitted

\ifthenelse{      \equal{\cbxarticle@appearsin}{false}
             \AND \equal{\cbxarticle@submitted}{true}  }
{%
  \RequirePackage[firstpage]{draftwatermark}
  \SetWatermarkLightness{0.9}
  \renewcommand{\cbxarticle@firstpageheader}
  {%
    \itshape --- Please Do Not Redistribute --- \\
    Submitted to the \cbxarticle@conference%
  }
  \renewcommand{\cbxarticle@mainpageheader}
  {%
    \itshape --- Please Do Not Redistribute ---%
  }
}{}

% Draft Copy

\ifthenelse{      \equal{\cbxarticle@appearsin}{false}
             \AND \equal{\cbxarticle@submitted}{false}
             \AND \equal{\cbxarticle@draftcopy}{true}  }
{%
  \RequirePackage[firstpage]{draftwatermark}
  \SetWatermarkLightness{0.9}
  \renewcommand{\cbxarticle@firstpageheader}
  {%
    \itshape --- Please Do Not Redistribute --- \\
    Draft Copy for the \cbxarticle@conference%
  }
  \renewcommand{\cbxarticle@mainpageheader}
  {%
    \itshape --- Please Do Not Redistribute ---%
  }
}{}

% Page Numbers

\ifthenelse{ \equal{\cbxarticle@pagenum}{true} }
{%
  \renewcommand{\cbxarticle@footer}{\thepage}%
}

%-------------------------------------------------------------------------
% Setup page styles
%-------------------------------------------------------------------------

\fancypagestyle{firstpagestyle}
{%
  \fancyhead{}
  \fancyfoot{}
  \fancyhead[C]{\cbxarticle@firstpageheader}
  \fancyfoot[C]{\cbxarticle@footer}
}

\fancypagestyle{mainpagestyle}
{%
  \fancyhead{}
  \fancyfoot{}
  \fancyhead[C]{\cbxarticle@mainpageheader}
  \fancyfoot[C]{\cbxarticle@footer}
}

\let\cbxarticle@oldmaketitle\maketitle
\renewcommand{\maketitle}
{%
  \cbxarticle@oldmaketitle
  \thispagestyle{firstpagestyle}
}

\pagestyle{mainpagestyle}

%-------------------------------------------------------------------------
% Annotate
%-------------------------------------------------------------------------

\newcommand{\annotate}
{%
  \@ifstar\annotateStar\annotateNoStar%
}

\newcommand{\annotateNoStar}[1]
{%
  \ifthenelse{\equal{\cbxarticle@annotate}{true}}%
  {%
    {\color{red}$^\star$}\hspace{-0.02in}%
    \marginpar%
    {%
      \singlespacing%
      \footnotesize%
      \raggedright%
      \begin{cbxlist}[{\large\color{red}$\star$}]{1em}{0em}{0em}%
        \item\color{red}#1%
      \end{cbxlist}%
    }%
  }{}%
}

\newcommand{\annotateStar}[1]
{%
  \ifthenelse{\equal{\cbxarticle@annotate}{true}}%
  {%
    \marginpar%
    {%
      \singlespacing%
      \footnotesize%
      \raggedright%
      \begin{cbxlist}[{\large\color{red}$\star$}]{1em}{0em}{0em}%
        \item\color{red}#1%
      \end{cbxlist}%
    }%
  }%
}

%-------------------------------------------------------------------------
% Misc setup
%-------------------------------------------------------------------------

\renewcommand{\arraystretch}{0.93}

%-------------------------------------------------------------------------
% Useful macros
%-------------------------------------------------------------------------

\newenvironment{cbxlist}[4][\textbullet]
{%
  \begin{list}{#1}
  {%
    \setlength{\leftmargin}{#2}
    \setlength{\rightmargin}{#3}
    \setlength{\topsep}{0pt}
    \setlength{\parsep}{0pt}
    \setlength{\listparindent}{0pt}
    \setlength{\itemsep}{#4}
  }
}{%
  \end{list}
}

\newenvironment{cbxindent}[2]
{%
  \begin{list}{}
  {
    \setlength{\leftmargin}{#1}
    \setlength{\rightmargin}{#2}
    \item
  }
}{%
  \end{list}
}

\newcommand{\fixme}[1]{{\color{red}\bfseries [ FIXME: #1 ]}}
\newcommand{\wunits}[2]{\mbox{#1\,#2}}
\newcommand{\um}{\mbox{\textmu m}}
\newcommand{\X}{$\times$}
\newcommand{\x}{\thinspace$\times$\thinspace}
\newcommand{\by}{$\times$}
\newcommand{\texttilde}{{\char'176}}
\newcommand{\tw}{\textwidth}
\newcommand{\cw}{\columnwidth}

