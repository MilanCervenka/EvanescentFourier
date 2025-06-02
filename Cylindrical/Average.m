function Av = Average(M)

    [m, n] = size(M);
    if (m ~= n)
        fprintf("\nNon-rectabgular matrix!\m");
    end

    xp = linspace(-1,1,m);
    Av = trapz(xp,trapz(xp,M,2));
    % it is assumed that the average is calculated on a
    % disk with radius 1
    % matrix elements should be zero outside this disk
    Av = Av/pi;
end