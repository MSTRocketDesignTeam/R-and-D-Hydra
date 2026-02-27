% Calculates thermal resistance for different sections in the rocket
% ----------
% Accounts for unit-width increase in angular cross section with radius,
%   normalized to a reference radius
% ----------
%   heat_transfer_type = "conduction", "forced convection", or "free
%       convection"
%   k = conductive heat transfer coefficient
%   h = convective heat transfer coefficient
%   r_0 = reference radius for which basis q_s_flux is defined
%   r_1 =
%       For conduction: starting radius
%       For convection: boundary radius
%   r_2 = ending radius
function TR = mfilename(args)

    % Allows arguments to be optional and instantiated in the function call
    %   like: functionname(<varname> = <value>, ...)
    arguments
        args.heat_transfer_type = [];
        args.k = [];
        args.h = [];
        args.r_0 = [];
        args.r_1 = [];
        args.r_2 = [];
    end
    arg_name_list = fieldnames(args);

    % Makes variables out of args' fieldnames
    for i_fieldname = 1:length(arg_name_list)
        arg_name = arg_name_list{i_fieldname};
        eval(append(arg_name, " = args.(arg_name);"));
    end

    % Check heat transfer type
    if strcmp(heat_transfer_type, "conduction")

        % Check inputs
        if ~exist("k", "var")
            error("Missing input for 'k' parameter");
        end
        if ~exist("r_2", "var")
            error("Missing input for 'r_2' parameter");
        end

        TR = 1 ./ k .* r_0 .* log(r_2 ./ r_1);
    elseif strcmp(heat_transfer_type, "forced convection")

        % Check inputs
        if ~exist("h", "var")
            error("Missing input for 'h' parameter");
        end

        TR = 1 ./ h .* r_0 ./ r_1;
    elseif strcmp(heat_transfer_type, "free convection")

        error("'%s' value for 'heat_transfer_type' parameter not " + ...
            "yet implemented", heat_transfer_type);
    else % Invalid heat_transfer_type
        error("Invalid input for 'heat_transfer_type' parameter")
    end
end