% Calculates h for different sections in the rocket (W/m^2-K)
% ----------
% Nu_D = Nusselt number using tube diameter as the characteristic length
% D = tube hydraulic diameter (m)
% k = thermal conductivity (W/m-K)
% ----------
% Vectorized
function h = mfilename(Nu_D, D, k)
    h = Nu_D .* k ./ D;
end