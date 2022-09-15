program define zcalc2
  args m s x1 x2

**********
*One x
**********
if "`x2'" == "" {
    local z = round((`x1' - `m')/`s', .01)			/*round z to 2 decimal places to match textbook*/
    local above = (1-normal(`z'))*100
    local below = normal(`z')*100
    local between = abs((normal(`z') - .5)*100)
    display
    display in yellow "z-score for sample observations"
    display
    display as text "      (X - m)       (`x1' - `m')"
    display as text " z = ---------  =  ------------------  = " as result %8.2f `z'
    display as text "         s              `s'"
    display
    display as text " Percent of area above Z = " as result %8.2f `above'
    display as text " Percent of area below Z = " as result %8.2f `below'
    display as text " Percent of area between Z and mean = " as result %8.2f `between'
    local title1 = "z = " + string(round(`z',.01))
    local abovef = string(round(`above',.01))
    local belowf = string(round(`below',.01))
    local betweenf = string(round(`between',.01))
    twoway (function y=normalden(x), range(`z' 4) bcolor(erose) recast(area)) ///
           (function y=normalden(x), range(-4 4) pstyle(p2)), ///
           yscale(off) xscale(line) legend(off) xlabel(-4(1)4) ylabel( , nogrid) xtitle("Z-score") ///
           plotregion(margin(zero)) title(`title1') ///
           note("Percent of area:" "  above Z = `abovef'%" ///
		"  below Z = `belowf'%" ///
		"  between Z and zero = `betweenf'%")
}

**********
*Two xs
**********
if "`x2'" ~= "" {
    local z1 = round((`x1' - `m')/`s', .01)			/*round z to 2 decimal places to match textbook*/
    local above1 = (1-normal(`z1'))*100
    local below1 = normal(`z1')*100
    local between1 = abs((normal(`z1') - .5)*100)
    display
    display in yellow "z-score for sample observations"
    display
    display as text "      (X - m)       (`x1' - `m')"
    display as text " z1 = ---------  =  ------------------  = " as result %8.2f `z1'
    display as text "         s              `s'"
    display
    display as text " Percent of area above Z1 = " as result %8.2f `above1'
    display as text " Percent of area below Z1 = " as result %8.2f `below1'
    display as text " Percent of area between Z1 and mean = " as result %8.2f `between1'
    local z2 = round((`x2' - `m')/`s', .01)			/*round z to 2 decimal places to match textbook*/
    local above2 = (1-normal(`z2'))*100
    local below2 = normal(`z2')*100
    local between2 = abs((normal(`z2') - .5)*100)
    display
    display in yellow "z-score for sample observations"
    display
    display as text "      (X - m)       (`x2' - `m')"
    display as text " z2 = ---------  =  ------------------  = " as result %8.2f `z2'
    display as text "         s              `s'"
    display
    display as text " Percent of area above Z2 = " as result %8.2f `above2'
    display as text " Percent of area below Z2 = " as result %8.2f `below2'
    display as text " Percent of area between Z2 and mean = " as result %8.2f `between2'
    display
    local above1f = string(round(`above1',.01))
    local below1f = string(round(`below1',.01))
    local between1f = string(round(`between1',.01))
    local above2f = string(round(`above2',.01))
    local below2f = string(round(`below2',.01))
    local between2f = string(round(`between2',.01))
    local between12 = string(round(abs(`below1f' - `below2f'),.01))
    display as text " Percent of area between Z1 and Z2 = " as result %8.2f `between12'
    local title1 = "z1 = " + string(round(`z1',.01)) + "      z2 = " + string(round(`z2',.01))
          twoway (function y=normalden(x), range(-4 4) pstyle(p2)), ///
		yscale(off) xscale(line) legend(off) xlabel(-4(1)4) ylabel( , nogrid) xtitle("Z-score") ///
		plotregion(margin(zero)) title(`title1') ///
            xline(`z1', lcolor(red)) ///
            xline(`z2', lcolor(blue)) ///
		text(.35 -4 "between Z1 and mean = `between1f'%" , size(small) placement(east) color(red)) ///
		text(.30 -4 "below Z1 = `below1f'%" , size(small) placement(east) color(red)) ///
		text(.25 -4 "above Z1 = `above1f'%" , size(small) placement(east) color(red)) ///
		text(.35 4 "between Z2 and mean = `between2f'%" , size(small) placement(west) color(blue))  ///
		text(.30 4 "below Z2 = `below2f'%" , size(small) placement(west) color(blue)) ///
		text(.25 4 "above Z2 = `above2f'%" , size(small) placement(west) color(blue)) ///
		text(.1 `z1' "Z1" , size(small) placement(west)color(red)) ///
		text(.1 `z2' "Z2" , size(small) placement(west)color(blue)) ///
		note("Percent of area between Z1 and Z2 = `between12'%")   
}
end

*code for graphs borrowed from ztail
*for help rounding see: http://www.stata.com/statalist/archive/2003-09/msg00234.html

