% Stores material data read in from material config file after searching
% for specific material config
% -------------------------------------------------------------------------
% Dependencies
%   #) <Dependency>
% -------------------------------------------------------------------------
% Assumptions
%   #) <Assumption>
% -------------------------------------------------------------------------
% Comments
%   #) <Comment>
% -------------------------------------------------------------------------
% Document Version <Version>, former versions:
%   - Version>
% -------------------------------------------------------------------------
% MATLAB Version <Oldest Version>, also compatible with:
%   - <Later Version>
% -------------------------------------------------------------------------
% Developed by Alex Vance (AlexVance00 on Github)
classdef Material

    properties

    end

    methods (Access = public)

        function result = FunctionTemplate(args)
        % <Function Purpose>
        %                                             <Output> in (<Units>)
        % -----------------------------------------------------------------
        % Arguments
        %   <Symbol> = <Explanation> (<Units>)
        % -----------------------------------------------------------------
        
            % Allows arguments to be optional and assigned in the function
            %   call as in: FunctionTemplate(<arg_name> = <arg_val>, ...)
        
            % List all argument names
            arguments
                args.arg_1 = [];
            end
            arg_name_list = fieldnames(args);
        
            % List those argument names which are optional in 1D string
            %   array
            optional_arg_names = [];
        
            % Makes variables out of args' fieldnames
            for i_fieldname = 1:length(arg_name_list)
                arg_name = arg_name_list{i_fieldname};
                arg_val = args.(arg_name);
        
                % Input Checking
                % Checks if this argument was assigned
                if ~isempty(arg_val)
        
                    % Initializes assigned arguments
                    eval(append(arg_name, " = arg_val;"));
                % If argument was unassigned, checks if it was optional
                elseif ~ismember(arg_name, optional_arg_names)
                    
                    % If unassigned argument was non-optional, throws error
                    error("No input for non-optional '%s' argument", ...
                        arg_name);
                end
            end
        
            % Unit Conversions
        
            % Intermediate Calculations
        
            % Final Calculations
        
            % Display Results and/or Plotting
        
            return;
        end

    end

    methods (Access = private)

    end

end