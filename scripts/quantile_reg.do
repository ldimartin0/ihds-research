clear all

use "data/clean_indiv_data.dta"

drop if missing(lwshourly) | missing(literacy) | missing(occup) | missing(married) | lwshourly > 7 | lwshourly < -1 | missing(educ_yrs) | missing(age)

qrprocess lwshourly female literacy age survey, quantiles(.1(.05).9) 
