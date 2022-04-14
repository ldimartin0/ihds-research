texdoc init "submissions/ps5.tex", replace

/***
\documentclass[a4paper]{article}

\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{amsmath, amssymb}
\usepackage{stata}
\usepackage{graphicx}

%\renewcommand{\thesubsection}{\thesection.\alph{subsection}}

\title{Problem Set 5 Figures}
\author{Luke DiMartino}

\begin{document}
\maketitle

I am analyzing data from the India Human Development Survey. My focus is on gender disparities and the effects of education on them.

My baseline hypothesis, of course, is that there is a difference in wealth and income between men and women. The variables are intuitively named, except \verb|RO3|, which is the indicator for sex.

This is a panel dataset, so first I'll report basic statistics about the balance of the panel, with panel survival by state and by sex.
***/
clear all 
log using "submissions/ps5.smcl", replace
use "data/indiv-appended-long-panel.dta"

texdoc stlog
tab STATEID PWAVES, row nofreq

tab RO3 PWAVES, row nofreq

ttest INCOME, by(RO3)
texdoc stlog close
/***
This $t$-test shows that there is a highly statistically significant naive difference in income between men and women.
***/
texdoc stlog
ttest WSHOURLY, by(RO3)
texdoc stlog close
/***
This $t$-test shows that there is a highly statistically significant naive difference in hourly wage between men and women --- on average, men earn about 12 rupees more per hour than women.
***/
texdoc stlog
ttest POOR, by(RO3)
texdoc stlog close
/***
This $t$-test shows that there is a highly statistically significant naive difference in poverty between men and women --- women are about 1.1 percentage points more likely to be poor.
***/
texdoc stlog
gen lwshourly = log(WSHOURLY)
pctile income_dec = INCOME, nq(10)
pctile wshourly_dec = WSHOURLY, nq(10)
hist wshourly_dec, by(RO3)
texdoc stlog close
texdoc graph, optargs(width=.6\textwidth)
/***
The histogram of hourly wages has tails far too long to be meaningful, but this histogram grouped by decile shows the difference in the wage distribution between men and women. 
***/
texdoc stlog
twoway (histogram lwshourly if RO3==2, color(red)) ///
       (histogram lwshourly if RO3==1, ///
	   fcolor(none) lcolor(blue)), legend(order(1 "Female" 2 "Male" ))
texdoc stlog close
texdoc graph, optargs(width=.6\textwidth)
/***
This histogram shows the difference in log hourly wage distributions between men and women.

Going forward, my plan is to clean the income and wage data to get more accurate measures, including determining what to do with outliers and negative results. Then, I will construct control variables from the relevant variables in the survey. From there, I should be able to develop a fundamental OLS model with broad controls.

Then, I will develop a household fixed effects model and investigate potential instruments for gender-equality-related independent variables.

\end{document}
***/

log close
