set more off
global ruta "/Users/camilojosepechagarzon/Documents/DATA/Jamaica/Agriculture"
*use "$ruta/main.dta", clear
*keep FarmerID
*sort FarmerID
use "$ruta/farmersID_10.dta", clear
drop  ntile
xtile ntile=FarmerID, n(10)
save "$ruta/farmersID_10.dta",replace
*save "$ruta/farmersID.dta",replace

local campe 1 //just to count the number of farmers procecessed 
forvalues tile=1/350{
keep if ntile==`tile'
gen counter=_n
qui:sum counter
local max=r(max)
save "$ruta/farmersIDc12.dta",replace
forvalues m=1/`max'{
qui:sum FarmerID if counter==`m'
local IDweb=r(mean)
disp "******** Farmer `IDweb'(`campe'), Ntile `tile' ***********"
local ++campe
local url http://data.org.jm/api/crops/?FarmerID=`IDweb'
qui:insheet using "`url'",clear
keep v3
drop if v3=="/api/crops/add>New Crop</a></li>"|v3=="</div>"|v3=="</p>" ///
|v3=="<title>" ///
|v3=="CakePHP: the rapid development php framework:"|v3=="actions>" ///
|v3=="altrow>"|v3=="content>"|v3=="disabled>&lt;&lt; previous</span>" ///
|v3=="footer>"|v3=="header>"|v3==""
qui:split  v3,p("<td>" "&nbsp;</td>")
if _N>1{
keep v32
sxpose, clear
qui:save "$ruta/farmer`IDweb'.dta", replace
qui:desc
local numv=r(k)/19
forvalues b=1/`numv'{
display "******Creating dataset `b'********"
scalar i11=19*`b'
scalar i01=((19*`b')-19)+1
local i1=i11
local i0=i01
keep _var`i0'-_var`i1'
if `b'>1{
qui:renvars _var`i0'-_var`i1' \  _var1-_var19 
}
*save "$ruta/farmer`IDweb'`b'.dta", replace
qui:append using "$ruta/main2.dta"
qui:save "$ruta/main2.dta", replace
count
*erase "$ruta/farmer`IDweb'`b'.dta"
use "$ruta/farmer`IDweb'.dta",clear
}
erase "$ruta/farmer`IDweb'.dta"

}
use "$ruta/farmersIDc12.dta", clear
}
use "$ruta/farmersID_10.dta", clear
}


