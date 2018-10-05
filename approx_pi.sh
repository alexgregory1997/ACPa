#!/bin/sh

# check

# Create folder/remove old data
folder="Graphs"
if [ -e $folder ]; then
  rm  -rf $folder
fi
mkdir $folder

folder="Data"
if [ -e $folder ]; then
  rm  -rf $folder
fi
mkdir $folder

# if program terminated early then to avoid corruption of the read.in file, it must be deleted if already present
file="read.in"
if [ -e $file ]; then
  rm  -rf $file
fi

# read param.in file, remove unwanted part of line and then read values into variables
cut -d "=" -f 2 param.template.in | sed "s/^[ \t]*//" >> read.in

# move param.template.in to Data directory - this is used to show what parameters were used for this run
cat param.template.in >> param.in
mv param.in ./Data

# compile with flags
gfortran -fcheck=all approxing_pi.f90;

# execute and read in variables
./a.out < read.in

# create batch files for xmgrace
rm -f bat_1.bat
echo "title \"N vs Pi Approximation\""  >> bat_1.bat
echo "yaxis label \"Pi Approximation\"" >> bat_1.bat
echo "xaxis label \"N\""                >> bat_1.bat

rm -f bat_2.bat
echo "title \"N vs RMSE\""  >> bat_2.bat
echo "yaxis label \"RMSE\"" >> bat_2.bat
echo "xaxis label \"N\""    >> bat_2.bat

# plot data and produce .PNG of graphs
xmgrace -maxpath X -block pi.dat -bxy 1:2 -autoscale xy -hdevice PNG -hardcopy -batch bat_1.bat -printfile ./Graphs/NvsPiApp.png  $i
xmgrace -maxpath X -block pi.dat -bxy 1:3 -autoscale xy -hdevice PNG -hardcopy -batch bat_2.bat -printfile ./Graphs/NvsRMSE.png  $i

# move data files
mv pi.dat ./Data

# remove files no longer required
rm *.bat
rm *.out
rm read.in

# Produce a sound when the program is complete
echo $'\a'
