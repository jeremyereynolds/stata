program define grid
  args gt idnum
  
local days "Monday Tuesday Wednesday Thursday Friday Saturday Sunday"
foreach d of numlist 1/7{
	local day : word `d' of `days'
	
	*check which days were fixed
	quietly: levelsof changed if surveyday==`d' & id==`idnum', local(changed)
	
	foreach t of numlist 1/10{
		*make header
		if `t'==1 & `changed'==0 di as text "`day'"
		if `t'==1 & `changed'>0 di as result "`day' (* = after cleaning)"
		if `t'==1 di as text "Work Period {c |}" _col(20) "Work Type" _col(62) "Begin" _col(72) "End" _col(82) "Begin*" _col(92) "End*" _col(100) "Location" 
		if `t'==1 di as text "{hline 12}{c +}{hline 100}"

	*put info from changed times in macros
	quietly: decode  `gt'schd_b_wp`t', gen(st_`gt'schd_b_wp`t')
	quietly: levelsof st_`gt'schd_b_wp`t' if surveyday==`d' & id==`idnum' & changed>0, local(cbegin)
	quietly: drop st_`gt'schd_b_wp`t'

	quietly: decode  `gt'schd_e_wp`t', gen(st_`gt'schd_e_wp`t')
	quietly: levelsof st_`gt'schd_e_wp`t' if surveyday==`d' & id==`idnum' & changed>0, local(cend)
	quietly: drop st_`gt'schd_e_wp`t'
	
	*put info from original grid items in macros
	quietly: decode  `gt'schd_typ_wp`t', gen(st_`gt'schd_typ_wp`t')
	quietly: levelsof st_`gt'schd_typ_wp`t' if surveyday==`d' & id==`idnum', local(type)
	quietly: drop st_`gt'schd_typ_wp`t'
	
	quietly: decode  `gt's_b_wp`t', gen(st_`gt's_b_wp`t')
	quietly: levelsof st_`gt's_b_wp`t' if surveyday==`d' & id==`idnum' , local(begin)
	quietly: drop st_`gt's_b_wp`t'

	quietly: decode  `gt's_e_wp`t', gen(st_`gt's_e_wp`t')
	quietly: levelsof st_`gt's_e_wp`t' if surveyday==`d' & id==`idnum', local(end)
	quietly: drop st_`gt's_e_wp`t'
	
	quietly: decode  `gt'schd_loc_wp`t', gen(st_`gt'schd_loc_wp`t')
	quietly: levelsof st_`gt'schd_loc_wp`t' if surveyday==`d' & id==`idnum', local(loc)
	quietly: drop st_`gt'schd_loc_wp`t'
	
	*truncate work type because it can be too long (need to leave off = sign; not sure why)
	local type substr(`type',1 ,43)
	
	
	*display schedule
		if missing(`"`type'"')==0{
		 if `type' != "-99 Seen but not answered"{
			di as result _col(2) "`t'" as text _col(13) "{c |}" as result _col(15) `type' ///
			_col(60) `begin'  _col(70) `end' _col(80) `cbegin'  _col(90) `cend' _col(100) `loc'
		 }
		}
	}
		di " "
}

di "MORE INFO ABOUT THIS RESPONDENT"
list surveyday esch_from cleaning xmidnd esch_nm wpasdays wpasdays2 multitask changed* if id==`idnum' & surveyday>0, noobs sep(20) ab(15)

end	