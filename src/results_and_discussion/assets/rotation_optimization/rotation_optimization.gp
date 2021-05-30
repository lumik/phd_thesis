set encoding utf8
reset
# set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 13.5cm,9cm header "\\sffamily\\sansmath"
set output "rotation_optimization.tex"

fn_004Hz  = 'pUIt_004Hz.dat'
fn_160Hz  = 'pUIt_160Hz.dat'
lw = 2
ps = 2

decay(x, p1, p2, p3) = p1 * exp(-p2 * x) + p3;

set macros
ranges = "[0:15][-0.05:0.4]"

set xlabel 'time (min)'
set ylabel 'intensity (a. u.)'
set xtics 5
unset ytics

set lmargin at screen 0.05

#   4Hz  1.736307e-01, 4.473633e-01, 1.059550e-01
# 160Hz  6.008162e-01, 4.050113e-01, 1.099283e-01

plot @ranges\
	fn_004Hz w p title "4\\,Hz" pt 2 ps ps lw lw lc 'red',\
	decay(x, 1.736307e-01, 4.473633e-01, 0) w l lc 'black' notitle, \
	fn_160Hz w p title "160\\,Hz" pt 4 ps ps lw lw lc 'green',\
	decay(x, 6.008162e-01, 4.050113e-01, 0) w l lc 'black' notitle

set output
