set encoding utf8
reset
# set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 13.5cm,9cm header "\\sffamily\\sansmath"
set output "power_optimization_hairpins.tex"

fn_01mW  = 'pUIt_1mW.dat'
fn_02mW  = 'pUIt_2mW.dat'
fn_04mW  = 'pUIt_4mW.dat'
lw = 2
ps = 2

decay(x, p1, p2, p3) = p1 * exp(-p2 * x) + p3;

set macros
ranges = "[-1:21][0:2.1]"

set xlabel 'time (min)'
set ylabel 'intensity (a. u.)'
set xtics 5
unset ytics

set lmargin at screen 0.05

# 1mw  1.637484e+00, 1.640089e-02
# 2mW  1.661441e+00, 3.277329e-02
# 4mW  1.694566e+00, 6.346895e-02

plot @ranges\
	fn_01mW w p title "1\\,mW" pt 2 ps ps lw lw lc 'red',\
	decay(x, 1.637484e+00, 1.640089e-02, 0) w l lc 'black' notitle, \
	fn_02mW w p title "2\\,mW" pt 4 ps ps lw lw lc 'green',\
	decay(x, 1.661441e+00, 3.277329e-02, 0) w l lc 'black' notitle, \
	fn_04mW w p title "4\\,mW" pt 6 ps ps lw lw lc 'blue',\
	decay(x, 1.694566e+00, 6.346895e-02, 0) w l lc 'black' notitle

set output
