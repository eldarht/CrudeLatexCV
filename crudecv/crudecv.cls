\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{crudecv/crudecv}
\LoadClass[english,a4paper, 11pt]{report}

\RequirePackage{url} 				% Used for git url.
\RequirePackage{geometry}			% Used for layout settings.
\RequirePackage{titlesec}			% Used for section heddings
\RequirePackage[iso,english]{isodate}			% Used for birth date
\RequirePackage{tikz}				% Used for experience env.
\usetikzlibrary{positioning}
% Layout settings
\geometry{margin=0.5in}		
\pagestyle{empty}					% Removing header/footer.

% Language and date settings
\isodate

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
		\textbf{Birth:} \printdate{\@applicantBirth} & \textbf{Address:} \@applicantAddress \\

		\textbf{Email:} \@applicantEmail & \textbf{Mobile:} \@applicantMobile \\

		\textbf{Git:}\url{\@applicantGit} & \\
	\end{tabular*}
	\rule{\textwidth}{2pt}
}

% Experience environment with counter
\newcounter{experienceCount} \newcounter{experienceLastCount} 
\newenvironment{experiences}{
	%Reset counters for each new instance of the environment.
 	\setcounter{experienceCount}{0} \setcounter{experienceLastCount}{0}
	\tikzset{
		lane/.style={rectangle},	%Used for seperating date and description.
		date/.style={circle, draw, text width={0.1cm}},	% Used to mark date on timeline.
		line/.style={draw},		%Used to make timeline.
		experience/.style={rectangle, text width ={(\textwidth/5)*3}} %Used as textbox for description.
	}
	\begin{tikzpicture}[]
	
	% Guide lanes
	\node [lane, minimum width={\textwidth/5}] (left) {};		% Date/timeline section
	\node [lane, minimum width={(\textwidth/5)*3},right=0mm of left] (center) {}; % Description section
}{
	\end{tikzpicture}

}

% Takes name, description, start year, end year and creates an experience row in experience environment.
\newcommand{\experience}[4]{
	\stepcounter{experienceCount} % Nr of current experience to create
	
	\ifnum \value{experienceCount}<2 { % If first experience
		% Create experience in correct lane. Name it based on its nr. Fill textbox with description.
		\node [experience, below=0mm of center] (expname\arabic{experienceCount}) {\textbf{#1:} #2};
	} \else { % If an experience already exists.
		% Create experience under last experience. Name it based on its nr. Fill textbox with description.
		\node [experience, below=1cm of expname\arabic{experienceLastCount}] (expname\arabic{experienceCount}) {\textbf{#1:} #2};
	}\fi
	
	% Create start and end date. Name it based on its nr.
	\node [date, left=of expname\arabic{experienceCount}.north west, pin=left:#4, ] 
		(expdate\arabic{experienceCount}end){};
	\node [date, left=of expname\arabic{experienceCount}.south west, pin=left:#3, ] 
		(expdate\arabic{experienceCount}start){};

	\ifnum \value{experienceCount}> 1  % If experience exists already.
		% Connect timeline to last experience.
		\path [line] (expdate\arabic{experienceLastCount}start.south) -- (expdate\arabic{experienceCount}end.north);
	\fi
	% Connect timeline from end to start of current experience
	\path [line] (expdate\arabic{experienceCount}end.south) -- (expdate\arabic{experienceCount}start.north);

	% Note this experience as for next iteration.
	\stepcounter{experienceLastCount}
}