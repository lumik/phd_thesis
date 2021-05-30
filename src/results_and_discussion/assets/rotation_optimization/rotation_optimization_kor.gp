set encoding utf8
reset
# set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 13.5cm,9cm header "\\sffamily\\sansmath"
set output "rotation_optimization_kor.tex"

fn_004Hz  = 'pUIt_004Hz_kor.dat'
fn_160Hz  = 'pUIt_160Hz_kor.dat'
lw = 2
ps = 2

decay(x, p1, p2, p3) = p1 * exp(-p2 * x) + p3;

set macros
ranges = "[0:26][-0.05:0.4]"

set xlabel 'time (min)'
set ylabel 'intensity (a. u.)'
set xtics 5
unset ytics

set lmargin at screen 0.05

#   4Hz  1.333290e-01, 4.118170e-02
# 160Hz  1.545316e-01, 4.543252e-02

plot @ranges\
	fn_004Hz w p title "4\\,Hz" pt 2 ps ps lw lw lc 'red',\
	decay(x, 1.333290e-01, 4.118170e-02, 0) w l lc 'black' notitle, \
	fn_160Hz w p title "160\\,Hz" pt 4 ps ps lw lw lc 'green',\
	decay(x, 1.545316e-01, 4.543252e-02, 0) w l lc 'black' notitle

set output
