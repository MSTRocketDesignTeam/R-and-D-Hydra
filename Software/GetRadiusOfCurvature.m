% Calculates radius of curvature (R) (m)
% ----------
% Meant to be used with regenEngineTradesCalculator.m
% Assumes top of chamber is at z = 0, HOWEVER, 
%   regenEngineTradesCalculator.m keeps the chamber's z coordinates
%   starting at z = 0 at the bottom of the nozzle and z increases towards
%   the top of the chamber. Will need to correct for this before inputting
%   to this function
% Make sure dx, dy orders of magnitude are >= 2 lower than chamber radius
% ----------
% dx = finite delta x (units should match those of dy)
% dy = finite delta y (units should match those of dx)
function R = mfilename(args)
    
%% Argument handling
    % Allows arguments to be optional and instantiated in the function call
    %   like: functionname(<varname> = <value>, ...)
    arguments
        args.dx = [];
        args.dy = [];
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
    R = (1 + (dy ./ dx).^2).^(3 ./ 2) ./ abs(dy.^2 ./ dx.^2);
end