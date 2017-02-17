*! version 1.0  31Aug2008
program define iqv, byable(recall)
	syntax varlist [if] [in]  
	local stop : word count `varlist'			/*create local macro called stop indicating # of vars in varlist*/
	tokenize `varlist'					/*store varlist in local macros `1', `2', etc.*/
	local i 1							/*add a counter*/
	tempvar touse
	mark `touse' `if' `in' 
	di as text "Index of Qualitative Variation"			/*display title as text*/
		while `i' <= `stop' {
			quietly tab ``i'' if `touse'==1, matcell(freq)	/*quietly tab var and store counts in matrix calle freq*/
			local k = rowsof(freq)					/*count rows of matrix freq*/
			mat c = J(`k',1,1)					/*create matrix of 1s for multiplying-summing*/
			mat sum = c'*freq						/*multiply inverse of 1s freq matrix to get sum of freqs*/
			scalar n = sum[1,1]					/*redefine sum matrix as a scalar*/
			mat pct=freq/n*100					/*multiply freq matrix by scalar to get percents*/
			mat sumsqpct=pct'*pct					/*sum all the percents*/
			local ssp=sumsqpct[1,1]					/*redifine sum of squared % as a local macro*/
			local iqv `k'*(100^2 - `ssp')/(100^2*(`k'-1))	/*calculate the index of qualitative variation*/
			di as text "``i'' " as result %9.3f `iqv'		/*display variable name as text and iqv as result*/
			local i = `i' + 1						/*increase counter by 1*/
	}
end
