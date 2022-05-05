clear all

use "data/clean_indiv_data.dta"

drop if missing(lwshourly)

drop if occup == 27 | occup == 28 | occup == 46 | occup == 47 | occup == 48 | occup == 70 | occup == 58 | occup > 100 // drop fake occupations

drop if missing(literacy) | missing(occup) | missing(married) | missing(educ_yrs) | missing(age) | missing(grad_degree) | missing(prog_inc) | missing(english_ability) | missing(district) | missing(survey)

save "data/reg-sample.dta", replace
