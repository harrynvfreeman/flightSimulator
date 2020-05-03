function RInv = calcRotationInverse(n)
        phi = n(1);
        theta = n(2);
        psi = n(3);
        
        R11 = cos(theta)*cos(psi);
        R12 = cos(theta)*sin(psi);
        R13 = -sin(theta);
       
        R21 = sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi);
        R22 = sin(phi)*sin(theta)*sin(psi) + cos(phi)*cos(psi);
        R23 = sin(phi)*cos(theta);

        R31 = cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi);
        R32 = cos(phi)*sin(theta)*sin(psi) - sin(phi)*cos(psi);
        R33 = cos(phi)*cos(theta);
        
        RInv = [R11 R12 R13; R21 R22 R23; R31 R32 R33];
end