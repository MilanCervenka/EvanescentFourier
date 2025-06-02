
% number of squares
Nmunu = 3;
Nmu = Nmunu;    % along the x axis
Nnu = Nmunu;    % along the y axis

% separation distance between the elements
% mormalized to the cell radius
hh = 0.001/R;
L = sqrt(2);
Dxy = L /Nmunu;
Dx = Dxy;
Dy = Dxy;
a  = Dxy-hh;

Ntot = Nmu*Nnu+4;

xp = linspace(-1,1,Nres);
yp = xp;

Theta  = zeros(Nres, Nres, Ntot);
ThetaT = zeros(Nres, Nres);

x = repmat(xp, Nres, 1); y = x';
r = sqrt(x.^2 + y.^2);
for i=1:Nres
    for j=1:Nres
        if (r(i,j) >=1)
            ThetaT(i,j) = NaN;
        end
    end
end


for ind=1:Ntot
    if (ind <= Ntot-4)
        [mu, nu] = indmunu(ind, Nmu);
        x0 = -Dx*(Nmu-1)/2 + (mu-1)*Dx;
        y0 = -Dy*(Nnu-1)/2 + (nu-1)*Dy;

        for ixi = 1 : length(xp)
            for iyi = 1 : length(yp)
                xi = xp(ixi);
                yi = yp(iyi);
            
                isin = InRectangle(xi, yi, x0, y0, a, a, false);
            
                if ( isin )
                    Theta(iyi, ixi, ind) = 1;
                end
            end
        end
    end
    
    if ( ind == Ntot-3 )
        for ixi = 1 : length(xp)
            for iyi = 1 : length(yp)
                xi = xp(ixi);
                yi = yp(iyi);
                isin = ( yi > -sqrt( (1-hh)^2 - xi^2 ) ) && ( yi < -(L+hh)/2 );
                if ( isin )
                    Theta(iyi, ixi, ind) = 1;
                end
            end
        end
    end
    if ( ind == Ntot-2 )
        for ixi = 1 : length(xp)
            for iyi = 1 : length(yp)
                xi = xp(ixi);
                yi = yp(iyi);
                isin = ( xi < sqrt( (1-hh)^2 - yi^2 ) ) && ( xi > (L+hh)/2 );
                if ( isin )
                    Theta(iyi, ixi, ind) = 1;
                end
            end
        end
    end
    if ( ind == Ntot-1 )
        for ixi = 1 : length(xp)
            for iyi = 1 : length(yp)
                xi = xp(ixi);
                yi = yp(iyi);
                isin = ( yi < sqrt( (1-hh)^2 - xi^2 ) ) && ( yi > (L+hh)/2 );
                if ( isin )
                    Theta(iyi, ixi, ind) = 1;
                end
            end
        end
    end
    if ( ind == Ntot )
        for ixi = 1 : length(xp)
            for iyi = 1 : length(yp)
                xi = xp(ixi);
                yi = yp(iyi);
                isin = ( xi > -sqrt( (1-hh)^2 - yi^2 ) ) && ( xi < -(L+hh)/2 );
                if ( isin )
                    Theta(iyi, ixi, ind) = 1;
                end
            end
        end
    end


    ThetaT = ThetaT + (1+2*(ind-1)/(Ntot-1))*Theta(:,:,ind);

    if ( plotgen )
        % [c, h] = contourf(xp,yp, Theta(:,:,ind), 100); 
        [c, h] = contourf(xp,yp, ThetaT, 100); 
        set(h,'LineColor','none'); 
        xlabel("x/R"); ylabel("y/R"); 
        title("Cell layout");
        daspect([1 1 1]);
        drawnow;
        fprintf("%d / %d\n", ind, Ntot);
    end

end