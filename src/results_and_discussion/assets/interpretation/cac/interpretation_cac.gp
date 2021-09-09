set encoding utf8
reset
# set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 13.5cm,9cm header "\\sffamily\\sansmath"
set output "interpretation_cac.tex"

datfn = 'cac_low.dat'
bandsfn = 'plotcac_lowbands.dat'
artefactfn = 'plotcac_lowbands_artf.dat'
labeltext = '$\lambda_\mathrm{excitation} = 244$\,nm'

du = .3  # band assignment line segment length
zu1 = .1  # first break of the segment - y distance from the beginning
zu2 = .2  # second break of the segment - y distance from the beginning
cyu = .1  # identation of the beginning of the segment from spectrum
cxt = 0.0  # text shift in x axis
cyt3 = cyu + du + 0.7  # y shift of text from the band from 3-digit numbers
cyt4 = cyu + du + 1.0  # y shift of text from the band from 3-digit numbers
cysol = .2  # identation of star from spectrum
cxsol = .0  # x-shift of text

tm = 0.005
bm = 0.11

set border lw 1.5

set style arrow 1 nohead ls 1 lw 1.2 lc rgb 'black'

unset key

set lmargin at screen 0.05
set rmargin 0.1
set tmargin at screen 1 - tm
set bmargin at screen bm

unset ytics

bborder = 1
lborder = 2
tborder = 4
rborder = 8

set macros
ranges = "[500:1800][-.5:12]"

set border bborder + lborder + tborder + rborder

set xtics autofreq nomirror
set xlabel 'wavenumber (cm$^{-1}$)' offset 0,.2
set ylabel "Raman intensity (au)" offset 0,0

plot @ranges datfn u 1:2 w l lt 1 lw 2 lc 0,\
	bandsfn u 1:($2 + $5 + cyu):(0):(zu1) w vectors arrowstyle 1 notitle,\
	bandsfn u 1:($2 + $5 + cyu + zu1):($3):($4 + zu2 - zu1) w vectors arrowstyle 1 notitle,\
	bandsfn u ($1 + $3):($2 + $4 + $5 + cyu + zu2):(0):(du - zu2) w vectors arrowstyle 1 notitle,\
	bandsfn u ($1 + $3 + cxt):((($1 + 0.5) / 1000 < 1) ? ($2 + $4 + $5 + cyt3) : ($2 + $4 + $5 + cyt4)):(sprintf("\\\\scriptsize %d",$1 + 0.5)) with labels rotate right notitle,\
	artefactfn u ($1 + $3 + cxsol):($2 + $4 + cysol):("\\\\scriptsize*") with labels notitle

set output