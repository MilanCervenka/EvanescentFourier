function H = Hper(ii, jj, f, p, THETA)
    Nm  = p.Nm;
    Nn  = p.Nn;
    Nm0 = p.Nm0;
    Nn0 = p.Nn0;

    kzmn = zeros(Nm+1, Nn+1);
    for m=0:Nm
        for n=0:Nn
            kzmn(m+1,n+1) = Kzper(f,m,n,p);
        end
    end

    H = 0;
    % if newalg is set true, the calculation is
    % more effective
    newalg = true;
    if (~newalg)
        for m = -Nm:Nm
            for n = -Nn:Nn
                Thetai = THETA(Nn0+n, Nm0+m, ii);
                Thetaj = THETA(Nn0+n, Nm0+m, jj);
                % kz = Kzper(f,m,n,p);
                kz = kzmn(abs(m)+1,abs(n)+1);
                H = H + conj(Thetai)*Thetaj/kz;
            end
        end
    else
        m = 0;
        for n = -Nn:Nn
            Thetai = THETA(Nn0+n, Nm0+m, ii);
            Thetaj = THETA(Nn0+n, Nm0+m, jj);
            % kz = Kzper(f,m,n,p);
            kz = kzmn(abs(m)+1,abs(n)+1);
            H = H + conj(Thetai)*Thetaj/kz;
        end
        for m = 1:Nm
            for n = -Nn:Nn
                Thetai = THETA(Nn0+n, Nm0+m, ii);
                Thetaj = THETA(Nn0+n, Nm0+m, jj);
                % kz = Kzper(f,m,n,p);
                kz = kzmn(abs(m)+1,abs(n)+1);
                H = H + 2*real(conj(Thetai)*Thetaj)/kz;
            end
        end

    end

    H = (2*pi*f/p.c0)*H;
end