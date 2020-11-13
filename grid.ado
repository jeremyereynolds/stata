program drop grid
	
program define grid
  args gt idnum v
  
local days "Monday Tuesday Wednesday Thursday Friday Saturday Sunday"
foreach d of numlist 1/7{
	local day : word `d' of `days'
	
	*check which days were fixed
	quietly: levelsof changed if surveyday==`d' & id==`idnum', local(changed)
	
	foreach t of numlist 1/10{
		*make header
		if `t'==1 & "`v'"=="o" di as text "`day' (Original)"
		if `t'==1 & "`v'"=="c" di as text "`day' (Changed:`changed')"
		if `t'==1 di as text "Work Period {c |}" _col(20) "Work Type" _col(52) "Begin" _col(62) "End" _col(70) "Location" 
		if `t'==1 di as text "{hline 12}{c +}{hline 73}"
		*if `t'==1 di "---------------------------------------------------------------------------------------------"
		
	*put info from fixed grid in macros
	quietly: decode  `gt'schd_typ_wp`t', gen(st_`gt'schd_typ_wp`t')
	quietly: levelsof st_`gt'schd_typ_wp`t' if surveyday==`d' & id==`idnum', local(type)
	quietly: drop st_`gt'schd_typ_wp`t'

	quietly: decode  `gt'schd_b_wp`t', gen(st_`gt'schd_b_wp`t')
	quietly: levelsof st_`gt'schd_b_wp`t' if surveyday==`d' & id==`idnum', local(begin)
	quietly: drop st_`gt'schd_b_wp`t'

	quietly: decode  `gt'schd_e_wp`t', gen(st_`gt'schd_e_wp`t')
	quietly: levelsof st_`gt'schd_e_wp`t' if surveyday==`d' & id==`idnum', local(end)
	quietly: drop st_`gt'schd_e_wp`t'

	quietly: decode  `gt'schd_loc_wp`t', gen(st_`gt'schd_loc_wp`t')
	quietly: levelsof st_`gt'schd_loc_wp`t' if surveyday==`d' & id==`idnum', local(loc)
	quietly: drop st_`gt'schd_loc_wp`t'
	
	*put info from original grid in macros
	quietly: decode  `gt's_b_wp`t', gen(st_`gt's_b_wp`t')
	quietly: levelsof st_`gt's_b_wp`t' if surveyday==`d' & id==`idnum', local(obegin)
	quietly: drop st_`gt's_b_wp`t'

	quietly: decode  `gt's_e_wp`t', gen(st_`gt's_e_wp`t')
	quietly: levelsof st_`gt's_e_wp`t' if surveyday==`d' & id==`idnum', local(oend)
	quietly: drop st_`gt's_e_wp`t'
		
	*display schedule
		if "`v'"=="o" & `type' != "-99 Seen but not answered" {
			di as result _col(2) "`t'" as text _col(13)"{c |}" as result _col(15) `type' _col(50) `obegin'  _col(60) `oend' _col(70) `loc'
		}

		if "`v'"=="c" & `type' != "-99 Seen but not answered" {
			di as result "`t'" as text _col(13)"{c |}" as result _col(15) `type' _col(50) `begin'  _col(60) `end' _col(70) `loc'
		}
		
	}
		di " "
}

di "MORE INFO ABOUT THIS RESPONDENT"
list surveyday xmidnd esch_nm wpasdays wpasdays2 multitask changed* if id==`idnum' & surveyday>0, noobs sep(20) ab(15)

end	
