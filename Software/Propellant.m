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
%   1) propellant_data.txt
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
% MATLAB Version R2024b, also compatible with:
%   - R2025b
% -------------------------------------------------------------------------
% Developed by Alex Vance (AlexVance00 on Github)
classdef (Abstract) Propellant

    properties (Constant)
        NA = 6.02214076E23; % Avogadro's Number
        R_universal = 8.314; % Universal gas constant
        configFile = "propellant_data.txt";
    end

    properties (SetAccess = protected)
        name
        type
        cost
        mlr_wgt
        rho
        cp
        k
        mu
    end

    methods (Access = public)

        % Constructor
        function obj = Propellant()

            configFile = Propellant.configFile;

            % Get configName from class name of calling object. Subclass
            % initialization will call this constructor, converting to
            % uppercase string puts it in format matching configFile
            % configName = upper(string(class(obj)));
            configName = obj.configName;

            % Can assume what data will be in there because we know what
            % will be in the hardcoded configFile variables list
            % Get number of config names passed- configName could be an
            % array, this is vectorized
            data = GetConfigData(configFile = configFile, configName = configName);

            % If numConfigNames is not 1, flag there as being multiple and
            % preallocate array of obj types for speed's sake
            numConfigNames = numel(configName);
            flagMultipleConfigNames = false;
            if numConfigNames ~= 1
                flagMultipleConfigNames = true;
                obj(numConfigNames) = Propellant();
            end

            % Assign obj properties values from data's fields for each
            % config name passed
            for i = 1:numConfigNames
                obj(i).name = configName(i);
                obj(i).data = data(i);
            end

            return;
        end
    end
end