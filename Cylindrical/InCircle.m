function isin = InCircle(x, y, x0, y0, a)
    isin = false;
    if ( (x-x0)^2 + (y-y0)^2 <= (a/2)^2 )
        isin = true;
    end
end