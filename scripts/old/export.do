use "data/clean_indiv_data.dta"

outsheet lwshourly female SURVEY INCBENEFITS district URBAN RO5 ED* using "data/cleanR_indiv_data.csv", comma
