clear all

use "data/clean_indiv_data.dta"

preserve
drop if missing(lwshourly) | lwshourly > 6 | lwshourly < 0
eststo: sqreg lwshourly female married literacy educ_yrs college_subj occup_gen i.STATEID, q(.2 .4 .6 .8)

