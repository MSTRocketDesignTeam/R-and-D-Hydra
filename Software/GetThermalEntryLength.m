% Internal flow thermal entry length (nondimensionalized)
% From: Introduction to Heat Transfer 3rd Ed. by Incropera and DeWitt
%   Page 393, Eq. (8.23)
% in x_fd_t_over_D:
%   x = axial distance from datum
%   fd = fully developed
%   t = thermal
%   D = diameter of tube (for nondimensionalization)
function x_fd_t_over_D = mfilename(Re_D, Pr)

    % Determine if flow is laminar or turbulent
    % Not vectorized
    Re_D_transition = 2300;
    if Re_D <= Re_D_transition

        x_fd_t_over_D = .05 .* Re_D .* Pr;
    else
        % From Fundamentals of Thermal Fluid Sciences by Cengel and Turner
        %   Page 760, Eq. (17-42)
        %   in L_t_t:
        %       L = length
        %       t_t = thermal_turbulent
        %   I slightly rearranged it to exclude D so that it would be a
        %       nondimensionalized value
        L_t_t = 4.4 .* D .* Re_D.^(1 ./ 6);
        x_fd_t_over_D = L_t_t;
    end
end