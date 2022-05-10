clear all

use "data/clean_indiv_data.dta"

drop if missing(lwshourly)
dis _N // display how many observations from raw data have hourly wage data

/* add new vars here, and then make sure to drop missing below */

ren GROUPS6 caste
label var caste "Caste"

gen missing_indep = 0
replace missing_indep = 1 if occup == 27 | occup == 28 | occup == 46 | occup == 47 | occup == 48 | occup == 70 | occup == 58 | occup > 100 | missing(literacy) | missing(occup) | missing(married) | missing(educ_yrs) | missing(age) | missing(grad_degree) | missing(prog_inc) | missing(english_ability) | missing(district) | missing(survey) | missing(caste)
tab missing_indep


/* ROBUSTNESS TESTS
*tabstat lwshourly female, by(missing_indep)
*ttest lwshourly, by(missing_indep)
*ttest female, by(missing_indep)

Some robustness tests for the missing indep variables. It appears that there is a statistically significant difference in wages and gender between the observations with a full set for the independent variables and those without.

*/
drop if occup == 27 | occup == 28 | occup == 46 | occup == 47 | occup == 48 | occup == 70 | occup == 58 | occup > 100 // drop fake occupations

drop if missing(literacy) | missing(occup) | missing(married) | missing(educ_yrs) | missing(age) | missing(grad_degree) | missing(prog_inc) | missing(english_ability) | missing(district) | missing(survey) | missing(caste)

dis _N

prog def out3IQR
    dis "3*IQR outliers for `1' by `2' `3' `4' `5' `6'"
	qui egen IQR`1'=iqr(`1'), by(`2' `3' `4' `5' `6')
	qui egen P25`1'=pctile(`1'), p(25) by(`2' `3' `4' `5' `6')
	qui egen P75`1'=pctile(`1'), p(75) by(`2' `3' `4' `5' `6')
	qui gen I`1'=(`1'>P75`1'+3*IQR`1' | `1'<P25`1'-3*IQR`1') if ///
		`1'<. & IQR`1'<. & P25`1'<. & P75`1'<.
	qui gen `1'I=`1' if I`1'!=1
	drop IQR`1' P25`1' P75`1'
end

out3IQR lwshourly

sum lwshourly lwshourlyI

drop if missing(lwshourlyI)

drop if age < 15 | age > 65

ren WSHOURS hrs_worked_yr

drop if hrs_worked_yr < 65

replace educ_yrs = educ_yrs + 3 if grad_degree == 1 /* Per Agrawal2014, grad degree is three additional years */

gen exper = age - 5 - educ_yrs /* again, per Agrawal2014 */
label var exper "Years of Pot. Experience"

save "data/reg-sample.dta", replace
