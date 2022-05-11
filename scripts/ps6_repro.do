clear all

/*** This is a messy do-file that reproduces the results for problem set 6. I have this script organized into many different modular scripts. The results are displayed with esttab, my preferred table-rendering package for Stata. Since I export straight to LaTeX, the tables might get weird.

The quantile regressions take about 8 hours to fit (on my 2GHz i5 + 16 GB 3733 MHz 2020 Mac) so I did not bother including the code for them. Regardless, the scripts are publicly accessible on my GitHub here:

https://github.com/ldimartin0/ihds-research/tree/main/scripts
***/




use "data/indiv-appended-long-panel.dta"

compress

/*
Creating some utility control variables
*/

* FEMALE
gen female=(RO3==2) if RO3==1 |  RO3==2
* tab RO3 female, m

* DISTRICT FIXED EFFECTS
bysort STATEID: tab DISTID
egen district=group(STATEID DISTID)
*codebook STATEID DISTID district

* ID FOR PANEL
egen id=group(HHBASE PBASE)
egen freq=count(id), by(id)
* tab freq, m
* tab PWAVES

* LOG WAGES
gen lwshourly = ln(WSHOURLY)

* BENEFITS
* centile INCBENEFITS, centile(0(10)100)
gen benefits800=(INCBENEFITS>800) if INCBENEFITS<. //benefits threshold of 800 rupees
* tab benefits800, m

* MARITAL STATUS
gen married = .
replace married = 1 if RO6 == 0 | RO6 == 1
replace married = 0 if RO6 > 1 & !missing(RO6)
label var married "Marital Status"

* ACTIVITY STATUS
ren RO7 occup_gen

* renaming education vars
ren ED2 literacy
label var literacy "Literacy"

ren ED3 english_ability
label define eng_abilities 0 "No English Ability"  1 "Little English Ability" 2 "English Fluency"
label values english_ability eng_abilities


ren ED4 schooled

ren ED6 educ_yrs
label var educ_yrs "Years of Education"

ren ED10 college_subj
ren ED11 college_or_voc

ren ED12 highest_qual
label var highest_qual "Highest Degree Acheived"

gen grad_degree = 0
replace grad_degree = 1 if highest_qual == 5 | highest_qual == 6
label var grad_degree "Graduate Degree"

ren CS9 english_yrs
label var english_yrs "Years of English Instruction"

ren RO5 age
label var age "Age"

gen age_sq = age^2
label var age_sq "Squared Age"

ren WS4 occup
label var occup "Occupation"

ren IN12Y prog_inc
label var prog_inc "Program Income"

replace occup = 0 if occup == 1 // group physical scientists
replace occup = 5 if occup == 6 // group life scientists
replace occup = 13 if occup == 10 | occup == 11 // group social scientists


gen survey = SURVEY - 1

gen inf_adj_wshourly = WSHOURLY
replace inf_adj_wshourly = 1.68032*WSHOURLY if survey == 0
label var inf_adj_wshourly "Inflation-adjusted hourly wages"

gen lwshourly_inf_adj = ln(inf_adj_wshourly)

label var lwshourly_inf_adj "Log hourly wages"
ren WSHOURLY wshourly

drop if missing(lwshourly)
dis _N // display how many observations from raw data have hourly wage data

/* add new vars here, and then make sure to drop missing below */

ren GROUPS6 caste
label var caste "Caste"

gen missing_indep = 0
replace missing_indep = 1 if occup == 27 | occup == 28 | occup == 46 | occup == 47 | occup == 48 | occup == 70 | occup == 58 | occup > 100 | missing(literacy) | missing(occup) | missing(married) | missing(educ_yrs) | missing(age) | missing(grad_degree) | missing(prog_inc) | missing(english_ability) | missing(district) | missing(survey) | missing(caste)
tab missing_indep


/* ROBUSTNESS TESTS
*tabstat lwshourly female, by(missing_indep)
*ttest lwshourly, by(missing_indep)
*ttest female, by(missing_indep)

Some robustness tests for the missing indep variables. It appears that there is a statistically significant difference in wages and gender between the observations with a full set for the independent variables and those without.

*/
drop if occup == 27 | occup == 28 | occup == 46 | occup == 47 | occup == 48 | occup == 70 | occup == 58 | occup > 100 // drop fake occupations

