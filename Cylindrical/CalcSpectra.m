
if (load_spectra)
    % fprintf("Loading spectra\n");
    load THETA.mat;
    [tNn tNm Ntot] = size(THETA);
    if ( (tNn-1 ~= Nn) || (tNm-1 ~= Nm) )
        fprintf("\nWARNING - Nm, Nn not equal to the size of THETA!\n");
    end
    load JDroot.mat;    % roots of the equation J'm(alpga) = 0
else
    fprintf("Generating the modal functions Psi_m,n\n");
    GenPsi;

    fprintf("Generating characteristic functions Theta_i\n");

    if ( cell_layout == "annular_sectors" )
        GenLayoutAnnularSectors;    % supercell with annular-sector elements
    end
    if ( cell_layout == "squares" )
        GenLayoutSquares;           % supercell with square elements
    end


    fprintf("Generating spectra of characteristic functions THETA_i\n");
    clear Psiic;
    for ind=1:Ntot
        Thetai = Theta(:, :, ind);
        for m=0:Nm
            for n=0:Nn
                Psiic(:,:) = Psi(m+1,n+1,:,:);
                Psiic = conj(Psiic);
                Mtmp  = Thetai.*Psiic;
                THETA( m+1, n+1, ind) = Average(Mtmp);
            end
        end
        fprintf("%d / %d\n", ind, Ntot);
    end
    save THETA.mat THETA;
end

JDroot = JDroot(1:Nm+1 , 1:Nn+1);
