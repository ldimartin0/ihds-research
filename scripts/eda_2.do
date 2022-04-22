clear all

use "data/indiv-appended-long-panel.dta"

/*
Creating some utility control variables
*/

gen female=(RO3==2) if RO3==1 |  RO3==2
* tab RO3 female, m

bysort STATEID: tab DISTID
egen district=group(STATEID DISTID)
*codebook STATEID DISTID district

egen id=group(HHBASE PBASE)
egen freq=count(id), by(id)
* tab freq, m
* tab PWAVES

gen lwshourly = ln(WSHOURLY)

* xtset id SURVEY
