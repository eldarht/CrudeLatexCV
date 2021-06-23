\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{crudecv/crudecv}
\LoadClass[a4paper, 11pt]{report}

\RequirePackage{url} 				% Used for git url.
\RequirePackage{geometry}			% Used for layout settings.
\usepackage{titlesec}				% Used for section heddings

% Layout settings
\geometry{margin=0.5in}		
\pagestyle{empty}					% Removing header/footer.

% Section settings
\titleformat{\section}
{\Large\bfseries}{\thesection}{1em}{}[{\titlerule[1pt]}]

% For setting info used in the tilte
\newcommand{\applicantName}[1]{\newcommand{\@applicantName}{#1}}
\newcommand{\applicantBirth}[1]{\newcommand{\@applicantBirth}{#1}}
\newcommand{\applicantAddress}[1]{\newcommand{\@applicantAddress}{#1}}
\newcommand{\applicantEmail}[1]{\newcommand{\@applicantEmail}{#1}}
\newcommand{\applicantMobile}[1]{\newcommand{\@applicantMobile}{#1}}
\newcommand{\applicantGit}[1]{\newcommand{\@applicantGit}{#1}}

\newcommand{\applicant}[6][\@author]{
	\applicantName{#1}
	\applicantBirth{#2}
	\applicantAddress{#3}
	\applicantEmail{#4}
	\applicantMobile{#5}
	\applicantGit{#6}

}

% Maketitle with name, birth, address, email, mobile and git information
\renewcommand{\maketitle}{
	\noindent
	{\huge \textbf{\@applicantName}} \\	

	\noindent
	\begin{tabular*}{\textwidth}{l@{\extracolsep{\fill}}r}
		\textbf{Birth:} \@applicantBirth & \textbf{Address:} \@applicantAddress \\

		\textbf{Email:} \@applicantEmail & \textbf{Mobile:} \@applicantMobile \\

		\textbf{Mobile:}\url{\@applicantGit} & \\
	\end{tabular*}
	\rule{\textwidth}{2pt}
}
