% The RocketEngine class object stores data about a physical rocket engine,
% like its geometry, performance metrics, propellant information, etc.
% -------------------------------------------------------------------------
% Dependencies
%   #) <Dependency>
% -------------------------------------------------------------------------
% Assumptions
%   #) <Assumption>
%   #) All units are in SI at this time.
% -------------------------------------------------------------------------
% Nomenclature
%   <Symbol> = <Meaning> (<Units>)
% -------------------------------------------------------------------------
% MATLAB Version <Oldest Version>, also compatible with:
%   - <Later Version>
% -------------------------------------------------------------------------
% Developed by Alex Vance (AlexVance00 on Github)
classdef RocketEngine

    %% Properties
    % Physical constants
    properties (SetAccess = private)
        g0 = 9.81; % Gravitational acceleration on Earth at sea level
        R_universal = 8.314; % Universal gas constant
        p_sea = 101325; % Total air pressure of still air at sea level
        T_sea = 288.15; % Total temperature of still air at sea level
        mlr_wgt_air = .02896968; % Molar weight of air

    end

    properties
        % Environment
        alt = 342; % Altitude above sea level
        T_amb = 273.15 + 20; % Static ambient temperature
        p_amb = 101325; % Static ambient pressure

        % Information about the material the engine is made of
        material_name = ""; % Material name. For valid options, see method "printValidMaterialNames"
        rho_material = 
        cp_material = 
        T_melt_material = 
        E_material = 
        CTE_material = 
        epsilon_material = 
        k_material = 

        % Information about the engine propellants
        ox_name = "N2O"; % Oxidizer name. For valid options, see method "printValidPropellantNames"
        fuel_name = "ETHANOL"; % Fuel name. For valid options, see method "printValidPropellantNames"

    end

    methods (Access = public)

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
        %   1) <Assumption 1>
        % -----------------------------------------------------------------
        % Sources
        %   1) <Source 1>
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

        function printValidMaterialNames(args)
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
        %   1) <Assumption 1>
        % -----------------------------------------------------------------
        % Sources
        %   1) <Source 1>
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
        %   1) <Assumption 1>
        % -----------------------------------------------------------------
        % Sources
        %   1) <Source 1>
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

    methods (Access = private)

    end

end