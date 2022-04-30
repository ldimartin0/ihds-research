clear all

use "data/clean_indiv_data.dta"

drop if missing(lwshourly) | missing(literacy) | missing(occup) | missing(married) | lwshourly > 7 | lwshourly < -1 | missing(educ_yrs) | missing(age)

sample 40

tab occup, gen(occ)

rqdeco lwshourly educ_yrs literacy married age occ**, by(female) quantile(.1 .2 .3 .4 .5 .6 .7 .8 .9) reps(10) saving("data/rqdeco_test")
