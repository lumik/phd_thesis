set encoding utf8
reset
#set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 13.5cm,7cm header "\\sffamily\\sansmath"
set output "bounds_1200_range.tex"

fn = 'bounds_1200.dat'
p1 = -0.006800
p2 = 40.542838
f(x) = p1 * x + p2

set macros
ranges = "[225:270][38.7:39]"

set xlabel '$\lambda_1$ (nm)'
set ylabel '$\lambda_2 - \lambda_1$ (nm)'
set xtics 10
set ytics 0.1


plot @ranges fn u 1:($2 - $1) w p pt 7 ps 1 lw 1 lc 0 notitle,\
	f(x) w l lw 2 lc 2 notitle

set output
