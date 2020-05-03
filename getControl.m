function w = getControl3(g, m, kw, b, L, KControl, s, v, n, nDot, sC, vC, psiC, nDotC)

Kxp = KControl(1,1);
Kyp = KControl(1,2);
Kzp = KControl(1,3);

Kxd = KControl(2,1);
Kyd = KControl(2,2);
Kzd = KControl(2,3);

Kphip = KControl(3,1);
Kthetap = KControl(3,2);
Kpsip = KControl(3,3);

Kphid = KControl(4,1);
Kthetad= KControl(4,2);
Kpsid = KControl(4,3);

xDotC = vC(1);
yDotC = vC(2);
zDotC = vC(3);

xC = sC(1);
yC = sC(2);
zC = sC(3);

phiDotC = nDotC(1);
thetaDotC = nDotC(2);
psiDotC = nDotC(3);

U1 = Kxd*(xDotC - v(1)) + Kxp*(xC - s(1));
U2 = Kyd*(yDotC - v(2)) + Kyp*(yC - s(2));
U3 = Kzd*(zDotC - v(3)) + Kzp*(zC - s(3)) + g;

thetaC = wrapToPi(atan((U1*cos(psiC) + U2*sin(psiC))/(U3)));
phiC = wrapToPi(atan((U1*sin(psiC) - U2*cos(psiC))/(U1*sin(thetaC)*cos(psiC) + U2*sin(thetaC)*sin(psiC) + U3*cos(thetaC))));

T = m*(U1*(sin(thetaC)*cos(psiC)*cos(phiC) + sin(psiC)*sin(phiC)) ...
    + U2*(sin(thetaC)*sin(psiC)*cos(phiC) + - cos(psiC)*sin(phiC)) ...
    + (U3)*cos(thetaC)*cos(phiC));

torquePhi = Kphid*(phiDotC - nDot(1)) + Kphip*(phiC - n(1));
torqueTheta = Kthetad*(thetaDotC - nDot(2)) + Kthetap*(thetaC - n(2));
torquePsi = Kpsid*(psiDotC - nDot(3)) + Kpsip*(psiC - n(3));
torque = [torquePhi; torqueTheta; torquePsi];

w = getW(kw, b, L, T, torque);
end

function w = getW(kw, b, L, Tz, torque)
    torquePhi = real(torque(1));
    torqueTheta = real(torque(2));
    torquePsi = real(torque(3));
    
    w1 = sqrt(max(0, Tz/6/kw - torqueTheta/3/kw/L + torquePsi/6/b));
    w4 = sqrt(max(0, Tz/6/kw + torqueTheta/3/kw/L - torquePsi/6/b));
    
    w2 = sqrt(max(0, Tz/6/kw - torquePhi/2/sqrt(3)/kw/L - torqueTheta/6/kw/L - torquePsi/6/b));
    w5 = sqrt(max(0, Tz/6/kw + torquePhi/2/sqrt(3)/kw/L + torqueTheta/6/kw/L + torquePsi/6/b));
    
    w3 = sqrt(max(0, Tz/6/kw - torquePhi/2/sqrt(3)/kw/L + torqueTheta/6/kw/L + torquePsi/6/b));
    w6 = sqrt(max(0, Tz/6/kw + torquePhi/2/sqrt(3)/kw/L - torqueTheta/6/kw/L - torquePsi/6/b));
    
    w = [w1; w2; w3; w4; w5; w6];
end
