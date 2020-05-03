dt = 0.01;
start_time = 0;
end_time = 100;
time = start_time:dt:end_time;
N = numel(time);

g = 9.8;
m = 0.5;
Ixx = 5*10^-3;
Iyy = 5*10^-3;
Izz = 9*10^-3;
Im = 3.5*10^-5;
kw = 3 * 10^-6;
b = 1.2*10^-7;
L = 0.25;
Ax = 0.25;
Ay = 0.25;
Az = 0.25;

I = [Ixx 0 0; 0 Iyy 0; 0 0 Izz];
IInv = [1/Ixx 0 0; 0 1/Iyy 0;  0 0 1/Izz];
A = [Ax 0 0; 0 Ay 0; 0 0 Az];

Kxp = .1;
Kyp = .1;
Kzp = 1;

Kxd = 0;
Kyd = 0;
Kzd = 1;

Kphip = 1;
Kthetap = 1;
Kpsip = 1;

Kphid = 1;
Kthetad= 1;
Kpsid = 1;

KControl = [Kxp Kyp Kzp; Kxd Kyd Kzd; Kphip Kthetap Kpsip; Kphid Kthetad Kpsid];

%inertial position
s = zeros(3, N + 1);
s(:, 1) = [0; 0; 0];
%inertial velocity
v = [0; 0; 0];
%inertial acceleration
a = [0; 0; 0];
%a = [0; 0; 0];
%Euler angles
n = real(zeros(3, N + 1));
n(:, 1) = [0; 0; 0];
%angular velocity inertial frame
nDot = real([0; 0; 0]);

%angular velocity in body frame
%omega = [0; 0; 0];
%angular acceleration in body frame
%omegaDot = [0; 0; 0];

%simulate
tcount = 0;
for t = time
    tcount=tcount+1;
    
    if t < 5
        xC = 0;
        yC = 0;
        zC = 0;
        sC = [xC; yC; zC];
        
        xDotC = 0;
        yDotC = 0;
        zDotC = 0;
        vC = [xDotC; yDotC; zDotC];
        
        psiC = 0;
        
        nDotC = [0, 0, 0];
        
    elseif t < 80
        %xC = 2/3*(t-5);
        xC = 1*cos(t);
        yC = 1*sin(t);
        %yC = 2/3*(t-5);
        zC = 0.2*t;
        %zC = 2/3*(t-5);
        sC = [xC; yC; zC];
        
        xDotC = 0;
        yDotC = 0;
        %yDotC = 2/3;
        zDotC = 0; 
        %zDotC = 2/3;
        vC = [xDotC; yDotC; zDotC];
        
        psiC = 0;
        
        nDotC = [0, 0, 0];
    
    else
        xC = cos(70);
        yC = cos(70);
        %yC = 10;
        zC = 0.2*70;
        %zC = 10;
        sC = [xC; yC; zC];
        
        xDotC = 0;
        yDotC = 0;
        zDotC = 0;
        vC = [xDotC; yDotC; zDotC];
        
        psiC = 0;
        
        nDotC = [0, 0, 0];
        
    end

    w = getControl(g, m, kw, b, L, KControl, s(:,tcount), v, real(n(:, tcount)), real(nDot), sC, vC, ...
        psiC, nDotC);
    
    %calculate w^2 to be used
    w2 = w.^2;

    %step 2 - calculate Thrust
    T = calcThrust(kw, w2);

    %step 3 - calculate drage force
    Fd = calcDragForce(A, v);

    %step 4 - calculate external Torque
    torque = calcTorque(b, kw, L, w2);

    %step 5 - calculate R and RInv
    R = calcRotation(n(:, tcount));
    RInv = calcRotationInverse(n(:, tcount));

    %step 6 - calculate W, WInv
    W = calcW(n(:, tcount));
    WInv = calcWInverse(n(:, tcount));

    %step 7 - calculate acceleration
    a = calcAcceleration(g, m, R, T, Fd);

    %step 8 - calculate angular velocity in body frame
    omega = WInv*nDot;

    %step 9 - calculate gyro Torque
    gyroTorque = calcGyroTorque(Im, omega, w);

    %step 10 - calculate angularAcceleration in body frame
    omegaDot = calcAngularAcceleration(I, IInv, torque, gyroTorque, omega);
        
    %step 11 - update values
    omega = omega + omegaDot*dt;
    nDot = W*omega;
    n(:, tcount + 1) = wrapToPi(n(:, tcount) + nDot*dt);
    v = v + a*dt;
    s(:, tcount+1) = s(:,tcount) + v*dt;
    %yCVec(tcount) = yC;
end

plot4(s);
%figure
%hold on
%plot(time, s(1,2:end), 'r');
%plot(time, s(2,2:end), 'g');
%plot(time, s(3,2:end), 'b');

%plot(time, n(1,2:end), 'r');
%plot(time, n(2,2:end), 'g');
%plot(time, n(3,2:end), 'b');
