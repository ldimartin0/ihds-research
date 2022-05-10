clear all

use "data/reg-sample.dta"

qrprocess lwshourly_inf_adj literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability i.occup i.caste, quantiles(.1(.05).9)

est store quant_reg

qrprocess lwshourly_inf_adj literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability i.occup i.district i.caste, quantiles(.1(.05).9) 

est store quant_reg_big

