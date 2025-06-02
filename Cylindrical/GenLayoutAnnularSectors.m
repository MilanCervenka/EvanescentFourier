Nin  = 6;   % number of the elements in the inner ring
Nout = 12;  % number of the elements in the outer ring

Ntot = 1 + Nin + Nout;
S1 = pi/Ntot;
r1 = sqrt(S1/pi);
r2 = sqrt(1-Nout*S1/pi);

% separation distance between the elements
% normalized ot the cell radius
dr = 0.001/R;   

for i = 1 : Nout
    r_max_out(i) = 1-dr;
    r_min_out(i) = r2+dr/2;
    phi_min_out(i) = 2*pi*(i-1)/Nout;
    phi_max_out(i) = 2*pi*i/Nout;
end

dphi = dr/r1;
for i = 1 : Nin
    r_max_in(i) = r2-dr/2;
    r_min_in(i) = r1+dr/2;
    phi_min_in(i) = 2*pi*(i-1)/Nin;
    phi_max_in(i) = 2*pi*i/Nin;
end

r_max   = [ r_max_out r_max_in r1-dr/2 ];
r_min   = [ r_min_out r_min_in 0 ];
phi_max = [ phi_max_out phi_max_in 2*pi ];
phi_min = [ phi_min_out phi_min_in 0 ];

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

    for ixi = 1 : length(xp)
        for iyi = 1 : length(yp)
            xi   = xp(ixi);
            yi   = yp(iyi);
            ri   = sqrt( xi^2 + yi^2 );
            phii = atan2(yi, xi);
            if (phii < 0) phii = 2*pi+phii; end;
            
            dphi = dr/ri;
           
            c1 = phii >  phi_min(ind) + dphi/2;
            c2 = phii <= phi_max(ind) - dphi/2;
            c3 = ri >  r_min(ind);
            c4 = ri <= r_max(ind);

            if (ind ~= Ntot)
                isin = ( c1 && c2 && c3 && c4 );
            else
                isin = InCircle(xi, yi, 0, 0, 2*(r1-dr/2));
            end

            
            if ( isin )
                Theta(iyi, ixi, ind) = 1;
            end
        end
    end

    ThetaT = ThetaT + (1+2*(ind-1)/(Ntot-1))*Theta(:,:,ind);

    if ( plotgen )
        % [c, h] = contourf(xp,yp, FBase(:,:,ind), 100); 
        [c, h] = contourf(xp,yp, ThetaT, 100); 
        set(h,'LineColor','none'); 
        xlabel("x/R"); ylabel("y/R"); 
        title("Cell layout");
        daspect([1 1 1]);
        drawnow;
        fprintf("%d / %d\n", ind, Ntot);
    end
end