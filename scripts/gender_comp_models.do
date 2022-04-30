clear all

use "data/clean_indiv_data.dta"

preserve
drop if missing(lwshourly) | lwshourly > 7 | lwshourly < -1

eststo clear

eststo: sqreg lwshourly married literacy educ_yrs i.occup if female == 0, q(.1)
eststo: sqreg lwshourly married literacy educ_yrs i.occup if female == 1, q(.1)

esttab * using "paper/tables/lower-tail-gender-comp.tex", label replace //
	title("Subsample Regressions with Men and Women, $\tau$ = .1") ///
	mtitles("Men" "Women") ///
	drop(*.occup)
	

eststo clear

eststo: sqreg lwshourly married literacy educ_yrs i.occup if female == 0, q(.9)
eststo: sqreg lwshourly married literacy educ_yrs i.occup if female == 1, q(.9)

esttab * using "paper/tables/upper-tail-gender-comp.tex", label replace ///
	title("Subsample Regressions with Men and Women, $\tau$ = .9") ///
	mtitles("Men" "Women") ///
	drop(*.occup)
	