function isin = InEllipse(x, y, x0, y0, ax, by, reverse)
    isin = false;
    if ( reverse )
        pom = ax;
        ax = by; by = pom;
    end
    if ( ((x-x0)/(ax/2))^2 + ((y-y0)/(by/2))^2 <= 1 )
        isin = true;
    end
end