clear all

use "data/clean_indiv_data.dta"

preserve
drop if missing(lwshourly) | lwshourly > 7 | lwshourly < -1

eststo: qreg lwshourly married literacy educ_yrs age i.occup if female == 0, quantile(.1) vce(robust)
est store M

eststo: qreg lwshourly married literacy educ_yrs age i.occup if female == 1, quantile(.1) vce(robust)
est store W


esttab * using "paper/tables/lower-tail-gender-comp-robust.tex", label replace //
	title("Subsample Regressions with Men and Women, $\tau$ = .1") ///
	mtitles("Men" "Women") ///
	drop(*.occup)
