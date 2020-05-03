function omegaDot = calcAngularAcceleration(I, IInv, torque, gyroTorque, omega)
    omegaDot = IInv * (-cross(omega, I*omega)) + torque + gyroTorque;
end