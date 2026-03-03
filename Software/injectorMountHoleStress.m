% Variables are (mostly) named as they appear on the:
%   "RDT Mechanics of Materials Formula Sheet"

%% Parameters
% in to m
D_injector = 3 .* .0254;
D_chamber_outer = 3 .* .0254 + .005;
Num_bolts = 4;
% psi to Pa
press_chamber = 128 .* 6894.76;
% bolt diam
%   in to m
d_bolt_minor = .25 .* .0254;
% height from top of bolt hole to top of casing
%   mm to m
E_min = 1.5 .* 1E-3;
% chamber wall thickness (t_wall)
wall_thickness = 5 .* 1E-3;

%% Calculations
% F_all_bolts
A_injector = pi ./ 4 .* D_injector.^2;
F_all_bolts = press_chamber .* A_injector

% Bolt shear stress
bolt_stress = F_all_bolts ./ (Num_bolts .* (pi ./ 4) .* d_bolt_minor)

% Bolt tear out stress (tear out of chamber)
chamber_stress = F_all_bolts ./ (2 .* wall_thickness .* E_min .* Num_bolts)

% Hoop stress
%   Using thick-walled cylinder formula
a =
b =
hoop_stress = press_chamber .* (D_injector)