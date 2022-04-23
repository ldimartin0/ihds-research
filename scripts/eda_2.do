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

* xtset id SURVEY

sqreg lwshourly female i.SURVEY benefits800, q(.1 .2 .3 .4 .5 .6 .7 .8 .9)