drop if missing(literacy) | missing(occup) | missing(married) | missing(educ_yrs) | missing(age) | missing(grad_degree) | missing(prog_inc) | missing(english_ability) | missing(district) | missing(survey) | missing(caste)

dis _N

prog def out3IQR
    dis "3*IQR outliers for `1' by `2' `3' `4' `5' `6'"
	qui egen IQR`1'=iqr(`1'), by(`2' `3' `4' `5' `6')
	qui egen P25`1'=pctile(`1'), p(25) by(`2' `3' `4' `5' `6')
	qui egen P75`1'=pctile(`1'), p(75) by(`2' `3' `4' `5' `6')
	qui gen I`1'=(`1'>P75`1'+3*IQR`1' | `1'<P25`1'-3*IQR`1') if ///
		`1'<. & IQR`1'<. & P25`1'<. & P75`1'<.
	qui gen `1'I=`1' if I`1'!=1
	drop IQR`1' P25`1' P75`1'
end

out3IQR lwshourly

sum lwshourly lwshourlyI

drop if missing(lwshourlyI)

drop if age < 15 | age > 65

ren WSHOURS hrs_worked_yr

drop if hrs_worked_yr < 65

replace educ_yrs = educ_yrs + 3 if grad_degree == 1 /* Per Agrawal2014, grad degree is three additional years */

gen exper = age - 5 - educ_yrs /* again, per Agrawal2014 */
label var exper "Years of Pot. Experience"

/*** CLEANING SECTION COMPLETE ***/

eststo: regress lwshourly_inf_adj female literacy educ_yrs exper married age_sq grad_degree prog_inc i.english_ability i.caste, vce(robust)

eststo: regress lwshourly_inf_adj female literacy educ_yrs exper married age_sq grad_degree prog_inc i.english_ability i.caste, cluster(id)

eststo: regress lwshourly_inf_adj female literacy educ_yrs exper married age_sq grad_degree prog_inc i.english_ability i.occup i.caste, robust

eststo: regress lwshourly_inf_adj female literacy educ_yrs exper married age_sq grad_degree prog_inc i.english_ability i.occup i.district i.caste, robust

esttab *, noomitted nobaselevels label replace compress ///
	*title("\textbf{Pooled OLS Regression Results}") ///
	*nonumbers mtitles("\textbf{White SE's}" "\textbf{Clustered SE's}" "\textbf{Occupation FE's}" "\textbf{District FE's}") ///
	drop(**.occup **.district **.caste age_sq grad_degree prog_inc *.english_ability, relax) 
	///
	*indicate("Occupation FE's = *occup" "District FE's = *district") ///
	*substitute([htbp] [!htbp] \begin{tabular} \small\begin{tabular} {l} {p{\linewidth}}) ///
	*addnotes("All models include caste fixed effects." "Additional controls include squared age, indicators for graduate degree holders program income, little english ability, and english fluency.")

eststo clear
	
eststo: regress lwshourly_inf_adj literacy educ_yrs exper married age_sq grad_degree prog_inc i.english_ability i.occup i.district i.caste if female == 0, cluster(id)

eststo: regress lwshourly_inf_adj literacy educ_yrs exper married age_sq grad_degree prog_inc i.english_ability i.occup i.district i.caste if female == 1, cluster(id)


esttab *  noomitted nobaselevels label replace compress ///
	*title("\textbf{Pooled OLS Subsample Regression Results}") ///
	*nonumbers ///
	mtitles("Men" "Women") ///
	drop(**.occup **.district **.caste age_sq grad_degree prog_inc *.english_ability, relax) ///
	*indicate("Occupation FE's = *occup" "District FE's = *district") ///
	*substitute([htbp] [!htbp] \begin{tabular} \small\begin{tabular} {l} {p{\linewidth}}) ///
	*addnotes("All models include caste fixed effects." "Additional controls include squared age, indicators for graduate degree holders, program income, little english ability, and english fluency.")
