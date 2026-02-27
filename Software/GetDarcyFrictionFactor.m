% Calculates darcy friction factor (f) at different axial slices along
%   chamber
% ----------
function f = mfilename(D, L, delta_p, rho, u_bar)
    f = D ./ L .* delta_p ./ (rho .* u_bar.^2 ./ 2);
end