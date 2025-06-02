# MATLAB codes for article "Efficient Fourier-acoustic modeling of evanescent wave effects in metasurface absorbers with arbitrarily shaped elements"

These MATLAB codes can be used to calculate the absorbing properties of a planar metasurface absorber composed of detuned resonators arranged in a rectangular or circular (super-)cell. 

## Directory Cylindrical
In this directory, there are scripts for the cylindrical geometry. Main file is **EvanescentCyl.m**.
* Option **cell_layout = "annular_sectors"** - absorption coefficient spectrum for a cell with elements in shape of annular sectors is calculated (Figure 14a in the article).
* Option **cell_layout = "squares"** 

[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=MilanCervenka/EvanescentFourier/Cylindrical)

## Directory Rectangular

The absorption coefficient spectra are compared (depicted together with) the spectra calculated employing the FEM-simulation. 
In this directory, there are scripts for the rectangular geometry. Main file is **EvanescentRect.m**.
* Option **whattocalc = "Fig8a""** - absorption coefficient spectrum for a rectangular super-cell with hexagonal elements and periodic symmetry  (Figure 8a in the article).
* Option **whattocalc = "Fig8b""** - absorption coefficient spectrum for a rectangular super-cell with hexagonal elements and mirror symmetry  (Figure 8b in the article).
* Option **whattocalc = "Fig11a""** - absorption coefficient spectrum for a rectangular super-cell with triangular elements and periodic symmetry  (Figure 11a in the article).
* Option **whattocalc = "Fig11b""** - absorption coefficient spectrum for a rectangular super-cell with triangular elements and mirror symmetry  (Figure 11b in the article).

Author: [Milam Cervenka](https://phys.fel.cvut.cz/en/person/?who=cervenm3&jaz=en), <milan.cervenka@fel.cvut.cz>

