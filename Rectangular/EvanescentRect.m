% after calculating the spectra, it is saved in file THETA.mat
% if "load_spectra" is set to true, it is not calculated again,
% it is loaded from the file THETA.mat
% if "load_spectra" set to false, spectra is always recalculated
load_spectra = false;

% if the spectra are calculated, the shape functions for the individual
% elements can be plotted during the calculation
plotgen = true;

% the number of evanescent modes accounted for
Nm = 8;
Nn = 8;

whattocalc = "Fig8a";      % hexagonal elements, periodic symmetry
% whattocalc = "Fig8b";    % hexagonal elements, mirror symmetry
% whattocalc = "Fig11a";   % triangular elements, periodic symmetry
% whattocalc = "Fig11b";   % triangular elements, mirror symmetry

if ( whattocalc == "Fig8a" )
    supercell = "hexagonal";
    symmetry  = "periodic";
end
if ( whattocalc == "Fig8b" )
    supercell = "hexagonal";
    symmetry  = "mirror";
end
if ( whattocalc == "Fig11a" )
    supercell = "triangular";
    symmetry  = "periodic";
end
if ( whattocalc == "Fig11b" )
    supercell = "triangular";
    symmetry  = "mirror";
end
    

% what type of elements form the super-cell
% supercell = "hexagonal";
% supercell = "triangular";

% what symmetry is used
% symmetry = "mirror";
% symmetry = "periodic";


% calculation / loading of spectra
CalcSpectra;

% speed of sound [m/s]
c0 = 343;
% air ambient density [kg/m^3]
rho0 = 1.2;
% dynamic viscosity of air [Pa*s]
mu    = 1.83e-5;


% calculating the maxium frequency of interest
if (symmetry == "periodic")
    fmax = c0/max(Lx, Ly)/2;
end
if (symmetry == "mirror")
    fmax = c0/max(Lx, Ly)/2; 
end

if (supercell == "hexagonal")
    if (symmetry == "mirror")
        % diameter of holes in MPP
        dh  = 2.00e-04;
        % perforation ratio of the MPP
        phi = 0.112;
        % thickness of the MPP
        tp  = 5.00e-4; 
        % loading the lengths of the backing cavities
        Li  = load("./data/Li_opt_hexagonal_mirror.txt");
        % loading the FEM data calculated in COMSOL
        comsol = load("data\Alfa_comsol_opt_hexagonal_mirror.txt");
        % title of generated figure
        plottitle = "Fig 8b: Absorption coefficient, hexagonal elements, mirror symmetry";
    end % end symmetry mirror
    if (symmetry == "periodic")
        dh  = 2.00e-04;
        phi = 0.112;
        tp  = 5.00e-4; 
        Li  = load("./data/Li_opt_hexagonal_periodic.txt");
        comsol = load("data\Alfa_comsol_opt_hexagonal_periodic.txt");
        plottitle = "Fig 8a: Absorption coefficient, hexagonal elements, periodic symmetry";        
    end % end symmetry mirror
end % end hexagonal elements

if (supercell == "triangular")
    if (symmetry == "mirror")
        dh  = 2.01e-04;
        phi = 0.115;
        tp  = 5.00e-4; 
        Li  = load("./data/Li_opt_triangular_mirror.txt");
        comsol = load("data\Alfa_comsol_opt_triangular_mirror.txt");
        plottitle = "Fig. 11b: Absorption coefficient, triamgular elements, mirror symmetry";
    end % end symmetry mirror
    if (symmetry == "periodic")
        dh  = 2.01e-04;
        phi = 0.118;
        tp  = 5.00e-4; 
        Li  = load("./data/Li_opt_triangular_periodic.txt");
        comsol = load("data\Alfa_comsol_opt_triangular_periodic.txt");
        plottitle = "Fig. 11a: Absorption coefficient, triangular elements, periodic symmetry";        
    end % end symmetry mirror
end % end triangilar elements


% structure with parameters
pars = struct('Nm',  Nm,  'Nn',  Nn, ...
              'Nm0', Nm0, 'Nn0', Nn0, ...
              'Lx',  Lx,  'Ly',  Ly, ...
              'c0',  c0, 'rho0', rho0, 'mu',  mu,...
              'phi', phi, 'dh', dh, 'tp', tp);

% characteristic impedance          
Z0 = rho0*c0;

% limiting the maximum frequency of interest
fmax = floor(fmax)-1;
fi = [1 10:10:fmax];

tic;
for countf = 1 : length(fi)

    M = zeros(Ntot, Ntot);

    % setting the elements of the system matrix of Eq.(17)
    for ii = 1 : Ntot
        for jj = ii : Ntot
            if (symmetry == "periodic")
                Hmat = Hper(ii, jj, fi(countf), pars, THETA);
            end
            if (symmetry == "mirror")
                Hmat = Hmir(ii, jj, fi(countf), pars, THETA);
            end

            M(ii, jj) = Z0*Hmat/THETA(Nn0, Nm0, ii);
            M(jj, ii) = M(ii, jj);
          

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
        AvV = AvV + THETA(Nn0, Nm0, ii)*Vi(ii);
    end

    % reflection coefficient modulus - Eq.(34)
    Rkoefi(countf) = abs(1-Z0*AvV);
    % absorption coefficient
    Alfai(countf)  = 1 - Rkoefi(countf)^2;

end
toc;

% mean value of the avsorption coefficient
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

