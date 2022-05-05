clear all

sysuse auto

eststo clear
eststo: qui reg price i.mpg gear_ratio foreign i.rep78,

esttab *, indicate("Miles Per Gallon Fixed Effects" = *mpg)
