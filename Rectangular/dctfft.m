function Xc = dctfft(x)
    N = length(x);

    [n1 n2] = size(x);
    transp = false;
    if (n1 > n2)
        transp = true;
    end

    if (transp)
        x = x';
    end

    x_ext = [x, fliplr(x)];
    
    X = fft(x_ext);
    
    k = (0:N-1);
    W = exp(-1i*pi*k/(2*N));
    
    Xc = real( X(1:N) .* W )/sqrt(2*N);
    Xc(1) = Xc(1)/sqrt(2);

    if (transp)
        Xc = Xc';
    end
end
