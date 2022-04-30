clear all

use "data/clean_indiv_data.dta"

drop if missing(lwshourly) | missing(literacy) | missing(occup) | missing(married) | missing(educ_yrs) | missing(age)

qui tab occup, gen(occ)
qui tab STATEID, gen(stateid)
qui tab district, gen(dist)


*cdeco lwshourly educ_yrs literacy married age occ** dist***, group(female) method(lpm) nreg(10) reps(10) saving("data/counterfactual_test_district_fe") cons_test(.1 .9) noprintdeco

*cdeco lwshourly educ_yrs literacy married age occ** stateid**, group(female) method(lpm) nreg(10) reps(10) saving("data/counterfactual_test_state_fe") cons_test(.1 .9) noprintdeco

*cdeco lwshourly educ_yrs literacy married age age_sq grad_degree prog_inc eng_ab occ**, group(female) method(lpm) nreg(20) reps(20) saving("data/counterfactual_test_big_2") cons_test(.1 .9) noprintdeco

mat tot=e(total_difference)
mat char=e(characteristics)
mat coef=e(coefficients)
mat quant=e(quantiles)
svmat tot 
svmat char 
svmat coef
svmat quant

twoway (line tot1 quant1) (line char1 quant1) (line coef1 quant1), ytitle(Quantile Effect) xtitle(Quantile) legend(order(1 "Total difference" 2 "Effects of characteristics" 3 "Effects of coefficients"))

gen coef_point_lb=coef1-1.96*coef2
gen coef_point_ub=coef1+1.96*coef2
twoway (rarea coef3 coef4 quant1, bcolor(gs5)) (rarea coef_point_lb coef_point_ub quant1, bcolor(gs10)) (line coef1 quant, lcolor(black)), xtitle("Quantile") ytitle("Quantile Effect") title(Effects of coefficients) legend(order(3 "Point estimates" 1 "Uniform 95% confidence bands" 2 "Pointwise 95% confidence intervals") rows(3))

*rqdeco lwshourly educ_yrs literacy married age occ**, group(female) quantile(.1 .2 .3 .4 .5 .6 .7 .8 .9) method(lpm) nreg(10) reps(10) saving("data/counterfactual_test_4") cons_test(.1 .9)
