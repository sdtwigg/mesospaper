%=========================================================================
% CBX Thesis Class
%=========================================================================
% Basic LaTeX class file which adheres to the relatively vague MIT
% PhD thesis formatting guidelines.
%
% Author : Christopher Batten
% Date   : December 3, 2009
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cbxthesis}[2009/02/04 ver 0.1]
\LoadClass[11pt,twoside,openright]{article}

%-------------------------------------------------------------------------
% Packages
%-------------------------------------------------------------------------
% We use the mathptmx package to load the Times fonts. The main text
% font size is set as an option when we load the article class.
% I think this needs to be before caption/subfig?

\RequirePackage{fixltx2e}      % Fix some basic latex issues
\RequirePackage{geometry}      % Page layout
\RequirePackage{mathptmx}      % Main times font
\RequirePackage{caption}       % Better caption handling
\RequirePackage{subcaption}    % Subcaptions for subfigures

\RequirePackage{tocloft}       % Formatting of toc, lof, and lot

\RequirePackage{setspace}      % For 1.5 spacing
\RequirePackage{graphicx}      % To include graphics
\RequirePackage{textcomp}      % For non-math characters (eg. mu)
\RequirePackage{balance}       % Balance last columns
\RequirePackage{xcolor}        % Colored text
\RequirePackage{url}           % Nice handling of urls
\RequirePackage{fancyvrb}      % Pretty code formatting

\RequirePackage{rotating}      % Rotate tables 90deg
\RequirePackage{booktabs}      % Very nice table formatting
\RequirePackage{array}         % Extra table features
\RequirePackage{multirow}      % Columns spanning multiple rows

\RequirePackage{calc}          % Basic math operations
\RequirePackage{xifthen}       % Conditional code
\RequirePackage{afterpage}     % Add code after current page

\RequirePackage{tabularx}

%\RequirePackage{hyperref}      % Hyperlinks in PDF
%\RequirePackage[draft]{hyperref}

%-------------------------------------------------------------------------
% Hyperlinks Setup
%-------------------------------------------------------------------------

%\hypersetup
%{%
%  pdftex,%
%  linktocpage,%
%  pdfborder=0,%
%  bookmarks,%
%  bookmarksnumbered%
%}

%-------------------------------------------------------------------------
% Assembly block formatting
%-------------------------------------------------------------------------

\renewcommand{\FancyVerbFormatLine}[1]
{%
  \parbox{1.5ex}{\raggedleft\theFancyVerbLine} #1%
}

%-------------------------------------------------------------------------
% Table of contents, list of figures, list of tables formatting
%-------------------------------------------------------------------------

\setlength{\cftfigindent}{0pt}      % Left margin in lof
\setlength{\cfttabindent}{0pt}      % Left margin in lot
\setlength{\cftbeforefigskip}{0pt}  % Space btwn elements in lof
\setlength{\cftbeforetabskip}{0pt}  % Space btwn elements in lot
\setcounter{tocdepth}{2}            % Do not show subsections

%-------------------------------------------------------------------------
% Page layout and spacing
%-------------------------------------------------------------------------

\geometry
{%
  headheight=15pt,%
  hmargin=1.25in,%
  tmargin=1.25in,%
  bmargin=1.25in%
}

\onehalfspacing

%-------------------------------------------------------------------------
% \cbxarticle@setfontsize{pts} Macro
%-------------------------------------------------------------------------
% We explicitly set the font sizes in points so that we know exactly how
% big each font. Subsection headers are supposed to be 11pt, but there
% is no equivalent built-in LaTeX font size which corresponds to 11pt
% (normalsize is 10pt and large is 12pt). Notice we always calculate the
% the line spacing to be 1.2 times the font size.

