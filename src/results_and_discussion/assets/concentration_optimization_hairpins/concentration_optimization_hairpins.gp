set encoding utf8
reset
# set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 13.5cm,9cm header "\\sffamily\\sansmath"
set output "concentration_optimization_hairpins.tex"

fn_01mW  = 'pUIt_075uM.dat'
fn_02mW  = 'pUIt_250uM.dat'
fn_04mW  = 'pUIt_750uM.dat'
lw = 2
ps = 2

decay(x, p1, p2, p3) = p1 * exp(-p2 * x) + p3;

set macros
ranges = "[-0.5:20.5][-1:14]"

set xlabel 'time (min)'
set ylabel 'intensity (a. u.)'
set xtics 5
unset ytics

set lmargin at screen 0.05

#  75uM  9.264898e-01, 7.453779e-01, 1.542189e-01
# 250uM  3.736711e+00, 3.041190e-01, 3.218297e-01
# 750uM  1.227509e+01, 9.818752e-02, 1.969036e-01

plot @ranges\
	fn_01mW w p title "75\\,\g{m}M" pt 2 ps ps lw lw lc 'red',\
	decay(x, 9.264898e-01, 7.453779e-01, 0) w l lc 'black' notitle, \
	fn_02mW w p title "250\\,\g{m}M" pt 4 ps ps lw lw lc 'green',\
	decay(x, 3.736711e+00, 3.041190e-01, 0) w l lc 'black' notitle, \
	fn_04mW w p title "750\\,\g{m}M" pt 6 ps ps lw lw lc 'blue',\
	decay(x, 1.227509e+01, 9.818752e-02, 0) w l lc 'black' notitle

set output
