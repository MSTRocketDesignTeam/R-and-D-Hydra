% Calculates darcy friction factor (f) at different axial slices along
%   chamber
% ----------
% D = hydraulic diameter of channel (units should match those of L)
% L = channel length (units should match those of D)
% delta_p = pressure change from inlet to outlet (Pa)
% rho = channel flow density (kg/m^3)
% u_bar = channel flow average speed (m/sec)
function f = mfilename(D, L, delta_p, rho, u_bar)
    f = D ./ L .* delta_p ./ (rho .* u_bar.^2 ./ 2);
end