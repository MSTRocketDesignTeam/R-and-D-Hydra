% Internal flow hydrodynamic entry length (nondimensionalized)
% From: Introduction to Heat Transfer 3rd Ed. by Incropera and DeWitt
%   Page 389, Eq. (8.3)
% in x_fd_h_over_D:
%   x = axial distance from datum
%   fd = fully developed
%   h = hydrodynamic
%   D = diameter of tube (for nondimensionalization)
function x_fd_h_over_D = mfilename(Re_D)
    
    % Determine if flow is laminar or turbulent
    % Not vectorized
    Re_D_transition = 2300;
    if Re_D <= Re_D_transition

        x_fd_h_over_D = .05 .* Re_D;
    else
        % From Fundamentals of Thermal Fluid Sciences by Cengel and Turner
        %   Page 760, Eq. (17-42)
        %   in L_h_t:
        %       L = length
        %       h_t = hydrodynamic_turbulent
        %   I slightly rearranged it to exclude D so that it would be a
        %       nondimensionalized value
        L_h_t = 4.4 .* Re_D.^(1 ./ 6);
        x_fd_h_over_D = L_h_t;
    end
end