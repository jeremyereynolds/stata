program define ztoraw
  args m s z

    local raw = `m' + `z'*`s'
    local rawstr = string(`raw',"%6.2f")
    display
    display in yellow "Raw-score for sample observations"
    display
    display as text " Raw Score = mean + Z-score(standard deviation) = `m' + `z'(`s') = " as result `rawstr'
 
end


