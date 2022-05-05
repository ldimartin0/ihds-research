clear all

use "data/hh-appended-long-panel.dta"

egen id_string = concat(HHBASE HHFAM2)
encode id_string, gen(id)

xtset id SURVEY

