function isin = InStar(x, y, x0, y0, a, b)
    xc = x-x0;
    yc = y-y0;
    tal = a/b;

    isin = false;

    c1  = ( xc > -b/2 ) && ( xc <= 0 );
    c2  = abs(yc) < tal*(xc+b/2);
    c12 = c1 && c2;
    c3  = ( xc > 0 ) && ( xc <= b/2 );
    c4  = abs(yc) < -tal*(xc-b/2);
    c34 = c3 && c4;
    c5  = ( xc > -a/2 ) && ( xc <= 0 );
    c6  = abs(yc) < (1/tal)*(xc+a/2);
    c56 = c5 && c6;
    c7  = ( xc > 0 ) && ( xc <= a/2 );
    c8  = abs(yc) < -(1/tal)*(xc-a/2);
    c78 = c7 && c8;
    if ( c12 || c34 || c56 || c78 )
        isin = true;
    end

end