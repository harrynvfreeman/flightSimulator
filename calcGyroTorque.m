function gyroTorque = calcGyroTorque(Im, omega, w)
    gyroTorque = -Im * cross(omega, [0; 0; 1]) * (w(2) + w(4) + w(6) - w(1) - w(3) - w(5));
end