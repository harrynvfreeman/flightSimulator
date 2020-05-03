function R = calcRotation(n)
        phi = n(1);
        theta = n(2);
        psi = n(3);
        
        R11 = cos(theta)*cos(psi);
        R12 = sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi);
        R13 = cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi);
        
        R21 = cos(theta)*sin(psi);
        R22 = sin(phi)*sin(theta)*sin(psi) + cos(phi)*cos(psi);
        R23 = cos(phi)*sin(theta)*sin(psi) - sin(phi)*cos(psi);
        
        R31 = -sin(theta);
        R32 = sin(phi)*cos(theta);
        R33 = cos(phi)*cos(theta);
        
        R = [R11 R12 R13; R21 R22 R23; R31 R32 R33];
end