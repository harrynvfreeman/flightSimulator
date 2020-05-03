function a = calcAcceleration(g, m, R, T, Fd)
    a = [0; 0; -g] + (1/m)*R*T + (1/m)*Fd;
end