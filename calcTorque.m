function torque = calcTorque(b, kw, L, w2)
    tPhi = L*kw*sqrt(3)/2 * (w2(5) + w2(6) - w2(2) - w2(3));
    tTheta = L*kw*(w2(4) + w2(5)/2 + w2(3)/2 - w2(1) - w2(6)/2 - w2(2)/2);
    tPsi = b*(w2(1) - w2(2) + w2(3) - w2(4) + w2(5) - w2(6));
    
    torque = [tPhi; tTheta; tPsi];
end