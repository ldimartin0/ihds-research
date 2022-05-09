clear all

use "data/reg-sample.dta"

eststo: sqreg lwshourly_inf_adj literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability i.occup i.district i.caste if female == 0, q(.2)
eststo: sqreg lwshourly_inf_adj literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability i.occup i.district i.caste if female == 1, q(.2)

esttab * using "paper/tables/qr-gendered-1st-quintile.tex", noomitted nobaselevels se ar2 aic bic scalars(F) label replace compress ///
	title("Subsample Regressions with Men and Women, $\tau$ = .2") ///
	nonumbers ///
	mtitles("Men" "Women") ///
	drop(**.occup **.district **.caste, relax) ///
	addnotes("Both models include occupation, district, and caste fixed effects.")
	
eststo clear
	
eststo: sqreg lwshourly_inf_adj literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability i.occup i.district i.caste if female == 0, q(.8)
eststo: sqreg lwshourly_inf_adj literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability i.occup i.district i.caste if female == 1, q(.8)

esttab * using "paper/tables/qr-gendered-5th-quintile.tex", noomitted nobaselevels se ar2 aic bic scalars(F) label replace compress ///
	title("Subsample Regressions with Men and Women, $\tau$ = .8") ///
	nonumbers ///
	mtitles("Men" "Women") ///
	drop(**.occup **.district **.caste, relax) ///
	addnotes("Both models include occupation, district, and caste fixed effects.")
