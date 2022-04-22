capture log close
cd "E:\Georgetown University\2022_1 Spring\INAF-383\Students\DiMartino"
log using lukeAPR21, replace

use 37382-0001-Data, clear
compress
save idhs, replace

use idhs, clear

/*** DEPENDENT VARIABLE ***/
des WSHOURLY
sum WSHOURLY
gen lwshourly = ln(WSHOURLY)

/*** GENDER ***/
des RO3
label list RO3
tab RO3, m

gen female=(RO3==2) if RO3==1 |  RO3==2

tab RO3 female, m

/*** OCCUPATION ***/
des NF1B NF21B NF41B WS4 MG10 NR11 NR11S
sum NF1B NF21B NF41B WS4 MG10 NR11 NR11S if lwshourly<.
label list WS4

/*** LOCATION FIXED EFFECTS ***/
des STATEID DISTID
sum STATEID DISTID
bysort STATEID: tab DISTID
egen district=group(STATEID DISTID)
codebook STATEID DISTID district

/************************************/
/*** PROGRAMMING OUTLIER COMMANDS ***/
/************************************/
clear programs

/* USING STANDARD DEVIATION */

prog def out3SD
	dis "3*SD outliers for `1' by `2' `3' `4' `5' `6'"
	qui egen M`1'=mean(`1'), by(`2' `3' `4' `5' `6')
	qui egen SD`1'=sd(`1'), by(`2' `3' `4' `5' `6')
	qui gen S`1'=(`1'>M`1'+3*SD`1' | `1'<M`1'-3*SD`1') if `1'<. & ///
		M`1'<. & SD`1'<.
	qui gen `1'S=`1' if S`1'!=1
	drop M`1' SD`1'
end

/* USING INTERQUARTILE RANGE */

prog def out3IQR
    dis "3*IQR outliers for `1' by `2' `3' `4' `5' `6'"
	qui egen IQR`1'=iqr(`1'), by(`2' `3' `4' `5' `6')
	qui egen P25`1'=pctile(`1'), p(25) by(`2' `3' `4' `5' `6')
	qui egen P75`1'=pctile(`1'), p(75) by(`2' `3' `4' `5' `6')
	qui gen I`1'=(`1'>P75`1'+3*IQR`1' | `1'<P25`1'-3*IQR`1') if ///
		`1'<. & IQR`1'<. & P25`1'<. & P75`1'<.
	qui gen `1'I=`1' if I`1'!=1
	drop IQR`1' P25`1' P75`1'
end

out3SD lwshourly SURVEY RO3 WS4 district
out3IQR lwshourly SURVEY RO3 WS4 district

sum lwshourly lwshourlyS lwshourlyI

for var Slwshourly Ilwshourly lwshourlyS lwshourlyI: ren X Xd

out3SD lwshourly SURVEY RO3 WS4 STATEID
out3IQR lwshourly SURVEY RO3 WS4 STATEID

sum lwshourly lwshourlyS lwshourlySd lwshourlyI lwshourlyId

/*** HOUSEHOLD COMPOSITION ***/
des NPERSONS NNR NCHILDM NCHILDF NTEENM NTEENF NADULTS NADULTM NADULTF NELDERM NELDERF NMARRIEDF NMARRIEDM
sum NPERSONS NNR NCHILDM NCHILDF NTEENM NTEENF NADULTS NADULTM NADULTF NELDERM NELDERF NMARRIEDF NMARRIEDM

for var NCHILDM NCHILDF NTEENM NTEENF NADULTS NADULTM NADULTF NELDERM NELDERF: gen Xpct=(X/NPERSONS)

sum *pct

/*** GOVERNMENT BENEFITS ***/
des INCBENEFITS
ins INCBENEFITS
sum INCBENEFITS, d
centile INCBENEFITS, centile(0(10)100)
gen benefits800=(INCBENEFITS>800) if INCBENEFITS<. //benefits threshold of 800 rupees
tab benefits800, m

/*** PANEL VARIABLES CHECK ***/
des SURVEY HHBASE PBASE
codebook SURVEY HHBASE PBASE
des, s
egen id=group(HHBASE PBASE)
codebook id
egen freq=count(id), by(id)
tab freq, m
bysort PWAVES: tab freq, m
tab PWAVES

/*** PANEL DECLARATION **/
xtset id SURVEY

/*** T-TEST ***/
ttest lwshourlySd, by(female)
ttest lwshourlySd, by(SURVEY)
ttest lwshourlySd, by(benefits800)

/***************************/
/*** REGRESSION ANALYSIS ***/
/***************************/
/*** TABLE 1 ***/
xtreg lwshourlySd female, fe vce(robust)
outreg2 using table1.xls, excel bdec(3) rdec(3) nocon adjr2 replace ///
	addtext(Occupation Controls, No) label

xtreg lwshourlySd female i.SURVEY, fe vce(robust)
outreg2 using table1.xls, excel bdec(3) rdec(3) nocon adjr2 append ///
	addtext(Occupation Controls, No) label
	
xtreg lwshourlySd female i.SURVEY benefits800, fe vce(robust)
outreg2 using table1.xls, excel bdec(3) rdec(3) nocon adjr2 append ///
	addtext(Occupation Controls, No) label
	
xtreg lwshourlySd female i.SURVEY benefits800 *pct, fe vce(robust)
outreg2 using table1.xls, excel bdec(3) rdec(3) nocon adjr2 append ///
	addtext(Occupation Controls, No) label

local RHS "female i.SURVEY benefits800 *pct"

xtreg lwshourlySd `RHS' i.WS4, fe vce(robust)
outreg2 using table1.xls, excel bdec(3) rdec(3) nocon adjr2 append ///
	addtext(Occupation Controls, Yes) keep(`RHS') label
	
/*** TABLE 2 ***/
xtreg lwshourlySd `RHS' i.WS4, fe vce(robust)
outreg2 using table2.xls, excel bdec(3) rdec(3) nocon adjr2 replace ///
	keep(`RHS') label

des GROUPS6
tab GROUPS6 if lwshourly<.
label list GROUPS6

xtreg lwshourlySd `RHS' i.WS4 if GROUPS6==2, fe vce(robust)
outreg2 using table2.xls, excel bdec(3) rdec(3) nocon adjr2 append ///
	keep(`RHS') label ctitle(Forward)

xtreg lwshourlySd `RHS' i.WS4 if GROUPS6==3, fe vce(robust)
outreg2 using table2.xls, excel bdec(3) rdec(3) nocon adjr2 append ///
	keep(`RHS') label ctitle(OBC)
	
xtreg lwshourlySd `RHS' i.WS4 if GROUPS6==4, fe vce(robust)
outreg2 using table2.xls, excel bdec(3) rdec(3) nocon adjr2 append ///
	keep(`RHS') label ctitle(Dalit)
	
xtreg lwshourlySd `RHS' i.WS4 if GROUPS6==5, fe vce(robust)
outreg2 using table2.xls, excel bdec(3) rdec(3) nocon adjr2 append ///
	keep(`RHS') label ctitle(Adivasi)
	
xtreg lwshourlySd `RHS' i.WS4 if GROUPS6==6, fe vce(robust)
outreg2 using table2.xls, excel bdec(3) rdec(3) nocon adjr2 append ///
	keep(`RHS') label ctitle(Muslim)
	
xtreg lwshourlySd `RHS' i.WS4 if GROUPS6==7, fe vce(robust)
outreg2 using table2.xls, excel bdec(3) rdec(3) nocon adjr2 append ///
	keep(`RHS') label ctitle(Other)
	
xtreg lwshourlySd `RHS' i.WS4 if female==1, fe vce(robust)
outreg2 using table2.xls, excel bdec(3) rdec(3) nocon adjr2 append ///
	keep(`RHS') label ctitle(Women)

xtreg lwshourlySd `RHS' i.WS4 if female==0, fe vce(robust)
outreg2 using table2.xls, excel bdec(3) rdec(3) nocon adjr2 append ///
	keep(`RHS') label ctitle(Men)
	
log close
