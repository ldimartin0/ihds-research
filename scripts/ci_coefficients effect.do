*gen coef_point_lb=coef1-1.96*coef2
*gen coef_point_ub=coef1+1.96*coef2

gen frac_coef1 = coef1/tot1
gen frac_coef3 = coef3/tot1
gen frac_coef4 = coef4/tot1
gen frac_coef_point_lb = coef_point_lb/tot1
gen frac_coef_point_ub = coef_point_ub/tot1


twoway (rarea frac_coef3 frac_coef4 quant1, bcolor(gs5)) (rarea frac_coef_point_lb frac_coef_point_ub quant1, bcolor(gs10)) (line frac_coef1 quant, lcolor(black)), xtitle("Quantile") ytitle("Quantile Effect") title(Effects of coefficients) legend(order(3 "Point estimates" 1 "Uniform 95% confidence bands" 2 "Pointwise 95% confidence intervals") rows(3))
