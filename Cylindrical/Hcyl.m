function H = Hcyl(ii, jj, f, p, THETA, JDroot)
    Nm  = p.Nm;
    Nn  = p.Nn;
    
    k  = 2*pi*f/p.c0;
    kzmn = zeros(Nm+1, Nn+1);
    for m=0:Nm
        for n=0:Nn
            kzmn(1+m,1+n) = conj( sqrt( k^2 - (JDroot(m+1,n+1)/p.R)^2 ) );
        end
    end

    H = 0;

    for n = 0:Nn
        m=0;
        Thetai = THETA(1+m, 1+n, ii);
        Thetaj = THETA(1+m, 1+n, jj);
        kz = kzmn(1+m,1+n);
        H = H + conj(Thetai)*Thetaj/kz;

        for m = 1:Nm
            Thetai = THETA(1+m, 1+n, ii);
            Thetaj = THETA(1+m, 1+n, jj);
            kz = kzmn(m+1,n+1);
            H = H + 2*real(conj(Thetai)*Thetaj)/kz;
        end
    end

    H = (2*pi*f/p.c0)*H;
end