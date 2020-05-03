function dWInv = calcDWInverse(n, nDot)
    phi = n(1);
    theta = n(2);
    %psi = n(3);
    
    phiDot = nDot(1);
    thetaDot = nDot(2);
    %psiDot = nDot(3);
    
    dWInv11 = 0;
    dWInv12 = phiDot*cos(phi)*tan(theta) + thetaDot*sin(phi)*sec(theta)^2;
    dWInv13 = -phiDot*sin(phi)*tan(theta) + thetaDot*cos(phi)*sec(theta)^2;
    
    dWInv21 = 0;
    dWInv22 = -phiDot*sin(phi);
    dWInv23 = -phiDot*cos(phi);
    
    dWInv31 = 0;
    dWInv32 = phiDot*cos(phi)*sec(theta) + thetaDot*sin(phi)*sec(theta)*tan(theta);
    dWInv33 = -phiDot*sin(phi)*sec(theta) + thetaDot*cos(phi)*sec(theta)*tan(theta);
    
    dWInv = [dWInv11 dWInv12 dWInv13; dWInv21 dWInv22 dWInv23; dWInv31 dWInv32 dWInv33];
end