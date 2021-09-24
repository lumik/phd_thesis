set encoding utf8
reset
# set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 13.5cm,17cm header "\\sffamily\\sansmath"
set output "rna_triplex_difference.tex"

fndiff = 'ds_difference.dat   ts_difference.dat'
dbands = 'plotdsdiffbands.dat plottsdiffbands.dat'
dkak   = 'plotdsdiffbands_kak.dat plottsdiffbands_kak.dat'
ddy    = '-11                 -25'

labels = '"2$\times$duplex $-$ (polyA + polyU)"  "3$\times$triplex $-$ (2$\times$duplex + polyU)"'
lposx  = '                         360                             360'
lposy  = '                         -70                            -190'
llabels = '                        a)                              b)'
llposx = 400
lldy   = 1.3

mlposx  = '1788  1788'
mlposy  = '-98   -255'

# delka usecky prirazeni pasu
du=0.9

# prvni zlom usecky v y-vzdalenosti od pocatku usecky
zu1=.3

# druhy zlom usecky v y-vzdalenosti od pocatku usecky
zu2=.6

# odsazeni pocatku usecky od krivky
cyu=.3

# posunuti textu vuci pasu v x-ove ose
cxt=.0

# odsazeni popisku od pasu pro 3-ciferna cisla
cyt3=cyu+du+1.2

# odsazeni popisku od pasu pro 4-ciferna cisla
cyt4=cyu+du+1.6

# odsazeni hvezdicek od krivky
cysol = .3

# posunuti textu v x-ove ose
cxsol = .0

# odsazeni hvezdicek od diff krivky nahoru
pcydsol = .3

# odsazeni hvezdicek od diff krivky dolu
mcydsol = -0.8


tm = 0.005
bm = 0.11
M = words(fndiff)

set_label(ii, x, y) = sprintf("set label '%s' at first %f, %f right",  word(labels, ii), x, y)
set_llabel(ii, y) = sprintf("set label '%s' at first %f, %f right",  word(llabels, ii), llposx, y+lldy)

set border lw 1.5

set style arrow 1 nohead ls 1 lw 1.2 lc rgb 'black'

# vykresleni grafu
unset key

set lmargin 3
set rmargin 0.3
set tmargin at screen 1-0.005
set bmargin at screen 0.07

unset ytics

bborder = 1
lborder = 2
tborder = 4
rborder = 8

set macros
ranges = "[1800:350][-37:-4.0]"

set border bborder + lborder + tborder + rborder

set xtics autofreq nomirror
set xlabel 'wavenumber (cm$^{-1}$)' offset 0,.2
set ylabel "Raman intensity (au)" offset 0,0

do for [ii = 1:words(labels)] {
	evaluate set_label(ii, int(word(lposx, ii)), int(word(lposy, ii)) / 10.)
	evaluate set_llabel(ii, int(word(lposy, ii)) / 10.)
}

plot @ranges for [ii = 1:M] word(fndiff, ii) u 1:($2+int(word(ddy, ii))) w l lt 1 lw 2 lc 0,\
	 for [ii = 1:M] word(dbands, ii) u 2:(($1 > 0) ? ($3+$6+cyu+int(word(ddy, ii))) : ($3-$6-cyu+int(word(ddy, ii)))): \
		(0):(($1 > 0) ? (zu1) : (-zu1)) w vectors arrowstyle 1 notitle,\
	 for [ii = 1:M] word(dbands, ii) u 2:(($1 > 0) ? ($3+$6+cyu+zu1+int(word(ddy, ii))) : ($3-$6-cyu-zu1+int(word(ddy, ii)))): \
		($4):(($1 > 0) ? ($5+zu2-zu1) : -($5+zu2-zu1)) w vectors arrowstyle 1 notitle, \
	 for [ii = 1:M] word(dbands, ii) u ($2+$4):(($1 > 0) ? ($3+$5+$6+cyu+zu2+int(word(ddy, ii))) : ($3-$5-$6-cyu-zu2+int(word(ddy, ii)))): \
		(0):(($1 > 0) ? (du-zu2) : -(du-zu2)) w vectors arrowstyle 1 notitle, \
	 for [ii = 1:M] word(dbands, ii) u ($2+$4+cxt):( ($1 > 0) ? \
		((($2+0.5) / 1000 < 1) ? ($3+$5+$6+cyt3+int(word(ddy, ii))) : ($3+$5+$6+cyt4+int(word(ddy, ii)))) : 1/0 ): \
		(sprintf("\\\\scriptsize %d",$2+0.5)) with labels rotate right notitle, \
	 for [ii = 1:M] word(dbands, ii) u ($2+$4+cxt):( ($1 < 0) ? \
		((($2+0.5) / 1000 < 1) ? ($3-$5-$6-cyt3+int(word(ddy, ii))) : ($3-$5-$6-cyt4+int(word(ddy, ii)))) : 1/0 ): \
		(sprintf("\\\\scriptsize %d",$2+0.5)) with labels rotate left notitle, \
	 for [ii = 1:M] word(dkak, ii) u ($2+$4+cxsol):(($1 > 0) ? ($3+$5+pcydsol+int(word(ddy, ii))) : ($3+$5+mcydsol+int(word(ddy, ii))) ):("\\\\scriptsize *") with labels notitle

set output
