function WInv = calcWInverse(n)
    phi = n(1);
    theta = n(2);
    %psi = n(3);
    
    WInv11 = 1;
    WInv12 = sin(phi)*tan(theta);
    WInv13 = cos(phi)*tan(theta);
    
    WInv21 = 0;
    WInv22 = cos(phi);
    WInv23 = -sin(phi);
    
    WInv31 = 0;
    WInv32 = sin(phi)*sec(theta);
    WInv33 = cos(phi)*sec(theta);
    
    WInv = [WInv11 WInv12 WInv13; WInv21 WInv22 WInv23; WInv31 WInv32 WInv33];
end