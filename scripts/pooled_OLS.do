clear all

use "data/clean_indiv_data.dta"

eststo: regress lwshourly female literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability survey, vce(robust)

eststo: regress lwshourly female literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability survey, cluster(id)

eststo: regress lwshourly female literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability survey i.occup, robust

eststo: regress lwshourly female literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability survey i.occup i.district, robust

esttab * using "paper/tables/pooled-OLS.tex", se ar2 aic bic scalars(F) label replace compress stats() ///
	title("\textbf{Pooled OLS Regression Results}") ///
	nonumbers mtitles("\textbf{White SE's}" "\textbf{Clustered SE's}" "\textbf{Occupation FE's}" "\textbf{District FE's}") ///
	drop(**.occup **.district, relax) ///
	indicate("Occupation FE's = *occup" "District FE's = *district")

	