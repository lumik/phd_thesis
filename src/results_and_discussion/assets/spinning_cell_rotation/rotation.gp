set encoding utf8
reset
#set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 13.5cm,9cm header "\\sffamily\\sansmath"
set output "rotation.tex"

fn_rotation = 'rotation.dat'

set macros
ranges = "[0:10][:]"

f(x) = a * x + b
fit f(x) fn_rotation u 1:($2 * 60.) via a, b

set grid

set samples 100

set xlabel 'voltage (V)'
set ylabel '$\omega$ (rpm)' offset -1,0

plot @ranges fn_rotation u 1:($2 * 60.) w p ps 5 lw 2 title 'measurement',\
    f(x) w l lw 2 title 'fit'

set output
