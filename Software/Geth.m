% Calculates h for different sections in the rocket (W/m^2-K)
% ----------
% Vectorized
% ----------
% Nu_D = Nusselt number using tube diameter as the characteristic length
% D = channel hydraulic diameter (m)
% k = thermal conductivity (W/m-K)
function h = mfilename(args)
    
    %% Argument handling
    % Allows arguments to be optional and instantiated in the function call
    %   like: functionname(<varname> = <value>, ...)
    arguments
        args.Nu_D = [];
        args.k = [];
        args.D = [];
    end
    
    arg_name_list = fieldnames(args);
    optional_var_names = [];

    % Makes variables out of args' fieldnames
    for i_fieldname = 1:length(arg_name_list)
        arg_name = arg_name_list{i_fieldname};

        % Input checking
        if ~isempty(args.(arg_name))
            eval(append(arg_name, " = args.(arg_name);"));
        elseif ~ismember(arg_name, optional_var_names)
            
            % If any non-optional parameters are empty, throw error
            error("No input for non-optional '%s' parameter", arg_name);
        end
    end

    %% Calculations
    h = Nu_D .* k ./ D;
end