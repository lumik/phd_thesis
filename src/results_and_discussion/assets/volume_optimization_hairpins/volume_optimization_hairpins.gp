set encoding utf8
reset
# set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 13.5cm,9cm header "\\sffamily\\sansmath"
set output "volume_optimization_hairpins.tex"

fn_125uM  = 'pUIt_125uM.dat'
fn_188uM  = 'pUIt_188uM.dat'
fn_375uM  = 'pUIt_375uM.dat'
fn_750uM  = 'pUIt_750uM.dat'
lw = 2
ps = 2

decay(x, p1, p2, p3) = p1 * exp(-p2 * x) + p3;

set macros
ranges = "[-0.5:20.5][-0.1:14]"

set xlabel 'time (min)'
set ylabel 'intensity (a. u.)'
set xtics 5
unset ytics

set lmargin at screen 0.05

# 125uM  1.331162e+00, 9.728242e-02, 1.687603e-01
# 188uM  2.088407e+00, 1.209959e-01, 2.524462e-01
# 375uM  4.484074e+00, 1.220164e-01, 2.963386e-01
# 750uM  1.227509e+01, 9.818752e-02, 1.969036e-01

plot @ranges\
	fn_125uM w p title "125\\,\\g{m}M, 3.0\\,mL" pt 2 ps ps lw lw lc 'red',\
	decay(x, 1.331162e+00, 9.728242e-02, 0) w l lc 'black' notitle, \
	fn_188uM w p title "188\\,\\g{m}M, 2.0\\,mL" pt 4 ps ps lw lw lc 'green',\
	decay(x, 2.088407e+00, 1.209959e-01, 0) w l lc 'black' notitle, \
	fn_375uM w p title "375\\,\\g{m}M, 1.0\\,mL" pt 6 ps ps lw lw lc 'blue',\
	decay(x, 4.484074e+00, 1.220164e-01, 0) w l lc 'black' notitle, \
	fn_750uM w p title "750\\,\\g{m}M, 0.5\\,mL" pt 8 ps ps lw lw lc 'brown',\
	decay(x, 1.227509e+01, 9.818752e-02, 0) w l lc 'black' notitle

set output
