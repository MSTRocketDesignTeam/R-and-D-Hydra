% Superclass for propellant objects. Pairs with a propellant_data.txt
% config. file for propellant info. Some propellants have more complex
% correlations documented for material properties at varying state
% conditions, so subclasses should be defined for each propellant in the
% config., and if properties are only defined as constant, this superclass
% handles the inheritance of those constant properties from that config.
% file. The subclasses only differ in how they implement those correlations
% for each propellant.
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
% Nomenclature
%   <Symbol> = <Meaning> (<Units>)
% -------------------------------------------------------------------------
% MATLAB Version <Oldest Version>, also compatible with:
%   - <Later Version>
% -------------------------------------------------------------------------
% Developed by Alex Vance (AlexVance00 on Github)
classdef (Abstract) Propellant

    properties (Constant)
        NA = 6.02214076E23; % Avogadro's Number
        R_universal = 8.314; % Universal gas constant
        configFile = "propellant_data.txt";
    end

    properties (SetAccess = protected)
        name (1, 1) string
        data struct
    end

    methods (Access = public)

        function obj = Propellant(name)
            obj.name = name;
            obj.data = GetConfigData();

            return obj
        end

        function result = FunctionTemplate(args)
        % <Function Purpose>
        %                                             <Output> in (<Units>)
        % -----------------------------------------------------------------
        % Arguments
        %   <Symbol> = <Explanation> (<Units>)
        % -----------------------------------------------------------------
        % Dependencies
        %   #) <Dependency Filepath>
        % -----------------------------------------------------------------
        % Assumptions
        %   #) <Assumption>
        % -----------------------------------------------------------------
        % Sources
        %   #) <Source>
        % -----------------------------------------------------------------
        % MATLAB Version <Oldest Version>, also compatible with:
        %   - <Later Version>
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

end