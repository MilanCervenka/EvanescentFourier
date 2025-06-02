% discretization - the number of the samples along the x and y axis
%  of the cell
Nres = 512;

% the norm of the modal functions can be calculated
% either numerically or analytically
numerical_norm = false;

% loading roots of derivatives of Bessel functions
load JDroot.mat;

xp = linspace(-1,1,Nres);
x = repmat(xp, Nres, 1);
y = x';
r = sqrt(x.^2 + y.^2);

mask = r <= 1;

clear Psi;
for m=0:Nm
    fprintf(" - %d / %d\n", m, Nm);
    for n=0:Nn
        Mtmp1 = besselj(m, r*JDroot(m+1,n+1));
        Mtmp2 = exp(1i*m*atan2(y, x));
        Mtmp3 = Mtmp1.*Mtmp2.*mask;
        
        if ( numerical_norm )
            norm = sqrt( Average( Mtmp3 .* conj(Mtmp3) ) );
        else
            if ( (m==0) && (n==0) )
                norm = 1;
            else     
                alfa  = JDroot(m+1, n+1);
                norm = sqrt( besselj(m, alfa)^2 * (alfa^2 - m^2) / alfa^2 );
            end
        end

        Psi(m+1,n+1,:,:) = Mtmp3 / norm;
    end
end




