******		
*estoutflip: Flip the table of regression results made with estout
*This puts each model in a row and the independent vars in columns
******
*code from: http://repec.org/bocode/e/estout/advanced.html#advanced907

program estoutflip

matrix C = r(coefs)
matrix S = r(stats)

******************
*My addition: Replace factor var names with their labels
local rnames2 : rownames C
local rnames
foreach name of local rnames2{
    if "`name'"=="`=strtoname("`name'")'"{
        local rnames `rnames' `=strtoname("`name'")'
    }
    if "`name'"!="`=strtoname("`name'")'"{ 
		local dot = strpos("`name'", ".")
		local varname = substr("`name'", `dot'+1, .)
		local num = substr("`name'", 1, 1)
		local valuelab: label (`varname') `num'
		local rnames `rnames' `=strtoname("`valuelab'")'
    }
}

******************

cap mat rownames C= "`rnames'"

local models : coleq C
local models : list uniq models

eststo clear
local i 0

foreach name of local rnames {
    local ++i
	local j 0
	capture matrix drop b
    capture matrix drop se
    foreach model of local models {
        local ++j
        matrix tmp = C[`i', 2*`j'-1]
        if tmp[1,1]<. {
            matrix colnames tmp = `model'
            matrix b = nullmat(b), tmp
            matrix tmp[1,1] = C[`i', 2*`j']
            matrix se = nullmat(se), tmp
		}
	}
ereturn post b
quietly estadd matrix se
eststo `name'
}

local snames : rownames S
local i 0
foreach name of local snames {
     local ++i
     local j 0
     capture matrix drop b
     foreach model of local models {
         local ++j
        matrix tmp = S[`i', `j']
        matrix colnames tmp = `model'
        matrix b = nullmat(b), tmp
     }
ereturn post b
eststo `name'
}

end program
