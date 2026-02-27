% Calculates correction factor "sigma" for the GetBartzh_g function
% ----------
% Meant to be used with regenEngineTradesCalculator.m
% From Design of Liquid Propellant Rocket Engines 2nd. Ed. by Huzel and
%   Huang p. 101 Eq. (4-14) (Bartz Correlation)
% ----------
% T_wg = gas-side hot wall temperature (units should match those of T_c)
% T_c = chamber stagnation temperature (units should match those of T_wg)
% gamma = specific heat ratio
% M = flow mach number
function sigma = mfilename(args)
    
    %% Argument handling
    % Allows arguments to be optional and instantiated in the function call
    %   like: functionname(<varname> = <value>, ...)
    arguments
        args.T_wg = [];
        args.T_c = [];
        args.gamma = [];
        args.M = [];
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

    %% Calculations
    % Get sigma
    sigma = 1 ./ ...
        (((1 ./ 2) .* (T_wg ./ T_c) .* ...
            (1 + (gamma - 1) ./ 2 .* M.^2) + 1 ./ 2).^.68 .* ...
        (1 + (gamma - 1) ./ 2 .* M.^2).^.12);
end