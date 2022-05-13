clear all

use "data/reg-sample.dta"

qrprocess lwshourly_inf_adj literacy educ_yrs married age_sq grad_degree prog_inc exper i.english_ability i.occup i.caste if female == 1, quantiles(.1(.05).9)

est store quant_reg_women_small

qrprocess lwshourly_inf_adj literacy educ_yrs married age_sq grad_degree prog_inc exper i.english_ability i.occup i.district i.caste if female == 1, quantiles(.1(.05).9) 

est store quant_reg_women



