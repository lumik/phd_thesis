set encoding utf8
reset
# set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 13.5cm,9cm header "\\sffamily\\sansmath"
set output "sn_ratio.tex"

fn  = 'water_20s_fit.dat'
lw = 2
fitlw = 1.5
spclw = 3

set macros
ranges = "[650:1800][0.9:1.6]"

set xlabel '$\tilde{\nu}$ (\icm)'
set ylabel 'intensity (a. u.)'
set xtics 200

plot @ranges\
	fn u 1:2 w l title "spectrum" lw spclw lc 'red',\
	fn u 1:3 w l title "model" lw fitlw lc 'green',\
	fn u 1:4 w l title "constant" lw lw lc 'blue'

set output
