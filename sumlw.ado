program define sumlw
	version 9.1
	syntax [varlist(ts)] [if] [in] [aweight fweight] [, Detail noFormat]
	marksample touse
	summarize `varlist' [`weight' `exp'] if `touse', `detail' `format'
end
