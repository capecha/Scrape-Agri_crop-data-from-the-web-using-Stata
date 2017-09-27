set more off
forvalues i=265197/397037{
clear all
local url http://data.org.jm/api/farms/view/`i'
insheet using "`url'"
drop in 1/27
drop in 2/8
drop in 3/5
drop in 4/6
drop in 5/7
drop in 6/8
drop in 7/9
drop in 8/10
drop in 9/19
drop v1 v2 v3
drop v5 v6 v7
sxpose, clear
drop _var10 _var11 _var12 _var13 _var14 _var15 _var16 _var17 _var18 _var19 _var20 _var21 _var22 _var23 _var24
save "/Users/camilojosepechagarzon/Documents/DATA/Jamaica/Agriculture/farm`i'.dta", replace
use  "/Users/camilojosepechagarzon/Documents/DATA/Jamaica/Agriculture/main.dta", clear
append using "/Users/camilojosepechagarzon/Documents/DATA/Jamaica/Agriculture/farm`i'.dta"
save "/Users/camilojosepechagarzon/Documents/DATA/Jamaica/Agriculture/main.dta", replace
erase "/Users/camilojosepechagarzon/Documents/DATA/Jamaica/Agriculture/farm`i'.dta"
}
