set encoding utf8
reset
#set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 13.5cm,7cm header "\\sffamily\\sansmath"
set output "bounds_1200_range.tex"

fn = 'bounds_1200.dat'

N_gr = 1200  # gr/mm
f = 568.72  # focal length
phi_deg = 6.498 * 2  # Ebert angle
m = 1  # diffraction order
l_ccd = 27.56043

deg2rad(x) = x / 180. * pi
phi = deg2rad(phi_deg)
a = 1. / N_gr
dispersion(lambda) = l_ccd * a * 1e6 * cos(asin((m * lambda * 1e-6) / (2 * a * cos(phi / 2.))) + phi / 2.) / (m * f)

set macros
ranges = "[245:290][38.7:39]"

set xlabel '$\lambda$ (nm)'
set ylabel '$\Delta\lambda$ (nm)'
set xtics 10
set ytics 0.1


plot @ranges fn u ($2 + $1) / 2:($2 - $1) w p pt 7 ps 1 lw 1 lc 0 notitle,\
	dispersion(x) w l lw 2 lc 2 notitle

set output
