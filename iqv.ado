**************
*! version 2.0  19Sept2022
**************
*Based on the mata approach suggested by Nick Cox in the post below
*http://www.statalist.org/forums/forum/general-stata-discussion/general/1345811-index-of-qualitative-variation

program define iqv, byable(recall) rclass
	syntax varlist [if] [in]  
	local stop : word count `varlist'			/*create local macro called stop indicating # of vars in varlist*/
	tokenize `varlist'					/*store varlist in local macros `1', `2', etc.*/
	local i 1							/*add a counter*/
	tempvar touse freq iqv 
	mark `touse' `if' `in' 
	di as text "Index of Qualitative Variation"			/*display title as text*/
	di as text ""
	*di as text "iqv = categories*(100^2 - sum of squared percentages)/(100^2*(categories-1))"
	
	di as text "       #categories(100^2 - sum of squared percentages)"
	di as text "IQV = ------------------------------------------------"
	di as text "                   100^2(#categories-1)"
	di as text ""
	
	while `i' <= `stop' {
			quietly tab ``i'' if `touse'==1, matcell(freq)	/*quietly tab var and store counts in matrix calle freq*/
			
			mata: freq = st_matrix("freq")   
			mata: st_numscalar("`iqv'", 1  - sum((freq :/ sum(freq)):^2)) 
			return scalar iqv = `iqv' 
			di as text "``i'' " _col(15) as result %9.3f `iqv'		/*display variable name as text and iqv as result*/
			local i = `i' + 1						/*increase counter by 1*/
	}
end


*The thread below mentions other packages that get the IQV and other measures of variation for nominal or ordinal variables
*http://www.statalist.org/forums/forum/general-stata-discussion/general/1345811-index-of-qualitative-variation
*divcat
*ordvar