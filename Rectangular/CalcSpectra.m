% number of discrete points
% along the x and y axis of the super-cell
Nx = 512;
Ny = 512;

if ( supercell == "hexagonal" )
    Nmu = 4;            % number of elements along the x axis
    Nnu = 4;            % number of elements along the y axis
    shape = "hexagon";  % type of elements
    shifts  = true;     % elements between even and odd rows are shifted
    alteror =false;     % orientation of all the elements is the same
    ax = 0.020;         % width of the elements
    hh = 0.002;         % separation distabce between the elements
    Lx = Nmu*(ax+hh);   % dimensions of the super-cell
    Ly = Nnu*(3/tan(pi/3))*(Lx/Nmu/2);
end
if ( supercell == "triangular" )
    Nmu = 6;
    Nnu = 4;
    shape = "triangle";
    shifts  = false;
    alteror =true;      % orientation of the elements switches
    ax = 0.024;
    hh = 0.0015;
    dl = hh/sin(pi/3);
    Lx = Nmu*(ax/2+dl);
    Ly = Nnu*(hh+(ax/2)*tan(pi/3));
end

Ntot = Nmu*Nnu;

Dx = Lx/Nmu;
Dy = Ly/Nnu;

if (symmetry == "periodic")
    x = Lx*(0:Nx-1)/Nx;
    y = Ly*(0:Ny-1)/Ny;
end
if (symmetry == "mirror")
    x = Lx*((1:Nx)-1/2)/Nx;
    y = Ly*((1:Ny)-1/2)/Ny;
end

if (load_spectra)
    load THETA.mat;
    if (symmetry == "periodic")
        Nm0 = Nm+1;   Nn0 = Nn+1;
    end
    if (symmetry == "mirror")
        Nm0 = 1; Nn0 = 1;
    end
else

fprintf("Generating characteristic functions ...\n");

theta  = zeros(Ny, Nx, Ntot);
thetat = zeros(Ny, Nx);
clear THETA;
for ind=1:Ntot
    [mu, nu] = indmunu(ind, Nmu);
    
    if ( ( supercell == "hexagonal" ) )
        x0 = (mu-1/2)*Dx;
        y0 = (nu-1  )*Dy;
    elseif ( supercell == "triangular" )
        x0 = (mu-1  )*Dx;
        y0 = (nu-1/2)*Dy;    
    end
        
    
    if ((shifts)&&(~mod(nu,2)))
        x0 = x0 + Dx/2;
    end

    for ixit=-ceil(Nx/Nmu):ceil(Nx+Nx/Nmu)
        for iyit=-ceil(Ny/Nnu):ceil(Ny+Ny/Nnu)
            xi = (ixit-1)*Lx/Nx;
            yi = (iyit-1)*Ly/Ny;

            ixi = ixit; iyi = iyit;
            if (ixi > Nx) ixi = ixi-Nx; end
            if (iyi > Ny) iyi = iyi-Ny; end
            if (ixi < 1) ixi = ixi+Nx; end
            if (iyi < 1) iyi = iyi+Ny; end
            
            reverse = false;
            if ( alteror )
                reverse = mod(mu+nu, 2);
            end

            if ( shape == "hexagon" )
                isin = InHexa(xi, yi, x0, y0, ax);
            elseif ( shape == "triangle" )
                isin = InTriangle(xi, yi, x0, y0, ax, reverse);                
            else
                isin = false;
            end

            if ( isin )
                theta(iyi, ixi, ind) = 1;
            end
        end
    end
    thetat = thetat + (1+2*(ind-1)/(Ntot-1))*theta(:,:,ind);
    
    if (symmetry == "periodic")
        Nx0 = Nx/2+1; Ny0 = Ny/2+1;
        Nm0 = Nm+1;   Nn0 = Nn+1;
        THETA_tmp = fft2(theta(:,:,ind))/(Nx*Ny);
        THETA_tmp = fftshift(THETA_tmp);
        THETA_tmp = THETA_tmp(Ny0-Nn:Ny0+Nn, Nx0-Nm:Nx0+Nm);
        THETA(:,:,ind) = THETA_tmp;
    end
    if (symmetry == "mirror")
        Nm0 = 1; Nn0 = 1;
        THETA_tmp_x            = dct(theta(:,:,ind),  [], 1);
        THETA_tmp              = dct(THETA_tmp_x, [], 2);
        THETA(:,:,ind)         = THETA_tmp(1:Nn+1,1:Nm+1)/sqrt(Nx*Ny);
    end

    if ( plotgen )
        % [c, h] = contourf(100*x,100*y, theta(:,:,ind), 100); 
        [c, h] = contourf(100*x,100*y, thetat, 100); 
        set(h,'LineColor','none'); 
        title("Layout of the super-cell")
        xlabel("x [cm]"); ylabel("y [cm]"); 
        daspect([1 1 1]);
        drawnow;
        % axis off;
    end
    fprintf("%d / %d\n", ind, Ntot);
end

save THETA.mat THETA;

fprintf("Done.\n");

end 







    

