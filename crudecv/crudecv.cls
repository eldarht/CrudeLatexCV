\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{crudecv/crudecv}
\RequirePackage{multicol}

\LoadClass{article}

\voffset = -72pt
\hoffset = -0pt
\oddsidemargin = 0pt
\textwidth = 455pt
\textheight = 720pt
\marginparwidth = 0pt


\newcommand{\applicantName}[1]{\newcommand{\@applicantName}{#1}}
\newcommand{\applicantBirth}[1]{\newcommand{\@applicantBirth}{#1}}
\newcommand{\applicantAddress}[1]{\newcommand{\@applicantAddress}{#1}}
\newcommand{\applicantEmail}[1]{\newcommand{\@applicantEmail}{#1}}
\newcommand{\applicantMobile}[1]{\newcommand{\@applicantMobile}{#1}}

\newcommand{\applicant}[5][\@author]{
	\applicantName{#1}
	\applicantBirth{#2}
	\applicantAddress{#3}
	\applicantEmail{#4}
	\applicantMobile{#5}
}

\renewcommand*{\maketitle}{
	{\huge \textbf \@applicantName} \\

	\begin{multicols}{2}{
			\textbf{Birth:} \@applicantBirth \\
			\textbf{Address:} \@applicantAddress
		}{
			\textbf{Email:} \@applicantEmail \\
			\textbf{Mobile:} \@applicantMobile
		}
	\end{multicols}
	\hline
}

