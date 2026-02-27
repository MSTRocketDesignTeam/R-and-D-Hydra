% Calculates friction factor using the Haaland Equation
% ----------
% epsilon = surface roughness (m)
% D = hydraulic diameter of channel (m)
% Re = channel flow Reynold's Number
function f = mfilename(args)
    
    %% Argument handling
    % Allows arguments to be optional and instantiated in the function call
    %   like: functionname(<varname> = <value>, ...)
    arguments
        args.epsilon = [];
        args.D = [];
        args.Re = [];
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
    f = 1 ./ (-1.8 .* log10((epsilon ./ D ./ 3.7).^1.11 + 6.9 ./ Re)).^2;
end