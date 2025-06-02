function z = Zin(f, L, pars)
  eps = 1e-8;
  kor = 1 - 1i*eps;  
  
  Zmpp = ZMPP(f, pars);
  zcav = -pars.rho0*pars.c0*1i*cot((2*pi*f/pars.c0)*L/kor);
  z = zcav + Zmpp;
end