% Calculates gas-side convective heat transfer coefficient at the hot-wall
%   (h_g) (J/m^2-sec-K)
% ----------
% Meant to be used with regenEngineTradesCalculator.m
% From Design of Liquid Propellant Rocket Engines 2nd. Ed. by Huzel and
%   Huang p. 100 Eq. (4-13) (Bartz Correlation)
% Normally inputs and outputs are in English units, so just input SI units,
%   convert internally, do calculations, then convert back to SI for the
%   output
% Requires English units, so input in SI and convert inside the function
% ----------
% D_t = throat diameter (m)
% mu: viscosity, (kg/m-sec)
% C_p = gas specifict heat capacity at constant pressure (J/kg-K)
% Pr = Prandtl number
% p_c = chamber pressure at this nozzle station (Pa)
% g = gravitational acceleration (m/sec^2)
% c_star = characteristic velocity (m/sec)
% R = curvature of circular portion of the nozzle (m)
% A_t = throat area (units should match those of A)
% A = area at this nozzle stations (units should match those of A_t)
% sigma = Correction factor for property variations across boundary layer
function h_g = mfilename(args)
    
    %% Argument handling
    % Allows arguments to be optional and instantiated in the function call
    %   like: functionname(<varname> = <value>, ...)
    arguments
        args.D_t = [];
        args.mu = [];
        args.c_p = [];
        args.Pr = [];
        args.p_c = [];
        args.g = [];
        args.c_star = [];
        args.R = [];
        args.A_t = [];
        args.A = [];
        args.sigma = [];
    end
    
    arg_name_list = fieldnames(args);

    % Makes variables out of args' fieldnames
    for i_fieldname = 1:length(arg_name_list)
        arg_name = arg_name_list{i_fieldname};

        % Input checking
        if ~isempty(args.(arg_name))
            eval(append(arg_name, " = args.(arg_name);"));
        else

            % If any are empty, throw error
            error("No input for '%s' parameter", arg_name)
        end
    end

    %% Unit Conversions
    % m to in
    D_t = D_t .* 39.3701;
    R = R .* 39.3701;
    
    % kg/m-sec to lbm/in-sec
    mu = mu .* 0.0254 ./ 0.45359237;

    % Pa to psi
    p_c = p_c ./ 6894.76;

    % m/sec to ft/sec
    c_star = c_star .* 3.28084;

    % m/sec^2 to ft/sec^2
    g = g .* 3.28084;

    % J/kg-K to Btu/lbm-deg F
    c_p = c_p .* 0.000947817 ./ 2.20462 ./ 1.8;

    %% Calculations
    % Get Bartz Correlation (yields h_g in Btu/in^2-sec-deg F)
    h_g = ((.026 ./ D_t.^.2) .* (mu.^2 .* c_p ./ Pr.^.6) .* (p_c .* g ./ c_star).^.8 .* (D_t ./ R).^.1) .* (A_t ./ A).^.9 .* sigma;

    % Btu/in^2-sec-deg F to J/m^2-sec-K
    h_g = h_g .* 1055.06 ./ 0.0254.^2 ./ (5 ./ 9);
end