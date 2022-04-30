clear all

use "data/compressed_indiv_data.dta"

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

drop if occup == 27 | occup == 28 | occup == 46 | occup == 47 | occup == 48 | occup == 70 | occup == 58 // eliminate unlabelled occupations

replace occup = 0 if occup == 1 // group physical scientists
replace occup = 5 if occup == 6 // group life scientists
replace occup = 13 if occup == 10 | occup == 11 // group social scientists
drop if occup > 100 // drop fake occupations


save "data/clean_indiv_data.dta", replace
