function W = calcW(n)
    phi = n(1);
    theta = n(2);
    %psi = n(3);
    
    W11 = 1;
    W12 = sin(phi)*tan(theta);
    W13 = cos(phi)*tan(theta);
    
    W21 = 0;
    W22 = cos(phi);
    W23 = -sin(phi);
    
    W31 = 0;
    W32 = sin(phi)*sec(theta);
    W33 = cos(phi)*sec(theta);
    
    W = [W11 W12 W13; W21 W22 W23; W31 W32 W33];
end