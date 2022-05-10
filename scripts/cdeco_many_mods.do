
/*
cdeco lwshourly_inf_adj literacy educ_yrs married age age_sq grad_degree prog_inc eng_ab2 eng_ab3 castes1 castes2 castes3 castes4 castes5 castes6 occ1 occ2 occ3 occ4 occ5 occ6 occ7 occ8 occ9 occ10 occ11 occ12 occ13 occ14 occ15 occ16 occ17 occ18 occ19 occ20 occ21 occ22 occ23 occ24 occ25 occ26 occ27 occ28 occ29 occ30 occ31 occ32 occ33 occ34 occ35 occ36 occ37 occ38 occ39 occ40 occ41 occ42 occ43 occ44 occ45 occ46 occ47 occ48 occ49 occ50 occ51 occ52 occ53 occ54 occ55 occ56 occ57 occ58 occ59 occ60 occ61 occ62 occ63 occ64 occ65 occ66 occ67 occ68 occ69 occ70 occ71 occ72 occ73 occ74 occ75 occ76 occ77 occ78 occ79 occ80 occ81 occ82 occ83 occ84 occ85 occ86 occ87 occ88 dist1 dist2 dist3 dist4 dist5 dist6 dist7 dist8 dist9 dist10 dist11 dist12 dist13 dist14 dist15 dist16 dist17 dist18 dist19 dist20 dist21 dist22 dist23 dist24 dist25 dist26 dist27 dist28 dist29 dist30 dist31 dist32 dist33 dist34 dist35 dist36 dist37 dist38 dist39 dist40 dist41 dist42 dist43 dist44 dist45 dist46 dist47 dist48 dist49 dist50 dist51 dist52 dist53 dist54 dist55 dist56 dist57 dist58 dist59 dist60 dist61 dist62 dist63 dist64 dist65 dist66 dist67 dist68 dist69 dist70 dist71 dist72 dist73 dist74 dist75 dist76 dist77 dist78 dist79 dist80 dist81 dist82 dist83 dist84 dist85 dist86 dist87 dist88 dist89 dist90 dist91 dist92 dist93 dist94 dist95 dist96 dist97 dist98 dist99 dist100 dist101 dist102 dist103 dist104 dist105 dist106 dist107 dist108 dist109 dist110 dist111 dist112 dist113 dist114 dist115 dist116 dist117 dist118 dist119 dist120 dist121 dist122 dist123 dist124 dist125 dist126 dist127 dist128 dist129 dist130 dist131 dist132 dist133 dist134 dist135 dist136 dist137 dist138 dist139 dist140 dist141 dist142 dist143 dist144 dist145 dist146 dist147 dist148 dist149 dist150 dist151 dist152 dist153 dist154 dist155 dist156 dist157 dist158 dist159 dist160 dist161 dist162 dist163 dist164 dist165 dist166 dist167 dist168 dist169 dist170 dist171 dist172 dist173 dist174 dist175 dist176 dist177 dist178 dist179 dist180 dist181 dist182 dist183 dist184 dist185 dist186 dist187 dist188 dist189 dist190 dist191 dist192 dist193 dist194 dist195 dist196 dist197 dist198 dist199 dist200 dist201 dist202 dist203 dist204 dist205 dist206 dist207 dist208 dist209 dist210 dist211 dist212 dist213 dist214 dist215 dist216 dist217 dist218 dist219 dist220 dist221 dist222 dist223 dist224 dist225 dist226 dist227 dist228 dist229 dist230 dist231 dist232 dist233 dist234 dist235 dist236 dist237 dist238 dist239 dist240 dist241 dist242 dist243 dist244 dist245 dist246 dist247 dist248 dist249 dist250 dist251 dist252 dist253 dist254 dist255 dist256 dist257 dist258 dist259 dist260 dist261 dist262 dist263 dist264 dist265 dist266 dist267 dist268 dist269 dist270 dist271 dist272 dist273 dist274 dist275 dist276 dist277 dist278 dist279 dist280 dist281 dist282 dist283 dist284 dist285 dist286 dist287 dist288 dist289 dist290 dist291 dist292 dist293 dist294 dist295 dist296 dist297 dist298 dist299 dist300 dist301 dist302 dist303 dist304 dist305 dist306 dist307 dist308 dist309 dist310 dist311 dist312 dist313 dist314 dist315 dist316 dist317 dist318 dist319 dist320 dist321 dist322 dist323 dist324 dist325 dist326 dist327 dist328 dist329 dist330 dist331 dist332 dist333 dist334 dist335 dist336 dist337 dist338 dist339 dist340 dist341 dist342 dist343 dist344 dist345 dist346 dist347 dist348 dist349 dist350 dist351 dist352 dist353 dist354 dist355 dist356 dist357 dist358 dist359 dist360 dist361 dist362 dist363 dist364 dist365 dist366 dist367 dist368 dist369 dist370 dist371 dist372 dist373 dist374 dist375 dist376 dist377 dist378 dist379 dist380 dist381 dist382 dist383, group(female) method(lpm) quantiles(.1(.05).9) nreg(100) reps(50)

est store cdeco_syntax_test

mat tot=e(total_difference)
mat char=e(characteristics)
mat coef=e(coefficients)
mat quant=e(quantiles)
svmat tot
svmat char 
svmat coef
svmat quant

twoway (line tot1 quant1) (line char1 quant1) (line coef1 quant1), ytitle(Quantile Effect) xtitle(Quantile) legend(order(1 "Total difference" 2 "Effects of characteristics" 3 "Effects of coefficients"))

graph export "paper/figures/mm-decomp-wordy-syntax.png", as(png)

drop tot* char* coef* quant*
*/

