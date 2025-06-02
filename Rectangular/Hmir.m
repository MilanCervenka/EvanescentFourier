function H = Hmir(ii, jj, f, p, THETA);
    Nm  = p.Nm;
    Nn  = p.Nn;
    Nm0 = p.Nm0;
    Nn0 = p.Nn0;

    H = 0;
    for m = 0:Nm
        for n = 0:Nn
            Thetai = THETA(n+Nn0, m+Nm0, ii);
            Thetaj = THETA(n+Nn0, m+Nm0, jj);
            kz = Kzmir(f,m,n,p);
            H = H + Thetai*Thetaj/kz;
        end
    end

    H = (2*pi*f/p.c0)*H;
end