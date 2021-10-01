set encoding utf8
reset

# set terminal qt enhanced
set terminal epslatex color dashed size 13cm,7cm header "\\sffamily\\sansmath"
set output 'F.tex'

W_s = 50.e-6
L_s = 6.9e-3 / 1.1
Omega_s = 2. * pi * (1. - cos(atan(1. / 10.5)))
M = 4. * 25.4 / 13.
lambda_0 = 257.2e-9
d = 0.9e-3
n_water257 = 1.3598
lambda = lambda_0 / n_water257

theta_min = 0.032
theta_max = 0.040
F_min = 0.1
F_max = 0.135
#theta_min = 0.015
#theta_max = 0.045
#F_min = 0.1
#F_max = 0.3

omega_0(theta) = 2 * lambda / (pi * theta)
b(theta) = 8 * lambda / (pi * theta**2)
W_e(theta) = 2 * omega_0(theta)
L_e(theta) = 2 * b(theta)

A = 10 # absorbance na 1cm

theta_W = W_e(1.0) * M / W_s
theta_L = sqrt(L_e(1.0) * M / L_s)

fI(theta) = (W_s * Omega_s * M) / (4 * pi * W_e(theta))
fII(theta) = (W_s * Omega_s * M**2 * L_e(theta)) / (4 * pi * L_s * W_e(theta))
fIII(theta) = (Omega_s * M**3 * L_e(theta)) / (4 * pi * L_s)

f(x) = (x <= theta_L) ? fI(x) : ( (x <= theta_W) ? fII(x) : fIII(x) )

set samples 1e3

print 'lambda_0 = ', lambda_0 * 1e9, 'nm'
print 'n_water257 = ', n_water257
print 'lambda = ', lambda * 1e9, 'nm'
print 'Omega_s = ', Omega_s
print 'Omega_fraction = ', Omega_s * M**2 / (4 * pi)
print 'theta_W = ', theta_W
print 'theta_L = ', theta_L
print 'f_W = ', d / theta_W * 1e3, 'mm'
print 'f_L = ', d / theta_L * 1e3, 'mm'
print 'A_1cm = ', A
print 'W_e_W = ', W_e(theta_W) * 1e6, 'um'
print 'W_e_L = ', W_e(theta_L) * 1e6, 'um'
print 'L_e_W = ', L_e(theta_W) * 1e6, 'um'
print 'L_e_L = ', L_e(theta_L) * 1e6, 'um'
print 'T_1_e = ', log10(2) / (A * 1e2) * 1e6, 'um'

label_pos_F = F_min + (F_max - F_min) * 0.85
set label '\shortstack{Region I\\$0 < \vartheta < \vartheta_\text{L}$}' \
	at ((theta_min + theta_L) / 2),label_pos_F center
set label '\shortstack{Region II\\$\vartheta_\text{L} < \vartheta < \vartheta_\text{W}$}' \
	at ((theta_L + theta_W) / 2),label_pos_F center
set label '\shortstack{Region III\\$\vartheta_\text{W} < \vartheta$}' \
	at ((theta_W + theta_max) / 2),label_pos_F center

set xtics ()
#set xtics add (sprintf('$\vartheta_\text{L} = %.1f\cdot10^{-2}$', theta_L*1e2) theta_L, \
#              sprintf('$\vartheta_\text{W} = %.1f\cdot10^{-2}$', theta_W*1e2) theta_W)
set xtics add ('$\vartheta_\text{L}$' theta_L, '$\vartheta_\text{W}$' theta_W)
set xtics add (theta_min, theta_max)
set ytics 0.01

unset key

set xlabel '$\vartheta$'
set ylabel '$F$' offset 2

#plot [0.03:0.06][:] fI(x), fII(x), fIII(x)
plot [theta_min:theta_max][F_min:F_max] f(x) lw 2 lc rgb 'red', \
    '-' w l lt 2 lc rgb 'black' lw 2, \
    '-' w l lt 2 lc rgb 'black' lw 2
0.0346441566534199 0.1
0.0346441566534199 0.135
e
0.03764318805711 0.1
0.03764318805711 0.135
e

set output
