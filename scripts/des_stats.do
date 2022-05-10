clear all

use "data/reg-sample.dta"

label var inf_adj_wshourly "Inflation-adjusted hourly wages"

eststo: estpost sum wshourly lwshourly female literacy educ_yrs married age exper 
eststo: estpost sum wshourly lwshourly female literacy educ_yrs married age exper if female == 0
eststo: estpost sum wshourly lwshourly female literacy educ_yrs married age exper if female == 1

esttab * using "paper/tables/des-stats-1.tex", replace label mtitle("Full sample" "Men" "Women") main(mean %6.2f) aux(sd) title("Sample Descriptive Statistics")

eststo clear

eststo: estpost sum inf_adj_wshourly lwshourly_inf_adj female literacy educ_yrs married age exper
eststo: estpost sum inf_adj_wshourly lwshourly_inf_adj female literacy educ_yrs married age exper if female == 0
eststo: estpost sum inf_adj_wshourly lwshourly_inf_adj female literacy educ_yrs married age exper if female == 1

esttab * using "paper/tables/des-stats-2.tex", replace label mtitle("Full sample" "Men" "Women") main(mean %6.2f) aux(sd) title("Inflation-Adjusted Sample Descriptive Statistics")
