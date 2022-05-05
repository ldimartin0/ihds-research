clear all

use data/indiv-appended-long-panel.dta

tab STATEID PWAVES, row nofreq

tab RO3 PWAVES, row nofreq

ttest INCOME, by(RO3)
ttest WSHOURLY, by(RO3)
ttest POOR, by(RO3)

gen lwshourly = log(WSHOURLY)
pctile income_dec = INCOME, nq(10)
pctile wshourly_dec = WSHOURLY, nq(10)

hist wshourly_dec, by(RO3)

twoway (histogram lwshourly if RO3==2, color(red)) ///
       (histogram lwshourly if RO3==1, ///
	   fcolor(none) lcolor(blue)), legend(order(1 "Female" 2 "Male" ))
