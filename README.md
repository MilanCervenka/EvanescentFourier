# MATLAB codes for article "Efficient Fourier-acoustic modeling of evanescent wave effects in metasurface absorbers with arbitrarily shaped elements"

These MATLAB codes can be used to calculate the absorbing properties of a planar metasurface absorber composed of detuned resonators arranged in a rectangular or circular (super-)cell. 

## Directory Cylindrical
In this directory, there are scripts for the cylindrical geometry. Main file is **EvanescentCyl.m**.
* Option **cell_layout = "annular_sectors"** - absorption coefficient spectrum for cell with elements in shape of annular sectors is calculated (Figure 14a in the article).
* Option **cell_layout = "squares"** - absorption coefficient spectrum for cell with square elements is calculated (Figure 15a in the article).


The absorption coefficient spectra are compared (depicted together with) the spectra calculated employing the FEM-simulation. 



Author: [Milam Cervenka](https://phys.fel.cvut.cz/en/person/?who=cervenm3&jaz=en), <milan.cervenka@fel.cvut.cz>

