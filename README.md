<!-- Note, the formatted .md file can be viewed at https://github.com/alexgregory1997/ACPa) --> 

__DEPENDENCIES__ <br />
Gfortran - Compiler <br />
https://gcc.gnu.org/wiki/GFortran <br />
Grace - Plotting <br />
http://plasma-gate.weizmann.ac.il/Grace/ <br />

__FUNCTION__ <br />
This program approximates the value of Pi using the expression provided within
Q0. <br />

__PROGRAM__ <br />
The program consists of 3 files:
- approx_pi.sh <br />
- approxing_pi.f90 <br />
- param.template.in <br />

The UI for this program is the param.template.in file. Within this, the
parameters for the program can be modified. These include:
- _n_start_   - The minimum N used to calculate an approximation of Pi <br />
- _n_final_   - The maximum N used to calculate an approximation of Pi <br />
- _n_spacing_ - The spacing between values of N to calculate. For example, if
                _n_start_ = 5, _n_final_ = 100 and _n_spacing_ = 5, then the
                program will calculate an approximation for Pi for N=5,10,...,100. <br />

The shell script, _approx_pi.sh_ will run _approxing_pi.f90_ for the given
parameters contained within _param.template.in_. <br />

After running, the program will create two new directories, _Graphs_ and _Data_.
_Graphs_ will contain .PNG files of graphs of N vs approximation of Pi and N vs
the root-mean-square error relative to a known value of Pi. _Data_ will contain
the raw data containing N value, approximation of Pi and the RMSE, as well as a
file, named _param.in_, which contains the parameters used for the previous run. <br />

Note, files will be removed (data lost) if the program is ran again. By that,
I mean all previous data is deleted and then new data replaces it (outlined in
the _approx_pi.sh_ script). <br />
