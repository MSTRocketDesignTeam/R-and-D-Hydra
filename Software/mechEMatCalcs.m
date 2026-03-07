% Variables are (mostly) named as they appear on the:
%   "RDT Mechanics of Materials Formula Sheet"

%% Parameters
% psi to Pa
press_ambient = 14.7 .* 6894.76;
% mm to m
D_injector = 76.1 .* 1E-3;
% mm to m
D_chamber_outer_max = 86.4 .* 1E-3;
D_chamber_outer_min = 41.19 .* 1E-3;
% mm to m
D_chamber_inner_max = 76.4 .* 1E-3;
D_chamber_inner_min = 31.19 .* 1E-3;
num_bolts = 4;
% psi to Pa
press_chamber = 128 .* 6894.76;
% bolt diam
%   in to m
d_bolt_minor = .25 .* .0254;
% height from top of bolt hole to top of casing
%   mm to m
E_min = 1.5 .* 1E-3;

%% Calculations
% chamber wall thickness (t_wall)
wall_thickness_max = (D_chamber_outer_max - D_chamber_inner_max) ./ 2;
wall_thickness_min = (D_chamber_outer_min - D_chamber_inner_min) ./ 2;
% F_all_bolts
A_injector = pi ./ 4 .* D_injector.^2;
F_all_bolts = press_chamber .* A_injector;
fprintf("Force on injector is %.2f N\n", F_all_bolts);

% Bolt shear stress
bolt_shear_stress = F_all_bolts ./ (num_bolts .* (pi ./ 4) .* d_bolt_minor);
fprintf("Shear stress on each bolt is %.4f MPa\n", bolt_shear_stress .* 1E-6);

% Bolt tear out stress (tear out of chamber)
bolt_tear_out_stress = F_all_bolts ./ (2 .* wall_thickness_max .* E_min .* num_bolts);
fprintf("Tear-out stress from each bolt is %.4f MPa\n", bolt_tear_out_stress .* 1E-6);

% Hoop and radial stresses
%   Using thick-walled cylinder formula
p_a = press_chamber;
p_b = press_ambient;
%   (1)
a = D_chamber_inner_max;
b = D_chamber_outer_max;
r_max_stress = a;
hoop_stress_max_diam = (p_a .* a.^2 - p_b .* b.^2) ./ (b.^2 - a.^2) + (a.^2 .* b.^2 .* (p_a - p_b)) ./ ((b.^2 - a.^2) .* r_max_stress.^2);
radial_stress_max_diam = (p_a .* a.^2 - p_b .* b.^2) ./ (b.^2 - a.^2) - (a.^2 .* b.^2 .* (p_a - p_b)) ./ ((b.^2 - a.^2) .* r_max_stress.^2);
fprintf("Max hoop stress at largest chamber diam.: %.4f MPa\n", hoop_stress_max_diam .* 1E-6);
fprintf("Max radial stress at largest chamber diam.: %.4f MPa\n", radial_stress_max_diam .* 1E-6);
%   (2)
a = D_chamber_inner_min;
b = D_chamber_outer_min;
r_max_stress = a;
hoop_stress_min_diam = (p_a .* a.^2 - p_b .* b.^2) ./ (b.^2 - a.^2) + (a.^2 .* b.^2 .* (p_a - p_b)) ./ ((b.^2 - a.^2) .* r_max_stress.^2);
radial_stress_min_diam = (p_a .* a.^2 - p_b .* b.^2) ./ (b.^2 - a.^2) - (a.^2 .* b.^2 .* (p_a - p_b)) ./ ((b.^2 - a.^2) .* r_max_stress.^2);
fprintf("Max hoop stress at smallest chamber diam.: %.4f MPa\n", hoop_stress_max_diam .* 1E-6);
fprintf("Max radial stress at smallest chamber diam.: %.4f MPa\n", radial_stress_max_diam .* 1E-6);