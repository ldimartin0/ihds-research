clear all

use "data/clean_indiv_data.dta"

drop if missing(lwshourly) | missing(literacy) | missing(occup) | missing(married) | lwshourly > 7 | lwshourly < -1 | missing(educ_yrs) | missing(age)


eststo: regress lwshourly literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability survey if female == 0, cluster(id)

eststo: regress lwshourly literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability survey if female == 1, cluster(id)

eststo: regress lwshourly literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability survey i.occup i.district if female == 0, cluster(id)

eststo: regress lwshourly literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability survey i.occup i.district if female == 1, cluster(id)


esttab * using "paper/tables/pooled-OLS-subsample.tex", se ar2 aic bic scalars(F) label replace compress ///
	title("\textbf{Pooled OLS Subsample Regression Results}") ///
	mgroups("Clustered SE's" "Full FE's", pattern(1 0 1 0) ///
	prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat()) ///
	nonumbers ///
	mtitles("Men" "Women" "Men" "Women") ///
	drop(**.occup **.district, relax) ///
	indicate("Occupation FE's = *occup" "District FE's = *district")


esttab *, se ar2 aic bic scalars(F) label replace compress stats() ///
	title("\textbf{Pooled OLS Subsample Regression Results}") ///
	mgroups("Clustered SE's" "Full FE's", pattern(0 0 1 0) span) ///
	nonumbers nomtitles ///
	drop(**.occup **.district, relax) ///
	indicate("Occupation FE's = *occup" "District FE's = *district")
