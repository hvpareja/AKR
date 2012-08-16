# set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 500, 350 
# set output 'poldat.3.png'
unset border
set dummy t,y
set grid polar 0.523599
set grid noxtics nomxtics noytics nomytics noztics nomztics \
 nox2tics nomx2tics noy2tics nomy2tics nocbtics nomcbtics
set grid layerdefault   linetype 0 linewidth 1.000,  linetype 0 linewidth 1.000
set key inside right top vertical Right noreverse enhanced autotitles box linetype -1 linewidth 1.000
set key noinvert samplen 0.75 spacing 1 width 0 height 0 
set key opaque
set logscale r 10
set polar
set view  equal xy
set size ratio 1 1,1
set style data impulses
set noxtics
set noytics
set rtics axis in scale 0.5,0 nomirror rotate by -270  offset character 0, 0.7, 0 autojustify
set rtics  norangelimit
set rtics   (2.00000, 5.00000, 10.0000, 15.0000)
set title "log scale polar axis" 
set rrange [ 0.500000 : 19.0000 ] noreverse nowriteback
set xrange [ -1.57978 : 1.57978 ] noreverse nowriteback
set yrange [ -1.57978 : 1.57978 ] noreverse nowriteback
tv(t,r) = sin(t)/(1+r)
tu(t,r) = (cos(t) +r)/(1+r)
cu(t,x) = 1 + cos(t)/x
cv(t,x) = (1+ sin(t))/x
GPFUN_tv = "tv(t,r) = sin(t)/(1+r)"
GPFUN_tu = "tu(t,r) = (cos(t) +r)/(1+r)"
GPFUN_cu = "cu(t,x) = 1 + cos(t)/x"
GPFUN_cv = "cv(t,x) = (1+ sin(t))/x"
plot 'silver.dat' using ($1/100.):3:0 lc var lw 2 title 'silver.dat'