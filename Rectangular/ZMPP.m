function Z = ZMPP(f, pars)
    % dh:  diameter of the holes in MPP
    % tp:  thickness of the MPP
    % phi: MPP perforation ratio

    dh   = pars.dh;
    tp   = pars.tp;
    phi  = pars.phi;
    c0   = pars.c0;
    rho0 = pars.rho0;
    mu   = pars.mu;


    w   = 2*pi*f;
    k  = sqrt(w*rho0/mu)*dh/2; 
       
    
    arg  = k*sqrt(-1i);
    
    ZMPP = ( 1i*w*rho0*tp/(1-(2/arg)*(besselj(1,arg)/besselj(0,arg))) ) / phi;
    ZRAD = 8i*w*rho0*dh/(3*pi*phi);
    ZRES = sqrt(32*w*rho0*mu)/phi;
    Z = ZMPP + ZRAD + ZRES;


end