/* FROM HERE TONIGHT */

timer on 1
cdeco lwshourly_inf_adj literacy educ_yrs married age age_sq grad_degree prog_inc eng_ab2 eng_ab3 castes1 castes2 castes3 castes4 castes5 castes6 occ1 occ2 occ3 occ4 occ5 occ6 occ7 occ8 occ9 occ10 occ11 occ12 occ13 occ14 occ15 occ16 occ17 occ18 occ19 occ20 occ21 occ22 occ23 occ24 occ25 occ26 occ27 occ28 occ29 occ30 occ31 occ32 occ33 occ34 occ35 occ36 occ37 occ38 occ39 occ40 occ41 occ42 occ43 occ44 occ45 occ46 occ47 occ48 occ49 occ50 occ51 occ52 occ53 occ54 occ55 occ56 occ57 occ58 occ59 occ60 occ61 occ62 occ63 occ64 occ65 occ66 occ67 occ68 occ69 occ70 occ71 occ72 occ73 occ74 occ75 occ76 occ77 occ78 occ79 occ80 occ81 occ82 occ83 occ84 occ85 occ86 occ87 occ88 dist1 dist2 dist3 dist4 dist5 dist6 dist7 dist8 dist9 dist10 dist11 dist12 dist13 dist14 dist15 dist16 dist17 dist18 dist19 dist20 dist21 dist22 dist23 dist24 dist25 dist26 dist27 dist28 dist29 dist30 dist31 dist32 dist33 dist34 dist35 dist36 dist37 dist38 dist39 dist40 dist41 dist42 dist43 dist44 dist45 dist46 dist47 dist48 dist49 dist50 dist51 dist52 dist53 dist54 dist55 dist56 dist57 dist58 dist59 dist60 dist61 dist62 dist63 dist64 dist65 dist66 dist67 dist68 dist69 dist70 dist71 dist72 dist73 dist74 dist75 dist76 dist77 dist78 dist79 dist80 dist81 dist82 dist83 dist84 dist85 dist86 dist87 dist88 dist89 dist90 dist91 dist92 dist93 dist94 dist95 dist96 dist97 dist98 dist99 dist100 dist101 dist102 dist103 dist104 dist105 dist106 dist107 dist108 dist109 dist110 dist111 dist112 dist113 dist114 dist115 dist116 dist117 dist118 dist119 dist120 dist121 dist122 dist123 dist124 dist125 dist126 dist127 dist128 dist129 dist130 dist131 dist132 dist133 dist134 dist135 dist136 dist137 dist138 dist139 dist140 dist141 dist142 dist143 dist144 dist145 dist146 dist147 dist148 dist149 dist150 dist151 dist152 dist153 dist154 dist155 dist156 dist157 dist158 dist159 dist160 dist161 dist162 dist163 dist164 dist165 dist166 dist167 dist168 dist169 dist170 dist171 dist172 dist173 dist174 dist175 dist176 dist177 dist178 dist179 dist180 dist181 dist182 dist183 dist184 dist185 dist186 dist187 dist188 dist189 dist190 dist191 dist192 dist193 dist194 dist195 dist196 dist197 dist198 dist199 dist200 dist201 dist202 dist203 dist204 dist205 dist206 dist207 dist208 dist209 dist210 dist211 dist212 dist213 dist214 dist215 dist216 dist217 dist218 dist219 dist220 dist221 dist222 dist223 dist224 dist225 dist226 dist227 dist228 dist229 dist230 dist231 dist232 dist233 dist234 dist235 dist236 dist237 dist238 dist239 dist240 dist241 dist242 dist243 dist244 dist245 dist246 dist247 dist248 dist249 dist250 dist251 dist252 dist253 dist254 dist255 dist256 dist257 dist258 dist259 dist260 dist261 dist262 dist263 dist264 dist265 dist266 dist267 dist268 dist269 dist270 dist271 dist272 dist273 dist274 dist275 dist276 dist277 dist278 dist279 dist280 dist281 dist282 dist283 dist284 dist285 dist286 dist287 dist288 dist289 dist290 dist291 dist292 dist293 dist294 dist295 dist296 dist297 dist298 dist299 dist300 dist301 dist302 dist303 dist304 dist305 dist306 dist307 dist308 dist309 dist310 dist311 dist312 dist313 dist314 dist315 dist316 dist317 dist318 dist319 dist320 dist321 dist322 dist323 dist324 dist325 dist326 dist327 dist328 dist329 dist330 dist331 dist332 dist333 dist334 dist335 dist336 dist337 dist338 dist339 dist340 dist341 dist342 dist343 dist344 dist345 dist346 dist347 dist348 dist349 dist350 dist351 dist352 dist353 dist354 dist355 dist356 dist357 dist358 dist359 dist360 dist361 dist362 dist363 dist364 dist365 dist366 dist367 dist368 dist369 dist370 dist371 dist372 dist373 dist374 dist375 dist376 dist377 dist378 dist379 dist380 dist381 dist382 dist383, group(female) quantiles(.1(.05).9) nreg(100) reps(50)

