program define ptoraw2
  args m s p1 p2

**********
*One x
**********
if "`p2'" == "" {
    local z = round(invnormal(`p1'/100), .01)			/*find z and round to 2 decimal places to match textbook*/
    local raw = `m' + `z'*`s'
    local rawstr = string(`raw',"%6.2f")
	local above = (1-normal(`z'))*100
    local below = normal(`z')*100
    local between = abs((normal(`z') - .5)*100)
    display
	display in yellow "Find a Raw-score when given a percentile"
    display
	display as text " In a distribution with a mean of `m' and a s.d. of `s', what raw score marks off the `p1'th percentile?"
	display as text " In a normal distribution, the Z that marks off the `p1'th percentile is `z'."
	display as text " The raw score marking off the `p1'th percentile in this distribution is thus:"
    display as text " Raw Score = mean + Z-score(standard deviation) = `m' + `z'(`s') = " as result `rawstr'
	display
    display as text " Percent of area above Z = " as result %8.2f `above'
    display as text " Percent of area below Z = " as result %8.2f `below'
    display as text " Percent of area between Z and mean = " as result %8.2f `between'
    local abovef = string(round(`above',.01))
    local belowf = string(round(`below',.01))
    local betweenf = string(round(`between',.01))
    twoway (function y=normalden(x), range(`z' 4) bcolor(erose) recast(area)) ///
           (function y=normalden(x), range(-4 4) pstyle(p2)), ///
           yscale(off) xscale(line) legend(off) xlabel(-4(1)4) ylabel( , nogrid) xtitle("Z-score") ///
           plotregion(margin(zero)) ///
		   title("If the mean is `m' and the s.d. is `s'," "the raw score marking off the `p1'th percentile = `rawstr'.") ///
		   xline(`z', lcolor(red)) ///
           note("Percent of area:" "  above Z = `abovef'%" ///
		"  below Z = `belowf'%" ///
		"  between Z and zero = `betweenf'%") ///
		text(.1 `z' "Z=`z' " , size(small) placement(west)color(red))
}

**********
*Two xs
**********
if "`p2'" ~= "" {
    local z1 = round(invnormal(`p1'/100), .01)			/*find z and round to 2 decimal places to match textbook*/
	local raw1 = `m' + `z1'*`s'
    local rawstr1 = string(`raw1',"%6.2f")
	
	local above1 = (1-normal(`z1'))*100
    local below1 = normal(`z1')*100
    local between1 = abs((normal(`z1') - .5)*100)
    display in yellow "Find a Raw-score when given a percentile"
	display 
	display as text " In a distribution with a mean of `m' and a s.d. of `s', what raw score marks off the `p1'th percentile?"

	display as text " In a normal distribution, the Z that marks off the `p1'th percentile is `z1'."
	display as text " The raw score marking off the `p1'th percentile in this distribution is thus:"
    display as text " Raw Score = mean + Z-score(standard deviation) = `m' + `z1'(`s') = " as result `rawstr1'
	display as text " Percent of area above Z1 = " as result %8.2f `above1'
    display as text " Percent of area below Z1 = " as result %8.2f `below1'
    display as text " Percent of area between Z1 and mean = " as result %8.2f `between1'
	local z2 = round(invnormal(`p2'/100), .01)			/*find z and round to 2 decimal places to match textbook*/
	local raw2 = `m' + `z2'*`s'
    local rawstr2 = string(`raw2',"%6.2f")
	local above2 = (1-normal(`z2'))*100
    local below2 = normal(`z2')*100
    local between2 = abs((normal(`z2') - .5)*100)
    display
	display as text " In a distribution with a mean of `m' and a s.d. of `s', what raw score marks off the `p2'th percentile?"
	display as text " In a normal distribution, the Z that marks off the `p2'th percentile is `z2'."
	display as text " The raw score marking off the `p2'th percentile in this distribution is thus:"
    display as text " Raw Score = mean + Z-score(standard deviation) = `m' + `z2'(`s') = " as result `rawstr2'
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
          twoway (function y=normalden(x), range(-4 4) pstyle(p2)), ///
		yscale(off) xscale(line) legend(off) xlabel(-4(1)4) ylabel( , nogrid) xtitle("Z-score") ///
		plotregion(margin(zero)) ///
		title("If the mean is `m' and the s.d. is `s'," "the raw score for the `p1'th percentile = `rawstr1' and the raw score for the `p2'th percentile = `rawstr2'", size(medium)) ///
            xline(`z1', lcolor(red)) ///
            xline(`z2', lcolor(blue)) ///
		text(.35 -4 "z1 = `z1'", size(small) placement(east) color(red)) ///
		text(.30 -4 "between Z1 and mean = `between1f'%" , size(small) placement(east) color(red)) ///
		text(.25 -4 "below Z1 = `below1f'%" , size(small) placement(east) color(red)) ///
		text(.20 -4 "above Z1 = `above1f'%" , size(small) placement(east) color(red)) ///
		text(.35 4 "z2 = `z2'", size(small) placement(west) color(blue)) ///
		text(.30 4 "between Z2 and mean = `between2f'%" , size(small) placement(west) color(blue))  ///
		text(.25 4 "below Z2 = `below2f'%" , size(small) placement(west) color(blue)) ///
		text(.20 4 "above Z2 = `above2f'%" , size(small) placement(west) color(blue)) ///
		text(.1 `z1' "Z1" , size(small) placement(west)color(red)) ///
		text(.1 `z2' "Z2" , size(small) placement(west)color(blue)) ///
		note("Percent of area between Z1 and Z2 = `between12'%")   
}
end

*code for graphs borrowed from ztail
*for help rounding see: http://www.stata.com/statalist/archive/2003-09/msg00234.html
