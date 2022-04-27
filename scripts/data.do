clear all

use "data/indiv-appended-long-panel.dta"

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

* ACTIVITY STATUS
ren RO7 occup_gen

* renaming education vars
ren ED2 literacy
ren ED3 english_ability
ren ED4 schooled
ren ED6 educ_yrs
ren ED10 college_subj
ren ED11 college_or_voc
ren ED12 highest_qual
ren CS9 english_yrs

compress

save "data/clean_indiv_data.dta", replace
