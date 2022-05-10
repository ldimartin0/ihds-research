clear all

use "data/reg-sample.dta"

eststo: regress lwshourly_inf_adj female literacy educ_yrs exper married age_sq grad_degree prog_inc i.english_ability i.caste, vce(robust)

eststo: regress lwshourly_inf_adj female literacy educ_yrs exper married age_sq grad_degree prog_inc i.english_ability i.caste, cluster(id)

eststo: regress lwshourly_inf_adj female literacy educ_yrs exper married age_sq grad_degree prog_inc i.english_ability i.occup i.caste, robust

eststo: regress lwshourly_inf_adj female literacy educ_yrs exper married age_sq grad_degree prog_inc i.english_ability i.occup i.district i.caste, robust

esttab * using "paper/tables/pooled-OLS.tex", noomitted nobaselevels se ar2 aic bic scalars(F) label replace compress booktabs width("\linewidth") float ///
	title("\textbf{Pooled OLS Regression Results}") ///
	nonumbers mtitles("\textbf{White SE's}" "\textbf{Clustered SE's}" "\textbf{Occupation FE's}" "\textbf{District FE's}") ///
	drop(**.occup **.district **.caste age_sq grad_degree prog_inc *.english_ability, relax) ///
	indicate("Occupation FE's = *occup" "District FE's = *district") ///
	substitute([htbp] [!htbp] \begin{tabular} \small\begin{tabular} {l} {p{\linewidth}}) ///
	addnotes("All models include caste fixed effects." "Additional controls include squared age, indicators for graduate degree holders program income, little english ability, and english fluency.")

eststo clear
	
eststo: regress lwshourly_inf_adj literacy educ_yrs exper married age_sq grad_degree prog_inc i.english_ability i.occup i.district i.caste if female == 0, cluster(id)

eststo: regress lwshourly_inf_adj literacy educ_yrs exper married age_sq grad_degree prog_inc i.english_ability i.occup i.district i.caste if female == 1, cluster(id)


esttab * using "paper/tables/pooled-OLS-subsample.tex", noomitted nobaselevels se ar2 aic bic scalars(F) label replace compress booktabs width("\hsize") float ///
	title("\textbf{Pooled OLS Subsample Regression Results}") ///
	nonumbers ///
	mtitles("Men" "Women") ///
	drop(**.occup **.district **.caste age_sq grad_degree prog_inc *.english_ability, relax) ///
	indicate("Occupation FE's = *occup" "District FE's = *district") ///
	substitute([htbp] [!htbp] \begin{tabular} \small\begin{tabular} {l} {p{\linewidth}}) ///
	addnotes("All models include caste fixed effects." "Additional controls include squared age, indicators for graduate degree holders, program income, little english ability, and english fluency.")
