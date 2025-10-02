# MATLAB codes for article "Efficient Fourier-acoustic modeling of evanescent wave effects in metasurface absorbers with arbitrarily shaped elements"

[Link to the article in Applied Mathematical Modelling](https://doi.org/10.1016/j.apm.2025.116471)

These MATLAB codes can be used to calculate the absorbing properties of a planar metasurface absorber composed of detuned resonators arranged in a rectangular or circular (super-)cell. 

## Directory Rectangular

The absorption coefficient spectra are compared (depicted together with) the spectra calculated employing the FEM-simulation. 
In this directory, there are scripts for the rectangular geometry. Main file is **EvanescentRect.m**.
* Option **whattocalc = "Fig8a""** - absorption coefficient spectrum for a rectangular super-cell with hexagonal elements and periodic symmetry  (Figure 8a in the article).
* Option **whattocalc = "Fig8b""** - absorption coefficient spectrum for a rectangular super-cell with hexagonal elements and mirror symmetry  (Figure 8b in the article).
* Option **whattocalc = "Fig12a""** - absorption coefficient spectrum for a rectangular super-cell with triangular elements and periodic symmetry  (Figure 12a in the article).
* Option **whattocalc = "Fig12b""** - absorption coefficient spectrum for a rectangular super-cell with triangular elements and mirror symmetry  (Figure 12b in the article).

In file **EvanescentRect.m**, the value of variable **havesigproctoolbox** (true / false) determines whether to calculate the Discrete Cosine Transform employing function dct() from the Signal Processing Toolbox, or employing the FFT algorithmm which is a little bit slower, but it does not require any additional toolbox.

## Directory Cylindrical
In this directory, there are scripts for the cylindrical geometry. Main file is **EvanescentCyl.m**.
* Option **cell_layout = "annular_sectors"** - absorption coefficient spectrum for a cell with elements in shape of annular sectors is calculated (Figure 15a in the article).
* Option **cell_layout = "squares"** - absorption coefficient spectrum for a cell with elements in shape of squares and circular segments is calculated (Figure 16a in the article).

[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=MilanCervenka/EvanescentFourier)

Author: [Milam Cervenka](https://phys.fel.cvut.cz/en/person/?who=cervenm3&jaz=en), <milan.cervenka@fel.cvut.cz>

