set encoding utf8
reset
# set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 13.5cm,8cm header "\\sffamily\\sansmath"
set output "spikes.tex"

fn = 'polydAdT_20.txt'

tm = 0.005
bm = 0.07

set border lw 1.5

set style arrow 1 nohead ls 1 lw 1.2 lc rgb 'black'

set lmargin at screen 0.05
set rmargin 0.1
set tmargin at screen 1 - tm
set bmargin at screen bm

unset ytics
unset key

bborder = 1
lborder = 2
tborder = 4
rborder = 8

set macros
ranges = "[1150:1800][1000:6000]"

set border bborder + lborder + tborder + rborder

set xtics autofreq nomirror
set xlabel 'wavenumber (cm$^{-1}$)' offset 0,.2
set ylabel "Raman intensity (au)" offset 0,0

plot @ranges fn u 1:2 w l lt 1 lw 2 lc 0

set output
