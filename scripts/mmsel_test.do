clear all

use "data/clean_indiv_data.dta"

drop if missing(lwshourly) | missing(literacy) | missing(occup) | missing(married) | lwshourly > 7 | lwshourly < -1 | missing(educ_yrs) | missing(age)


sample 10
ren id pid
mmsel lwshourly educ_yrs literacy married age, group(female) pooled reps(5) filename(mmsel_attempt1)
