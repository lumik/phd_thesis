set encoding utf8
reset
#set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 13.5cm,9cm header "\\sffamily\\sansmath"
set output "cyclohexane_calibration.tex"

fn_cyc255  = 'cyclohexane255nm.txt'
fn_dcyc255 = 'dcyclohexane255nm.txt'
fn_pos = 'cyclohexane_positions.dat'

set macros
ranges = "[200:3100][-0.2e7:2.75e7]"

set xlabel '$\tilde{\nu}$ (\icm)'
set ylabel 'intensity (a. u.)' offset -1,0
set xtics 500
unset ytics

plot @ranges fn_pos u 1:(-0.2e7):(0):(2.95e7) with vectors nohead lc 'gray80' lw 2 notitle,\
	fn_cyc255 w l lw 2 title 'cyclohexane',\
	fn_dcyc255 u 1:($2 + 2.5e6) w l lw 2 title 'cyclohexane-d12'

set output
