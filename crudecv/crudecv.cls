\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{crudecv/crudecv}
\LoadClass[english,a4paper, 11pt]{report}

\RequirePackage{url} 				% Used for git url.
\RequirePackage{geometry}			% Used for layout settings.
\RequirePackage{titlesec}			% Used for section heddings
\RequirePackage[iso,english]{isodate}			% Used for birth date
\RequirePackage{tikz}				% Used for experience env.
\usetikzlibrary{positioning, shapes}
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
\DeclareOption{british}{
% Maketitle with name, birth, address, email, mobile and git information
	\renewcommand{\maketitle}{
		\noindent
		{\huge \textbf{\@applicantName}} \\	

		\noindent
		\begin{tabular*}{\textwidth}{l@{\extracolsep{\fill}}r}
			\textbf{d.o.b:} \printdate{\@applicantBirth} & \textbf{Address:} \@applicantAddress \\

			\textbf{Email:} \@applicantEmail & \textbf{Mobile:} \@applicantMobile \\

			\textbf{Git:}\url{\@applicantGit} & \\
		\end{tabular*}
		\rule{\textwidth}{2pt}
	}
}

\DeclareOption{norsk}{
% Maketitle with name, birth, address, email, mobile and git information
	\renewcommand{\maketitle}{
		\noindent
		{\huge \textbf{\@applicantName}} \\	

		\noindent
		\begin{tabular*}{\textwidth}{l@{\extracolsep{\fill}}r}
			\textbf{DOB:} \printdate{\@applicantBirth} & \textbf{Adresse:} \@applicantAddress \\

			\textbf{Epost:} \@applicantEmail & \textbf{Mobil:} \@applicantMobile \\

			\textbf{Git:}\url{\@applicantGit} & \\
		\end{tabular*}
		\rule{\textwidth}{2pt}
	}
}
\ProcessOptions
% Experience environment with counter
\newcounter{experienceCount} \newcounter{experienceLastCount} 
\newenvironment{experiences}{
	%Reset counters for each new instance of the environment.
 	\setcounter{experienceCount}{0} \setcounter{experienceLastCount}{0}
	\tikzset{
		lane/.style={rectangle},	%Used for seperating date and description.
		datePointer/.style={regular polygon, regular polygon sides=3,
			shape border rotate=90, draw, fill=black, anchor= south east,
			inner sep= 0mm, minimum width={0.3cm}},	% Used to mark date on timeline.
		dateDelimiter/.style={circle, draw, fill=black, 
			inner sep= 0mm, minimum width={1mm}},% Used to mark date on timeline.
		line/.style={draw},		%Used to make timeline.
		experience/.style={rectangle, inner sep= 2mm, text width ={(\textwidth/8)*5}} %Used as textbox for description.
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
		\node [experience, below=0mm of center] 
			(expname\arabic{experienceCount}) {\textbf{#1:} \\ #2};
	} \else { % If an experience already exists.
		% Create experience under last experience. Name it based on its nr. Fill textbox with description.
		\node [experience, below=1cm of expname\arabic{experienceLastCount}] 
			(expname\arabic{experienceCount}) {\textbf{#1:} \\ #2};
	}\fi
	
	% Create start and end date. Name it based on its nr.
	\node at (expname\arabic{experienceCount}.north west) [datePointer, pin=left:{(#4 - #3)}] 
		(expdate\arabic{experienceCount}end){};
	\node at (expname\arabic{experienceCount}.south west) [dateDelimiter] 
		(expdate\arabic{experienceCount}start){};

	\ifnum \value{experienceCount}> 1  % If experience exists already.
		% Connect timeline to last experience.
		\path [line, dashed] (expdate\arabic{experienceLastCount}start.south) -- (expdate\arabic{experienceCount}end.east);
	\fi
	% Connect timeline from end to start of current experience
	\path [line] (expdate\arabic{experienceCount}end.east) -- (expdate\arabic{experienceCount}start.north);

	% Note this experience for next iteration.
	\stepcounter{experienceLastCount}
}


% Skill level environment with counter
\newcounter{skillCount} \newcounter{skillLastLeftCount} 
\newenvironment{skills}{
	%Reset counters for each new instance of the environment.
 	\setcounter{skillCount}{0} \setcounter{skillLastLeftCount}{0}
	\tikzset{
		level/.style={circle, draw, text width={0.1cm}},	% Used to mark level of proficiency.
		levelEarned/.style={level, fill=black!50},			% Used to mark acquiered proficiency.
		levelUnearned/.style={level, fill=white},			% Used to mark lack of proficiency.
		line/.style={draw},							%Used to connect levels and creating borders.
		skill/.style={rectangle, minimum width={(\textwidth/2)},	
			text width={\textwidth/2}, inner sep=0cm,
			minimum height={1cm}} 					%Used to mark one skill row.
	}
	\begin{tikzpicture}[]
}{
	\end{tikzpicture}
}

% Takes a skill name and level
\newcommand{\skill}[2]{
	\stepcounter{skillCount} % Nr of current skill to create
	
	\ifodd \value{skillCount} { % If odd place left
		\ifnum \value{skillCount}<2 { % If first left place absolute.
			\node at (0,0) [skill] (skillname\arabic{skillCount}) {#1};
			\stepcounter{skillLastLeftCount}	% Mark current as last left.
		}\else {	% If other exist then place relative.
			\node [skill,  below=0cm of skillname\arabic{skillLastLeftCount})] 
				(skillname\arabic{skillCount}) {#1};
			\addtocounter{skillLastLeftCount}{2} % Note this skill for next two iteration.
		}\fi 
		\path[line] (skillname\arabic{skillCount}.north east) -- (skillname\arabic{skillCount}.south east); % Create border between left and right column.
	}\else {	% If even place right
		\node [skill, right=3mm of skillname\arabic{skillLastLeftCount})]
			(skillname\arabic{skillCount}) {#1}; %Place right of last left column skill.
	}\fi


	\foreach \level in {0,1,...,4} % Create proficiency scale
	{
		\ifnum #2 > \level { % If proficiency is higher than created level.
			\node[levelEarned, left= 5cm - \level cm of skillname\arabic{skillCount}.east] 
				(level\arabic{skillCount}and\level){};
		} \else {	% If proficiency is lower than created level.
			\node[levelUnearned, left= 5cm - \level cm of skillname\arabic{skillCount}.east] 
				(level\arabic{skillCount}and\level){};
		}\fi
	}

	\foreach \from [count=\to from 1] in {0,1,...,3} % Connect levels as scale.
	{
		\path[line] (level\arabic{skillCount}and\from) -- (level\arabic{skillCount}and\to);
	}
	
}