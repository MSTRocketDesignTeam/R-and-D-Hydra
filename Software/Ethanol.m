% Subclass for an ETHANOL-type PROPELLANT object, stores correlations for
% material properties specific to this propellant and works with the
% PROPELLANT superclass framework for pulling constant material property
% info. from the propellant_data.txt config. file.
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
% Document Version <Oldest Version>, earlier versions:
%   - <Version>
% -------------------------------------------------------------------------
% MATLAB Version <Oldest Version>, also compatible with:
%   - <Later Version>
% -------------------------------------------------------------------------
% Developed by Alex Vance (AlexVance00 on Github)
classdef Ethanol < Propellant

    properties (Constant)
        configName = "ETHANOL"

    end

    methods (Access = public)

    end
end