function isin = InTriangle(x, y, x0, y0, a, reverse)
    isin = false;

    al  = pi/3;
    tal = tan(pi/3);
    h   = (a/2)*tal;
    xb  = x-x0+a/2;
        
    if(~reverse)
        yb  = y-y0+h/2;
        c1  = ( xb > 0 ) && ( xb <= a/2 );
        c2  = ( yb < tal*xb ) && ( yb > 0 );
        c12 = c1 && c2;
        c3  = ( xb > a/2 ) && ( xb <= a );
        c4  = ( yb < -tal*(xb-a) ) && ( yb > 0 );
        c34 = c3 && c4;
    else
        yb  = y-y0-h/2;
        c1  = ( xb > 0 ) && ( xb <= a/2 );
        c2  = ( yb > -tal*xb ) && ( yb < 0 );
        c12 = c1 && c2;
        c3  = ( xb > a/2 ) && ( xb <= a );
        c4  = ( yb > tal*(xb-a) ) && ( yb < 0 );
        c34 = c3 && c4;
    
    end


    if ( c12 || c34 )
        isin = true;
    end
end