set encoding utf8
reset
#set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 13.5cm,9cm header "\\sffamily\\sansmath"
set output "pt_calibration.tex"

fn_pt255  = 'pt255nm.txt'
fn_pos = 'pt_positions.dat'

set macros
ranges = "[200:3100][0:1.8e6]"

set xlabel '$\tilde{\nu}$ (\icm)'
set ylabel 'intensity (a. u.)' offset -1,0
set xtics 500
unset ytics

plot @ranges fn_pos u 1:(-0.2e7):(0):(2.95e7) with vectors nohead lc 'gray80' notitle,\
	fn_pt255 w l lw 2 title 'Pt'

set output
