% Internal flow thermal entry length (nondimensionalized)
% From: Introduction to Heat Transfer 3rd Ed. by Incropera and DeWitt
%   Page 393, Eq. (8.23)
% in x_fd_t_over_D:
%   x = axial distance from datum
%   fd = fully developed
%   t = thermal
%   D = diameter of tube (for nondimensionalization)
function x_fd_t_over_D = mfilename(args)

    %% Argument handling
    % Allows arguments to be optional and instantiated in the function call
    %   like: functionname(<varname> = <value>, ...)
    arguments
        args.Re_D = [];
        args.Pr = [];
        args.D = [];
    end
    
    arg_name_list = fieldnames(args);
    optional_var_names = ["D"];

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
    % Determine if flow is laminar or turbulent
    % Not vectorized
    Re_D_transition = 2300;
    if Re_D <= Re_D_transition

        x_fd_t_over_D = .05 .* Re_D .* Pr;
    else
        if isempty(D)
            arg_name = "D";
            error("No input for non-optional '%s' parameter", arg_name);
        end
        
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