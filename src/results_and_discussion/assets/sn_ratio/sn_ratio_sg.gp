set encoding utf8
reset
# set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 13.5cm,9cm header "\\sffamily\\sansmath"
set output "sn_ratio_sg.tex"

fn  = 'water_20s_sg.dat'
fitlw = 1.5
spclw = 3

set macros
ranges = "[650:1800][0.5:1.4]"

set xlabel '$\tilde{\nu}$ (\icm)'
set ylabel 'intensity (a. u.)'
set xtics 200

plot @ranges\
	fn u 1:2 w l title "spectrum" lw spclw lc 'red',\
	fn u 1:3 w l title "SG filter" lw fitlw lc 'green'

set output
