clear all

use "data/clean_indiv_data.dta"

preserve
drop if missing(lwshourly) | lwshourly > 7 | lwshourly < -1

eststo: sqreg lwshourly female married literacy educ_yrs college_subj occup_gen i.STATEID, q(.2)
eststo: sqreg lwshourly female married literacy educ_yrs college_subj occup_gen i.STATEID, q(.4)
eststo: sqreg lwshourly female married literacy educ_yrs college_subj occup_gen i.STATEID, q(.6)
eststo: sqreg lwshourly female married literacy educ_yrs college_subj occup_gen i.STATEID, q(.8)

esttab * using "paper/tables/big-model.tex", label replace
