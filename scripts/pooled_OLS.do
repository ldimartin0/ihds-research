clear all

use "data/reg-sample.dta"

eststo: regress lwshourly_inf_adj female literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability i.caste, vce(robust)

eststo: regress lwshourly_inf_adj female literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability i.caste, cluster(id)

eststo: regress lwshourly_inf_adj female literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability i.occup i.caste, robust

eststo: regress lwshourly_inf_adj female literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability i.occup i.district i.caste, robust

esttab * using "paper/tables/pooled-OLS.tex", noomitted nobaselevels se ar2 aic bic scalars(F) label replace compress stats() ///
	title("\textbf{Pooled OLS Regression Results}") ///
	nonumbers mtitles("\textbf{White SE's}" "\textbf{Clustered SE's}" "\textbf{Occupation FE's}" "\textbf{District FE's}") ///
	drop(**.occup **.district **.caste, relax) ///
	indicate("Occupation FE's = *occup" "District FE's = *district") ///
	addnotes("All models include caste fixed effects.")

	