\newlength{\cbxarticle@Templen}
\newcommand{\cbxarticle@setfontsize}[1]
{%
  \setlength{\cbxarticle@Templen}{#1 * \real{1.2}}%
  \fontsize{#1}{\the\cbxarticle@Templen}\selectfont%
}

%-------------------------------------------------------------------------
% Caption Setup
%-------------------------------------------------------------------------

\newcommand{\cbxsubfigcaption}[2]{\subfloat[#2]{\rule{#1}{0pt}}}

\DeclareCaptionFont{slightlysmaller}{\cbxarticle@setfontsize{10pt}}
\newcommand{\cbxcaptionsize}{\cbxarticle@setfontsize{10pt}}

% Main caption setup

\captionsetup
{%
  font={slightlysmaller},%
  labelfont={bf},%
  skip=10pt,%
  hypcapspace=\baselineskip%
}

% Subcaption setup

\captionsetup[sub]
{%
  font={slightlysmaller},%
  labelfont={},%
  skip=8pt,%
  justification=centering,%
  labelformat=simple
}

\DeclareCaptionSubType{figure}
\renewcommand{\thesubfigure}{(\alph{subfigure})}

\DeclareCaptionSubType{table}
\renewcommand{\thesubtable}{(\alph{subtable})}

% Helper for Figure 1.2a-b style references

%\newcommand{\subrefs}[2]
%{%
%  \ref{#1}--\subref{#2}%
%}
\newcommand{\subrefs}[3]
{%
  \mbox{\ref{#1}\subref{#1-#2}--\subref{#1-#3}}%
}

%-------------------------------------------------------------------------
% Section headers
%-------------------------------------------------------------------------

% Main section setup

%\renewcommand{\section}
%{%
%  \@startsection{section}
%    {1}{\z@}%
%    {12pt plus 6pt minus 6pt}%
%    {8pt plus 6pt minus 6pt}%
%    {\Large\bfseries}%
%}
%
%\renewcommand{\@seccntformat}[1]{\csname the#1\endcsname\hspace{0.5em}}
%
%% Subsection setup
%
%\renewcommand{\subsection}
%{%
%  \@startsection{subsection}
%    {2}{\z@}%
%    {10pt plus 6pt minus 6pt}%
%    {6pt plus 6pt minus 6pt}%
%    {\large\bfseries}%
%}
%
%\renewcommand{\@seccntformat}[2]{\csname the#1\endcsname\hspace{0.5em}}

% Paragraph setup

\renewcommand{\paragraph}
{%
  \@startsection{paragraph}
    {4}{\z@}%
    {6pt plus 2pt minus 2pt}%
    {-0.3em}%
    {\normalfont\normalsize\bfseries}%
}

%-------------------------------------------------------------------------
% Float spacings
%-------------------------------------------------------------------------

\renewcommand{\topfraction}{0.9}
\renewcommand{\bottomfraction}{0.9}
\renewcommand{\floatpagefraction}{0.9}

\newcommand{\bsk}{\baselineskip}
\setlength{\dbltextfloatsep}{1\bsk plus 0.5\bsk minus 0.5\bsk}
\setlength{\floatsep}{0.8\bsk plus 0.5\bsk minus 0.5\bsk}
\setlength{\textfloatsep}{1\bsk plus 0.5\bsk minus 0.5\bsk}

%-------------------------------------------------------------------------
% Misc Setup
%-------------------------------------------------------------------------

%\raggedbottom             % Prevent odd spacing inbetween paragraphs
\pagestyle{plain}         % Turn on page numbering
\newcommand{\urlprefix}{} % Change url prefix in bibliography
\clubpenalty=1000
\widowpenalty=1000

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

\newcommand{\annotate}[1]{{\color{red}\bfseries [ #1 ]}}
\newcommand{\fixme}[1]{{\color{red}\bfseries [ FIXME: #1 ]}}
\newcommand{\wunits}[2]{\mbox{#1\,#2}}
\newcommand{\um}{\mbox{\textmu m}}
\newcommand{\X}{$\times$}
\newcommand{\x}{\thinspace$\times$\thinspace}
\newcommand{\by}{$\times$}
\newcommand{\tw}{\textwidth}
\newcommand{\cw}{\columnwidth}
\newcommand{\uT}{\mbox{\textmu T}}
\newcommand{\uTs}{\mbox{\textmu Ts}}

