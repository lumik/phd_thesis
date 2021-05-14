set encoding utf8
reset
# set terminal qt enhanced size 1300,1000
set terminal cairolatex pdf color solid size 13.5cm,9cm header "\\sffamily\\sansmath"
set output "concentration_optimization_triplexes.tex"

fn_0500uM  = 'pUIt_0500uM.dat'
fn_1000uM  = 'pUIt_1000uM.dat'
lw = 2
ps = 1

decay(x, p1, p2, p3) = p1 * exp(-p2 * x) + p3;

set macros
ranges = "[0:26][0:1.9]"

set xlabel 'time (min)'
set ylabel 'intensity (a. u.)' offset -1,0
set xtics 5
unset ytics
# cairo terminal somehow makes line spacing larger than eps output.
set key font ',0.8'

# 500uM  7.600636e-01, 1.875256e-02
# 1000uM  1.442362e+00, 1.034071e-02

plot @ranges\
	fn_0500uM w p title "500\\,\\g{m}M" pt 2 ps ps lw lw lc 'red',\
	decay(x, 7.600636e-01, 1.875256e-02, 0) w l lc 'black' notitle, \
	fn_1000uM w p title "1000\\,\\g{m}M" pt 4 ps ps lw lw lc 'green',\
	decay(x, 1.442362e+00, 1.034071e-02, 0) w l lc 'black' notitle

set output
