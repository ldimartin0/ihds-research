clear all

use "data/reg-sample.dta"

eststo: regress lwshourly_inf_adj literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability i.occup i.district i.caste if female == 0, cluster(id)

eststo: regress lwshourly_inf_adj literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability i.occup i.district i.caste if female == 1, cluster(id)


esttab * using "paper/tables/pooled-OLS-subsample.tex", noomitted nobaselevels se ar2 aic bic scalars(F) label replace compress ///
	title("\textbf{Pooled OLS Subsample Regression Results}") ///
	nonumbers ///
	mtitles("Men" "Women") ///
	drop(**.occup **.district **.caste, relax) ///
	indicate("Occupation FE's = *occup" "District FE's = *district") ///
	addnotes("All models include caste fixed effects.")

/*
esttab *, se ar2 aic bic scalars(F) label replace compress stats() ///
	title("\textbf{Pooled OLS Subsample Regression Results}") ///
	mgroups("Clustered SE's" "Full FE's", pattern(0 0 1 0) span) ///
	nonumbers nomtitles ///
	drop(**.occup **.district, relax) ///
	indicate("Occupation FE's = *occup" "District FE's = *district")
*/
