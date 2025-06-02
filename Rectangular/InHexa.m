function isin = InHexa(x, y, x0, y0, a)
    isin = false;
    
    tal = tan(pi/6);
    h  = (a/2)/tan(pi/3);
    xc = x-x0;
    yc = y-y0;

    c1   = ( xc > -a/2 ) && ( xc <= 0 );
    c2   = ( abs(yc) < h + tal*(xc+a/2) );
    cc12 = c1 && c2;
    c3   = ( xc > 0 ) && ( xc <= a/2 );
    c4   = ( abs(yc) < h + -tal*(xc-a/2) );
    c34 = c3 && c4;

    if ( cc12 || c34 )
        isin = true;
    end
end