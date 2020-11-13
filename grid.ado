program define grid
  args gt idnum
  
local days "Monday Tuesday Wednesday Thursday Friday Saturday Sunday"
foreach d of numlist 1/7{
	local day : word `d' of `days'
	
	foreach t of numlist 1/10{
		*make header
		if `t'==1 di as text "`day'"
		if `t'==1 di as text "Work Period {c |}" _col(20) "Work Type" _col(52) "Begin" _col(62) "End" _col(70) "Location" 
		if `t'==1 di as text "{hline 12}{c +}{hline 73}"
		*if `t'==1 di "---------------------------------------------------------------------------------------------"
	
	*list eschd_typ_wp`t' eschd_b_wp`t' eschd_e_wp`t' eschd_loc_wp`t' ///
	*	if surveyday==`d' & id==`idnum' & mi(eschd_typ_wp`t')==0 , noobs table clean noheader divider
	
	*display schedule	
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

if `type' != "-99 Seen but not answered" {
	di as result _col(5) "`t'" as text _col(13)"{c |}" as result _col(15) `type' _col(50) `begin'  _col(60) `end' _col(70) `loc'
	}

}
	di " "
}

di "EXTRA INFO ABOUT THIS RESPONDENT"
list surveyday xmidnd numewp numewtyp esch_nm wpasdays wpasdays2 multitask ///
		changed1 changed2 changed1b if id==114 & surveyday>0, noobs sep(20) ab(15)

end	
	
	
/*	
save output of list command as local macro
https://www.stata.com/statalist/archive/2008-02/msg00179.html
levelsof var1 if var2 == x, local(levels) 
/*

/*
add other info
xmidnd numewp numewtyp esch_nm wpasdays wpasdays2 multitask midprob
	changed1 changed2 changed1b
	awseq aschd_wp*_prob  work_a dayhrs_a dayhrs_dv_a midn_1  

browse id workerid_mt surveyday numewp numewtyp esch_nm xmidnd wpasdays wpasdays2 multitask midprob changed1 changed2 ///
         esch_from dayhrs_t eschd_b_wp1 - eschd_e_wp10 es_b_wp1 - es_e_wp10 ewseq elseq etseq ///
         eschd_loc_wp* eschd_typ_wp* if wpasdays2==1
  