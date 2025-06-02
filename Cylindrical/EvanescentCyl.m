% after calculating the spectra, it is saved in file THETA.mat
% if "load_spectra" is set to true, it is not calculated again,
% it is loaded from the file THETA.mat
% if "load_spectra" set to false, spectra is always recalculated
load_spectra = false;

% if the spectra are calculated, the shape functions for the individual
% elements can be plotted during the calculation
plotgen = true;

% what layout of cell to calculate
cell_layout = "annular_sectors";    % cell with elements with shape of annular sectors
% cell_layout = "squares";          % cell with square elements


% the number of evanescent modes accounted for
Nm = 8;
Nn = 8;

% Radius of the waveguide
R = 0.05;

if ( cell_layout == "annular_sectors" )
    dh  = 2.00e-04;     % diameters of the holes in MPP
    phi = 0.0984;       % the MPP perforation ratio
    tp  = 5.00e-4;      % thickness of the MPP
    % lengths of the backing cavities
    Li  = load("./data/Li_opt_annular_sectors.txt");
    % results of the FEM simulation in COMSOL
    comsol = load("data\Alfa_comsol_opt_annular_sectors.txt");
    % title of the generated figure
    plottitle = "Fig. 14a: Absorption coefficient, annular sectors";
end
if ( cell_layout == "squares" )
    dh  = 2.00e-04;
    phi = 0.0873;
    tp  = 5.00e-4; 
    Li  = load("./data/Li_opt_squares.txt");
    comsol = load("data\Alfa_comsol_opt_squares.txt");
    plottitle = "Fig. 15a: Absorption coefficient, squares";
end


% calculates (or loads) the spectra
CalcSpectra;


% speed of sound [m/s]
c0 = 343;
% air ambient density [kg/m^3]
rho0 = 1.2;
% dynamic viscosity of air [Pa*s]
mu    = 1.83e-5;

% calculating the cut-on frequency
fcut =  1.8412*c0/(2*pi*R);

% structure with parameters
pars = struct('Nm',  Nm,  'Nn',  Nn, ...
              'R',  R, ...
              'c0',  c0, 'rho0', rho0, 'mu',  mu,...
              'phi', phi, 'dh', dh, 'tp', tp);

% characteristic impedance          
Z0 = rho0*c0;

% frequencies for which the absorption coefficient is calculated
fmax = floor(fcut)-1;
fi = [1 10:10:fmax];


tic;
for countf = 1 : length(fi)

    M = zeros(Ntot, Ntot);

    % setting the elements of the system matrix of Eq.(17)
    for ii = 1 : Ntot
        for jj = ii : Ntot
          Hmat = Hcyl(ii, jj, fi(countf), pars, THETA, JDroot);

            M(ii, jj) = Z0*Hmat/THETA(1, 1, ii);
            M(jj, ii) = M(ii, jj)*THETA(1, 1, ii)/THETA(1, 1, jj);
          

            if (ii == jj)
                Z = Zin(fi(countf), Li(ii), pars);
                M(ii, jj) = M(ii, jj) + Z;
            end
        end
    end

    b  = 2*ones(Ntot, 1);
    Vi = M \ b;

    AvV = 0;
    for ii = 1 : Ntot
        AvV = AvV + THETA(1, 1, ii)*Vi(ii);
    end

    % reflection coefficient modulus - Eq.(34)
    Rkoefi(countf) = abs(1-Z0*AvV);
    % absorption coefficient
    Alfai(countf)  = 1 - Rkoefi(countf)^2;
end
toc;

% mean value of the absorption coefficient
AlfaMean = trapz(fi, Alfai)/(max(fi)-min(fi));

figure(2);
plot(fi, Alfai, 'b');
hold on;
plot(comsol(:,1), comsol(:,2), 'r--', 'linewidth', 1);
hold off;
legend("Analytical model", "FEM simulation", 'Location','southeast');
xlabel("f [Hz]");
ylabel("\alpha");
title(plottitle);

