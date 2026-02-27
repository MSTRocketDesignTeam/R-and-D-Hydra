% Calculates Nu_D at different axial slices along the chamber
% ----------
% From: Heat Convection 2nd Ed. by Latif M. Jiji
%   Page 404, Eq. (10.17) (Gnielinski correlation)
% ASSUMES turbulent flow
% Check for:
%   1) entrance region, OR
%   2) fully-developed region
% Valid for:
%   Turbulent flow Re_D < 5E6
%   0 < D/L < 1
%   Properties at T_m = (T_1 + T_2)/2
% ----------
% Nu_D = Nusselt number using channel diameter as characteristic length
% f = friction factor
% Re_D = Reynold's number using channel diameter as characteristic length
% Pr = Prandtl number
% D = channel hydraulic diameter (m)
% L = channel length (m)
% x = position in tube relative to datum (m)
function Nu_D = mfilename(args)
    
    % Allows arguments to be optional and instantiated in the function call
    %   like: functionname(<varname> = <value>, ...)
    arguments
        args.f = [];
        args.Re_D = [];
        args.Pr = [];
        args.D = [];
        args.L = [];
        args.x = [];
    end
    arg_name_list = fieldnames(args);

    % Makes variables out of args' fieldnames
    for i_fieldname = 1:length(arg_name_list)
        arg_name = arg_name_list{i_fieldname};
        eval(append(arg_name, " = args.(arg_name);"));
    end

    % Avoid divide by zero error if L = 0
    % Scale tol_low to D
    tol_low = .01 .* 2.5 .* D;
    if L == 0
        L = tol_low;
    end

    % Check if developing
    % Get entrance lengths
    x_fd_t_over_D = GetThermalEntryLength(Re_D, Pr);
    x_fd_h_over_D = GetHydrodynamicEntryLength(Re_D);

    x_over_D = x ./ D;
    
    % For vectorization, uses logical multi-dimensional array-indexing
    % Creates masks
    x_over_D_developing_mask = x_over_D < max(x_fd_t_over_D, ...
        x_fd_h_over_D);
    x_over_D_fully_developed_mask = ~ x_over_D_developing_mask;

    % Assigns values based on masks
    D_over_L = zeros(size(x_over_D_fully_developed_mask));
    D_over_L(x_over_D_developing_mask) = D ./ L;
    D_over_L(x_over_D_fully_developed_mask) = 0;
    
    Nu_D = ((f ./ 8) .* (Re_D - 1000) .* Pr) ./ (1 + 12.7 .* ...
        sqrt((f ./ 8)) .* (Pr.^(2 ./ 3) - 1)) .* (1 + D_over_L.^(2 ./ 3));
end