timer off 1

est store cdeco_wordy_def_method

mat tot=e(total_difference)
mat char=e(characteristics)
mat coef=e(coefficients)
mat quant=e(quantiles)
svmat tot
svmat char 
svmat coef
svmat quant

twoway (line tot1 quant1) (line char1 quant1) (line coef1 quant1), ytitle(Quantile Effect) xtitle(Quantile) legend(order(1 "Total difference" 2 "Effects of characteristics" 3 "Effects of coefficients"))

graph export "paper/figures/mm-decomp-wordy-syntax-def-method.png", as(png)

drop tot* char* coef* quant*



qrprocess lwshourly_inf_adj literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability i.occup i.district i.caste if female == 0, quantiles(.1(.05).9) 

est store qr_coef_men


qrprocess lwshourly_inf_adj literacy educ_yrs married age age_sq grad_degree prog_inc i.english_ability i.occup i.district i.caste if female == 1, quantiles(.1(.05).9) 

est store qr_coef_women


/*
timer on 1

cdeco lwshourly_inf_adj literacy educ_yrs married age age_sq grad_degree prog_inc eng_ab* occ** castes*, group(female) method(lpm) quantiles(.1(.05).9) nreg(100) reps(50)

timer off 1

est store qr_mod_cdeco_no_dist_fe_lpm

mat tot=e(total_difference)
mat char=e(characteristics)
mat coef=e(coefficients)
mat quant=e(quantiles)
svmat tot
svmat char 
svmat coef
svmat quant

twoway (line tot1 quant1) (line char1 quant1) (line coef1 quant1), ytitle(Quantile Effect) xtitle(Quantile) legend(order(1 "Total difference" 2 "Effects of characteristics" 3 "Effects of coefficients"))

graph export "paper/figures/mm-decomp-lpm-no-dist-fe.png", as(png)

drop tot* char* coef* quant*

timer on 2

cdeco lwshourly_inf_adj literacy educ_yrs married age age_sq grad_degree prog_inc eng_ab* occ** dist*** castes*, group(female) quantiles(.1(.05).9) nreg(100) reps(50)

timer off 2

est store qr_mod_cdeco_def_method

mat tot=e(total_difference)
mat char=e(characteristics)
mat coef=e(coefficients)
mat quant=e(quantiles)
svmat tot
svmat char 
svmat coef
svmat quant

twoway (line tot1 quant1) (line char1 quant1) (line coef1 quant1), ytitle(Quantile Effect) xtitle(Quantile) legend(order(1 "Total difference" 2 "Effects of characteristics" 3 "Effects of coefficients"))

graph export "paper/figures/mm-decomp-def-method.png", as(png)

drop tot* char* coef* quant*

cdeco lwshourly_inf_adj literacy educ_yrs married age age_sq grad_degree prog_inc eng_ab* castes*, group(female) quantiles(.1(.05).9) nreg(100) reps(50)

est store qr_mod_cdeco_no_fe

mat tot=e(total_difference)
mat char=e(characteristics)
mat coef=e(coefficients)
mat quant=e(quantiles)
svmat tot
svmat char 
svmat coef
svmat quant

twoway (line tot1 quant1) (line char1 quant1) (line coef1 quant1), ytitle(Quantile Effect) xtitle(Quantile) legend(order(1 "Total difference" 2 "Effects of characteristics" 3 "Effects of coefficients"))

graph export "paper/figures/mm-decomp-no-fe.png", as(png)

drop tot* char* coef* quant*

timer on 3

cdeco lwshourly_inf_adj literacy educ_yrs married age age_sq grad_degree prog_inc eng_ab* occ** castes*, group(female) quantiles(.1(.05).9) nreg(100) reps(50)

timer off 3

est store qr_mod_cdeco_def_method

mat tot=e(total_difference)
mat char=e(characteristics)
mat coef=e(coefficients)
mat quant=e(quantiles)
svmat tot
svmat char 
svmat coef
svmat quant

twoway (line tot1 quant1) (line char1 quant1) (line coef1 quant1), ytitle(Quantile Effect) xtitle(Quantile) legend(order(1 "Total difference" 2 "Effects of characteristics" 3 "Effects of coefficients"))

graph export "paper/figures/mm-decomp-no-district-fe.png", as(png)

drop tot* char* coef* quant*

timer list 1 2 3 4

*/

/* test */
