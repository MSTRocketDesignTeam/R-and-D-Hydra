%% Regen Engine Trades
% Units start in SI, converted to Imperial later for front end (MATLAB app)
% -------------------------------------------------------------------------

clc
clear

% 1) Make sure python is installed on your system and MATLAB can use it
% 2) Install the rocketcea library/module. Ask internet or AI for help. May
%   need to do some testing to get it working first before trying this
%   script
% 3) Need this py.import... line in order to load the module every time.
%   Like you would for a normal python script.
py.importlib.import_module("rocketcea");
% For data export, to be graphed later in MATLAB app
filename_datastorage = append(pwd, "\regenEngineTradesData.mat");

%% Constants
% g0                        Accel. due to gravity
% Lstar                     L* for props: liquid eth and liquid nit
% CR                        Contraction ratio
% R_universal               Universal gas constant
% pa                        Ambient pressure
% DF*                       Design factor *(for multiple things)
% T_AlSi10Mg_melt           Chamber alloy melting temp
% cost_nit                  USD per kgm
% cost_eth                  USD per kgm
% E_alloy                   Modulus of elasticity of chamber alloy
% alpha_alloy               CTE
% lchannel                  Conservative estimate of coolant channel length
%                               (overestimate- leads to overestimating
%                               minimum required coolant pressure)

filename_config = append(pwd, "calculator_config.txt");

g0 = 9.81;
Lstar = .6; % estimate for MIT's value for their eth/nit biprop was .6
CR = 6;
R_universal = 8.314;
% Calculate pa at Rolla's altitude
% psi to pa
p_sea = 14.7 .* 6894.76;
% K
T_sea = 288.15;
% kg/mol
mlr_wgt_air = .02896968;
L = .00976;
% Thought I found this on wikipedia the other day but now I can't find it
fPAtAlt = @(alt) p_sea .* (1 + (L .* alt) ./ T_sea).^(-g0 .* mlr_wgt_air ./ (R_universal .* L));
alt = 342;
pa = fPAtAlt(alt);

% RDT technically has no DF for these
DF_stress = 2;
DF_temp = 1.5;
DF_p_coolant = 1.2;
% g/cc to kg/m^3
densalloy = 2.665 .* 10.^-3;
% deg C to K
T_AlSi10Mg_melt = 570 + 273.15;
% USD/lbm to USD/kgm
cost_nit = 6 .* 2.20462;
cost_eth = .46 .* 2.20462;
% GPa to Pa - From MetalFab (Ben's compiled material property data table)
E_alloy = 68E9;
% From data sheet: https://www.eos.info/var/assets/03_system-related-assets/material-related-contents/metal-materials-and-examples/metal-material-datasheet/aluminium/material_datasheet_eos_aluminium-alsi10mg_en_web.pdf
% Took most conservative/highest estimate
% K^-1
alpha_alloy = 27E-6;
% in to m
% l_channel = 5 .* .0254;
numelsnoz = 10;
numsectionsnoz = 5;

%% Independent, Variable Parameters
% pc_c                        chamber pressure
% OF                        O to F ratio
% expansion_ratio           
% mdot                      mass flow rate
% d_channel                 coolant channel diameter
% num_channels              coolant channel count
% T_coolant_i               coolant temperature
% wall_t                    hot-wall thickness
% k_wall                    wall material thermal conductivity

list_var_names = ["pc_c";
                  "OF";
                  "expansion_ratio";
                  "mdot";
                  "d_channel";
                  "num_channels";
                  "T_coolant_i";
                  "wall_t";
                  "k_wall"];

%% Independent Variable Nominal Values
std_var_range = [1, 1.1]';
high_def_var_range = linspace(.8, 1.2, 3)';
% std_var_range = highdefvarrange;

% psi to Pa
pc_nom = 128 .* 6894.76;

OF_nom = 1.6;
expansion_ratio_nom = 1.8;
% expansion_ratio_nom = 8;

% lbm/s -> kgm/s
mdot_nom = 1.2 .* .45359237;

% mm to m
d_channel_nom = .8 .* 1E-3;

num_channels_nom = 48;

% convert deg C to K LATER
T_coolant_nom = 24;

% mm to m
wall_t_nom = .8 ./ 1000;

% W/m-K - Largest range I found in the paper: On the thermal conductivity of AlSi10Mg and lattice structures made by laser powder bed fusion Richard R.J. Sélo, Sam Catchpole-Smith, Ian Maskery, Ian Ashcroft, Christopher Tuck
% k_wall range is from ~98 to ~183
% k_wall_nom = (98 + 183) / 2;
k_wall_nom = 112.4;

%% Independent Variable Range Creation
pc_range = pc_nom .* std_var_range;

OF_range = OF_nom .* std_var_range;
% OF_range = OF_nom .* highdefvarrange;
% OF_range = linspace(1.5, 1.7, 5);

expansion_ratio_range = expansion_ratio_nom .* std_var_range;
% expansion_ratio_range = linspace(1.8, 2.2, 5);

mdot_range = mdot_nom .* std_var_range;

d_channel_range = d_channel_nom .* std_var_range;
% d_channel_range = d_channel_nom .* high_def_var_range;

num_channels_range = num_channels_nom .* std_var_range;

T_coolant_i_range = T_coolant_nom .* std_var_range;

% deg C to K
T_coolant_i_range = T_coolant_i_range + 273.15;

wall_t_range = wall_t_nom .* std_var_range;

k_wall_range = k_wall_nom .* std_var_range;

% For sizing resultant N-D arrays to be compatible in one data structure -
%   allows for efficient export and data reading later
ranges = {pc_range, OF_range, expansion_ratio_range, mdot_range, d_channel_range, num_channels_range, T_coolant_i_range, wall_t_range, k_wall_range};

% Returns array of each ranges' sizes
range_lengths = cellfun(@length, ranges);

% Basically a custom version of the ndgrid function
% Most of the problem with the later reshaping these ranges comes from the
%   ranges we leave as single values being the wrong dimensions when they
%   get turned into an N-D array. So we could just leave them as scalars
% Check if any range is a scalar - go through each range in ranges
% Have to make a copy of ranges because the actual ranges is used for
%   initializing the app
% Skip first three; pc_c, OF, eps
starting_i_range = 4;
for i_range = starting_i_range:length(ranges)
    this_range_name = append(list_var_names(i_range), "_range");
    this_range = ranges{i_range};
    if ~isscalar(this_range)
        repmat_dimensions = range_lengths;
        repmat_dimensions(i_range) = 1;
        if i_range ~= starting_i_range
            num_dimensions = i_range - starting_i_range;
            this_range = getReshapedSummationArray(this_range, num_dimensions);
        else
            repmat_dimensions(starting_i_range) = 1;
        end   

        % Get rid of first three dimensions
        repmat_dimensions = repmat_dimensions(4:end);
        
        this_range = repmat(this_range, repmat_dimensions);
        ranges_copy.(this_range_name) = this_range;

        % For debugging
        % disp("This range size is");
        % disp(size(ranges_copy.(this_range_name)));
    end 
end

% Reassign changed ranges to original so they're now properly resized
mdot_range = ranges_copy.mdot_range;
d_channel_range = ranges_copy.d_channel_range;
num_channels_range = ranges_copy.num_channels_range;
T_coolant_i_range = ranges_copy.T_coolant_i_range;
wall_t_range = ranges_copy.wall_t_range;
k_wall_range = ranges_copy.k_wall_range;

% Eliminates trailing singleton dimensions in range_lengths
for i = length(ranges):-1:1
    if range_lengths(i) == 1
        range_lengths = range_lengths(1:i-1);
    else
        break;
    end
end

% Get count of non-singleton dimensions excluding the dimensions of
%   pc_range, OF_range, or expansion_ratio_range
num_dims_small = ndims(mdot_range);

% Get count of non-singleton dimensions among these ranges:
%   pc_range,
%   OF_range,
%   expansion_ratio_range
%
%   Which are iterated through via for-loops, NOT calculated in parallel
%   via vectorization like other independent variables.
%   This is because CEA is not vectorizeable, but the above independent
%   variables are required CEA inputs
num_dims_big = 0;
for i = 1:3
    this_range = ranges{1};
    if ~isscalar(this_range)
        num_dims_big = num_dims_big + 1;
    end
end

% Must still account for sizes of other ranges besides pc_range, OF_range,
%   and expansion_ratio_range
num_dims_big = num_dims_big + num_dims_small;

% Channels are square - this is used for ease of later channel calculations
fChannelArea = @(d) d.^2;
A_channel_range = fChannelArea(d_channel_range);

% For CEA later:
fuel_name = "ETHANOL";
ox_name = "N2O";

%% Things for film coefficient calcs later
% Coolant is ethanol
mlr_wgt_eth = .0460684; % kg/mol
% -------------------------------------------------------------------------
% Stuff for coolant density calcs
% For liquid ethanol cp(T) info - https://webbook.nist.gov/cgi/cbook.cgi?ID=C64175&Mask=187F
% From Green J.H.S 1961, found at temp of 298.15 K ->
% J/mol-K to J/kg-K
cp_eth_avg = 111.96 ./ mlr_wgt_eth;
T_crit_eth = 514; % K
P_crit_eth = 6.14E6; % Pa
% Liquid eth compressibility factor
Zc_eth = .241;
Vc_eth = Zc_eth .* R_universal .* T_crit_eth ./ P_crit_eth;
rho_crit_eth = 276;
fT_r = @(T, T_crit) T ./ T_crit;
% Uses Rackett equation for density
fDensity = @(rho_crit, Zc, T, T_crit) rho_crit ./ Zc.^(1 - fT_r(T, T_crit));
% -------------------------------------------------------------------------
% For coolant thermal conductivity calcs later - all these functions are
% just meant to organize the summation expressions and other things from
% the papers more easily (read the papers)
% From Assael, M.J., et al., Reference Data for the Thermal Conductivity of Ethanol , J. Phys. Chem. Ref. Data, 2010
flambda0eth = @(T) (-2.09575 + 19.9045 .* fT_r(T, T_crit_eth) - 53.964 .* fT_r(T, T_crit_eth).^2 + 82.1223 .* fT_r(T, T_crit_eth).^3 - 1.98864 .* fT_r(T, T_crit_eth).^4 - .495513 .* fT_r(T, T_crit_eth).^5) ./ (.17223 - .078273 .* fT_r(T, T_crit_eth) + fT_r(T, T_crit_eth).^2) .* 10.^-3; % W/m-K
B1_i_eth = [2.67222E-2, 1.48279E-1, -1.30429E-1, 3.46232E-2, -2.44293E-3];
B2_i_eth = [1.77166E-2, -8.93088E-2, 6.84664E-2, -1.45702E-2, 8.09189E-4];
is_delta_lambda = 1:5;

psqueeze = @(A, N) reshape(A, [size(A, N+1), size(A, (N+2):max(N+2, ndims(A)))]);

B1_i_eth = getReshapedSummationArray(B1_i_eth, num_dims_big);
B2_i_eth = getReshapedSummationArray(B2_i_eth, num_dims_big);
is_delta_lambda = getReshapedSummationArray(is_delta_lambda, num_dims_big);
frho_r = @(rho, rho_crit) rho ./ rho_crit;
fdeltalambda_eth = @(rho, T) sum((B1_i_eth + B2_i_eth .* fT_r(T, T_crit_eth)) .* (frho_r(rho, rho_crit_eth)).^is_delta_lambda, num_dims_big + 1);
fdeltalambdac_eth = @(rho, T) 1.7E-3 ./ (7E-2 + abs(fT_r(T, T_crit_eth) - 1)) .* exp(-(1.7 .* (frho_r(rho, rho_crit_eth) - 1)).^2);
fk_eth = @(rho, T) flambda0eth(T) + fdeltalambda_eth(rho, T) + fdeltalambdac_eth(rho, T); % inputs: T in K, rho in kg/m^3; output in W/m-K
% k_coolant sanity check
T_exp_1 = 300;
rho_exp_1 = 850;
k_exp_1_act = 209.68E-3;
k_exp_1_calc = fk_eth(rho_exp_1, T_exp_1);
% -------------------------------------------------------------------------
% For coolant viscosity calcs - read the paper
% From Sotiriadou, S., Ntonti, E., Velliadou, D., Antoniadis, K. D., Assael, M. J., & Huber, M. L. (2023). Reference Correlation for the Viscosity of Ethanol from the Triple Point to 620 K and Pressures Up to 102 MPa
bi_eth = [.422373, -3.78868, 23.8708, -7.89204, 2.09783, -.247702];
ci_eth = [-.0281703, 1];
is_eta0b = 0:5;
is_eta0c = 0:1;
bi_eth = getReshapedSummationArray(bi_eth, num_dims_big);
ci_eth = getReshapedSummationArray(ci_eth, num_dims_big);
is_eta0b = getReshapedSummationArray(is_eta0b, num_dims_big);
is_eta0c = getReshapedSummationArray(is_eta0c, num_dims_big);
feta0_eth = @(T) sum(bi_eth .* fT_r(T, T_crit_eth).^is_eta0b, num_dims_big + 1) ./ sum(ci_eth .* fT_r(T, T_crit_eth).^is_eta0c, num_dims_big + 1);
epsilon_k_B_eth = 265;
fTstar = @(T, epsilon_k_B) T ./ epsilon_k_B;
di = [-1.9572881E1, 2.1973999E2, -1.0153226E3, 2.4710125E3, -3.3751717E3, 2.4916597E3, -7.8726086E2];
di = getReshapedSummationArray(di, num_dims_big);
d7 = 1.4085455E1;
d8 = -3.4664158E-1;
is_Bstar_eta = 0:6;
is_Bstar_eta = getReshapedSummationArray(is_Bstar_eta, num_dims_big);
Bstar_eta_eth = @(Tstar) sum(di .* Tstar.^(-.25 .* is_Bstar_eta), num_dims_big + 1) + d7 .* Tstar.^-2.5 + d8 .* Tstar.^-5.5;
NA = 6.02214076E23;
% nm to m
sigma_eth = .479E-9;
fB_eta_eth = @(T) Bstar_eta_eth(fTstar(T, epsilon_k_B_eth)) .* NA .* sigma_eth.^3 ./ mlr_wgt_eth;
feta1_eth = @(T) feta0_eth(T) .* fB_eta_eth(T);
fdeltaeta_eth = @(rho, T) frho_r(rho, rho_crit_eth).^(2./3) .* fT_r(T, T_crit_eth).^.5 .* (8.32575272 .* frho_r(rho, rho_crit_eth) + 9.66535242E-2 .* (frho_r(rho, rho_crit_eth).^8 ./ (fT_r(T, T_crit_eth).^4 .* (1 + frho_r(rho, rho_crit_eth).^2) - fT_r(T, T_crit_eth).^2)));
fmu_eth = @(rho, T) (feta0_eth(T) + feta1_eth(T) .* rho + fdeltaeta_eth(rho, T)) .* 10.^-6; % inputs: T in K, rho in kg/m^3; output in Pa-s
% mu_coolant sanity check
T_exp_1 = 300;
rho_exp_1 = 10;
mu_exp_1_act = 8.9382E-6;
mu_exp_1_calc = fmu_eth(rho_exp_1, T_exp_1);

% Results of interest, things to graph in the app
therm_stress = zeros(range_lengths);
T_coolant_f = zeros(range_lengths);
Twg = zeros(range_lengths);
yieldstress_alloy = zeros(range_lengths);
Twl = zeros(range_lengths);
q = zeros(range_lengths);
Isp = zeros(range_lengths);
prop_cost_rate = zeros(range_lengths);
At = zeros(range_lengths);
cstar = zeros(range_lengths);
cstar_theo = zeros(range_lengths);
thrust = zeros(range_lengths);
Ae = zeros(range_lengths);
eta_cstar = zeros(range_lengths);
throat_flow_temp = zeros(range_lengths);
Vc = zeros(range_lengths);
flow_sonic = zeros(range_lengths);
vol_engine = zeros(range_lengths);
% + 2 comes from linear section being defined by only two (2) points it
%   doesn't need to be an array
r_engine = zeros([range_lengths, numelsnoz .* (numsectionsnoz - 1) + 2]);
z_engine = zeros([range_lengths, numelsnoz .* (numsectionsnoz - 1) + 2]);
L_nozzle_parabolic = zeros(range_lengths);
Re = zeros(range_lengths);
thetaN = zeros(range_lengths);
xN = zeros(range_lengths);
R1 = zeros(range_lengths);
R1p = zeros(range_lengths);
alpha = zeros(range_lengths);
L_chamber_circular_narrow = zeros(range_lengths);
Rc = zeros(range_lengths);
L_chamber_linear = zeros(range_lengths);
TWR = zeros(range_lengths);
hoop_stress_doghouse = zeros(range_lengths);
hoop_stress_fins = zeros(range_lengths);


%% Begin calcs
% Workflow - hybrid iterative vectorized method
    % Vary pc_c
    %   Vary OF
    %       Vary over expansion_ratio
    %           Get cstar_theo (do CEA)
    %           Begin vectorized equations
    %               Get post-throat gamma and other things
    %               Get exit press
    %               Get CF
    %               Get throat temp from CEA
    %               Get required At
    %               Get required Ae
    %               Get Thrust
    %               Get prop_cost_rate
    %               Get Isp
    %               Get cstar
    %               Get eta_cstar
    %               Get throat wall temp
    % Get thermal stress at throat on hot wall for all calc'd engines
    % Engine contour drawing
    % Get final coolant pressure
    % Get required coolant pressure to keep it liquid
    % Record all data in .mat file and load in app for user
    %   friendly interaction
    % -> to app

% Start runtime tracking for engine iterations
runtime = tic;
% Condensed engine iteration structure brancher
% CEA syntax:
% py.rocketcea.cea_obj.CEA_Obj(fuelName, oxName) - see input_cards.py
% CEA_Obj class functions: (Pc, MR, eps); Pc in psi, MR is OF, eps is expansion_ratio
cea_out = py.rocketcea.cea_obj.CEA_Obj(fuelName = fuel_name, oxName = ox_name, fac_CR = CR);
%% Vary pc_c
for i_pc = 1:length(pc_range)
    pc_c = pc_range(i_pc);

    %% Vary OF
    for i_OF = 1:length(OF_range)
        OF = OF_range(i_OF);

        %% Vary expansion ratio
        for i_eps = 1:length(expansion_ratio_range)
            expansion_ratio = expansion_ratio_range(i_eps);

            %% CEA Calcs
            % Needed for basic results
            % Remember to convert Pa to psi (for inputs), and ft/s to m/s
            % (for outputs)
            % Get specific heat ratio and flow molar weight at throat - for
            % later use in thrust coeff and sonic throat flow velocity calc
            throat_flow_props = double(cea_out.get_Throat_MolWt_gamma(Pc = pc_c * 0.000145038, MR = OF, eps = expansion_ratio));
            throat_flow_mlr_wgt = throat_flow_props(1) .* 10.^-3; % lbm/lbm-mol -> kg/mol
            throat_flow_gamma = throat_flow_props(2);
            exit_flow_props = double(cea_out.get_exit_MolWt_gamma(Pc = pc_c * 0.000145038, MR = OF, eps = expansion_ratio));
            exit_flow_gamma = exit_flow_props(2);
            % Needed for thrust calcs later
            pe = pc_c ./ cea_out.get_PcOvPe(Pc = pc_c * 0.000145038, MR = OF, eps = expansion_ratio);
            Cf = sqrt(2 .* exit_flow_gamma.^2 ./ (exit_flow_gamma - 1) .* (2 ./ (exit_flow_gamma + 1)).^((exit_flow_gamma + 1) ./ (exit_flow_gamma - 1)).*(1 - (pe ./ pc_c).^((exit_flow_gamma - 1) ./ exit_flow_gamma))) + expansion_ratio .* ((pe - pa) ./ pc_c);
            % Thought theoretical Isp might be interesting to compare to
            % predicted-actual, not really used atm though (ca 11/04/2025)
            Isp_theo = cea_out.get_Isp(Pc = pc_c * 0.000145038, MR = OF, eps = expansion_ratio);
            % Gets throat temp needed for several calculations later
            % deg R to K
            CEA_temps = double(cea_out.get_Temperatures(Pc = pc_c * 0.000145038, MR = OF, eps = expansion_ratio)) .* 5 ./ 9;
            throat_flow_temp(i_pc, i_OF, i_eps, :, :, :, :, :, :) = CEA_temps(2);
            chamber_flow_temp = CEA_temps(1);
            exit_flow_temp = CEA_temps(3);
            % Fix units from CEA output lbm/ft^3 -> kg/m^3
            CEA_densities = double(cea_out.get_Densities(Pc = pc_c * 0.000145038, MR = OF, eps = expansion_ratio)) .* 16.018463;
            throat_flow_density = CEA_densities(2);
            % Gets things needed for gas film coeff calc later
            throat_trans = double(cea_out.get_Throat_Transport(Pc = pc_c * 0.000145038, MR = OF, eps = expansion_ratio));
            cp_flow_t = throat_trans(1);
            % Convert from Btu/lbm-degR to SI units, J/kg-K
            cp_flow_t = cp_flow_t .* 1055.06 ./ (.453592 ./ 1.8);
            % milipoise to Pa-s
            mu_flow_t = throat_trans(2) .* 10.^-4;
            % millicalories / (cm-K-sec) to W/m-K
            k_flow_t = throat_trans(3) .* .4184;
            Pr_flow_t = throat_trans(4);
            chamber_trans = double(cea_out.get_Chamber_Transport(Pc = pc_c * 0.000145038, MR = OF, eps = expansion_ratio));
            % Convert from But/lbm-degR to SI units, J/kg-K
            cp_flow_chamber = chamber_trans(1) .* 1055.06 ./ (.453592 ./ 1.8);
            % milipoise to Pa-s
            mu_flow_chamber = chamber_trans(2) .* 10.^-4;
            % millicalories / (cm-K-sec) to W/m-K
            k_flow_chamber = chamber_trans(3) .* .4184;
            Pr_flow_chamber = chamber_trans(4);

            % ft/s -> m/s
            cstar_theo(i_pc, i_OF, i_eps, :, :, :, :, :, :) = cea_out.get_Cstar(Pc = pc_c * 0.000145038, MR = OF) .* .3048;

            % Get some KPPs and other sizing info for trade alternatives
            flow_sonic(i_pc, i_OF, i_eps, :, :, :, :, :, :) = sqrt(throat_flow_gamma * R_universal / throat_flow_mlr_wgt * squeeze(throat_flow_temp(i_pc, i_OF, i_eps, :, :, :, :, :, :)));
            % Check sonic flow velocity
            CEA_velocity_sonic_flow = cea_out.get_Chamber_SonicVel(Pc = pc_c * 0.000145038, MR = OF, eps = expansion_ratio);
            At(i_pc, i_OF, i_eps, :, :, :, :, :, :) = mdot_range ./ squeeze(flow_sonic(i_pc, i_OF, i_eps, :, :, :, :, :, :)) ./ throat_flow_density;
            Vc(i_pc, i_OF, i_eps, :, :, :, :, :, :) = squeeze(At(i_pc, i_OF, i_eps, :, :, :, :, :, :)) .* Lstar;
            Ae(i_pc, i_OF, i_eps, :, :, :, :, :, :) = squeeze(At(i_pc, i_OF, i_eps, :, :, :, :, :, :)) .* expansion_ratio;
            thrust(i_pc, i_OF, i_eps, :, :, :, :, :, :) = Cf .* squeeze(At(i_pc, i_OF, i_eps, :, :, :, :, :, :)) .* pc_c;
            prop_cost_rate(i_pc, i_OF, i_eps, :, :, :, :, :, :) = mdot_range .* (cost_nit .* (1 ./ (1 + OF) .* OF) + cost_eth .* (1 ./ (1 + OF)));
            Isp(i_pc, i_OF, i_eps, :, :, :, :, :, :) = squeeze(thrust(i_pc, i_OF, i_eps, :, :, :, :, :, :)) ./ mdot_range ./ g0;
            cstar(i_pc, i_OF, i_eps, :, :, :, :, :, :) = squeeze(Isp(i_pc, i_OF, i_eps, :, :, :, :, :, :)) .* g0 ./ Cf;
            eta_cstar(i_pc, i_OF, i_eps, :, :, :, :, :, :) = squeeze(cstar(i_pc, i_OF, i_eps, :, :, :, :, :, :)) ./ squeeze(cstar_theo(i_pc, i_OF, i_eps, :, :, :, :, :, :));

            dt = sqrt(squeeze(At(i_pc, i_OF, i_eps, :, :, :, :, :, :)) .* 4 ./ pi);

            %% Calculate nozzle contour geometry

            % Doing Rao approximation bell contour nozzle
            % GT slides:
            % From: https://www.seitzman.gatech.edu/classes/ae6450/nozzle_geometries.pdf
            
            % Assemble bottom up, starting with nozzle exit, but not
            % necessarily calculated in that order:

            % Sections in order by calculation:
            % ----------------
            % Nozzle circular
            % Chamber circular
            % Nozzle parabolic
            % Chamber parabolic
            % Chamber linear

            %% Nozzle circular
            % Give the contour arrays a few datapoints
            % Keep using numelsnoz
            % Makes an arc around 0,0 and shifts later for simplicity
            Rt = dt ./ 2;
            R1(i_pc, i_OF, i_eps, :, :, :, :, :, :) = .382 .* Rt;
            % GT slides say 15 degrees, but using 20 because for
            % 100% fpct and ~5 expansion ratio, 20's a good thetaN and it's
            % close enough to 15 degrees
            % Convert to radians
            thetaN(i_pc, i_OF, i_eps, :, :, :, :, :, :) = 20 ./ 180 .* pi;
            xN(i_pc, i_OF, i_eps, :, :, :, :, :, :) = squeeze(R1(i_pc, i_OF, i_eps, :, :, :, :, :, :)) .* sin(squeeze(thetaN(i_pc, i_OF, i_eps, :, :, :, :, :, :)));
            L_nozzle_circular = squeeze(xN(i_pc, i_OF, i_eps, :, :, :, :, :, :));
            
            % Basically makes a linspace from 0 to L_nozzle_circular's
            %   value at every index in L_nozzle_circular
            z_nozzle_circular = getReshapedSummationArray(linspace(0, 1, numelsnoz), num_dims_small);
            z_nozzle_circular = z_nozzle_circular .* L_nozzle_circular;

            rc = Rt + squeeze(R1(i_pc, i_OF, i_eps, :, :, :, :, :, :));

            r_nozzle_circular = rc - (squeeze(R1(i_pc, i_OF, i_eps, :, :, :, :, :, :)).^2 - z_nozzle_circular.^2).^.5;

            % Flip upside down (flip last dimension)
            r_nozzle_circular = flip(r_nozzle_circular, num_dims_small + 1);
            % Shift in z
            fpct = 1;
            L_nozzle = fpct .* Rt ./ tan(squeeze(thetaN(i_pc, i_OF, i_eps, :, :, :, :, :, :))) .* (sqrt(expansion_ratio) - 1 + 1.5 .* (1 ./ cos(squeeze(thetaN(i_pc, i_OF, i_eps, :, :, :, :, :, :))) - 1));
            z_nozzle_circular = z_nozzle_circular + L_nozzle - L_nozzle_circular;

            %% Chamber circular widen
            R1p(i_pc, i_OF, i_eps, :, :, :, :, :, :) = Rt .* 1.5;
            Rc(i_pc, i_OF, i_eps, :, :, :, :, :, :) = CR.^.5 .* Rt;
            % Side note: can calculate max hoop stress now
            % Equa: hoop_stress_doghouse = pd/2t
            % This hoop stress calc is calculating the "doghouse effect"
            %   stress
            hoop_stress_doghouse(i_pc, i_OF, i_eps, :, :, :, :, :, :) = pc_c .* 2 .* squeeze(Rc(i_pc, i_OF, i_eps, :, :, :, :, :, :)) ./ 2 ./ wall_t_range;
            % This hoop stress calc is calculating the stress on the fins
            %   between the channels, starting from one hot-wall-thickness
            %   into the hot-wall and ending where the fin contacts the
            %   outer jacket wall
            hoop_stress_fins(i_pc, i_OF, i_eps, :, :, :, :, :, :) = pc_c .* 2 .* (squeeze(Rc(i_pc, i_OF, i_eps, :, :, :, :, :, :)) + wall_t_range) ./ 2 ./ d_channel_range;
            % Arbitrary chamber converging section geometry choice. Made it
            % a circle for simplicity
            % Try deriving alpha from scale of how far in between throat
            % radius and chamber radius I want arc to stop
            % Using a while loop to avoid impossible geometric constraints
            etaRc = .2;
            while true
                alpha(i_pc, i_OF, i_eps, :, :, :, :, :, :) = acos(1 - (etaRc .* (squeeze(Rc(i_pc, i_OF, i_eps, :, :, :, :, :, :)) - Rt)) ./ squeeze(R1p(i_pc, i_OF, i_eps, :, :, :, :, :, :)));
    
                L_chamber_circular_widen = squeeze(R1p(i_pc, i_OF, i_eps, :, :, :, :, :, :)) .* sin(squeeze(alpha(i_pc, i_OF, i_eps, :, :, :, :, :, :)));
    
                z_chamber_circular_widen = getReshapedSummationArray(linspace(0, 1, numelsnoz), num_dims_small);
                z_chamber_circular_widen = z_chamber_circular_widen .* L_chamber_circular_widen;
    
                rc = Rt + squeeze(R1p(i_pc, i_OF, i_eps, :, :, :, :, :, :));
    
                % No need to flip upside down
                r_chamber_circular_widen = rc - (squeeze(R1p(i_pc, i_OF, i_eps, :, :, :, :, :, :)).^2 - z_chamber_circular_widen.^2).^.5;
    
                % Shift in z
                z_chamber_circular_widen = z_chamber_circular_widen + z_nozzle_circular(:, :, :, :, :, :, end);
    
                %% Nozzle parabolic
                % Start with coord system the same way as done with the nozzle
                % circular section, then shift later
                % Based on the low expansion ratios we'll be using and high
                % fpct for low thetae (in context of Rao):
                % Use thetaN, the nozzle-circular end-part's angle.
                % thetaN stays the same
                Re(i_pc, i_OF, i_eps, :, :, :, :, :, :) = expansion_ratio.^.5 .* Rt; 
                L_nozzle_parabolic(i_pc, i_OF, i_eps, :, :, :, :, :, :) = L_nozzle - L_nozzle_circular;
    
                z_nozzle_parabolic = getReshapedSummationArray(linspace(0, 1, numelsnoz), num_dims_small);
                z_nozzle_parabolic = z_nozzle_parabolic .* squeeze(L_nozzle_parabolic(i_pc, i_OF, i_eps, :, :, :, :, :, :));
    
                % Nonlinear three variable system - solved by hand
                k = squeeze(Re(i_pc, i_OF, i_eps, :, :, :, :, :, :)).^2 ./ (2 .* tan(squeeze(thetaN(i_pc, i_OF, i_eps, :, :, :, :, :, :))) .* squeeze(L_nozzle_parabolic(i_pc, i_OF, i_eps, :, :, :, :, :, :)) + 2 .* squeeze(Re(i_pc, i_OF, i_eps, :, :, :, :, :, :)));
                b = 2 .* tan(squeeze(thetaN(i_pc, i_OF, i_eps, :, :, :, :, :, :))) .* k;
                h = -b ./ (4 .* tan(squeeze(thetaN(i_pc, i_OF, i_eps, :, :, :, :, :, :))).^2);            
    
                r_nozzle_parabolic = (b .* (z_nozzle_parabolic - h)).^.5 + k;
                
                % r not controlled for thetaN at z=0 constraint, so have to
                % account for that with a shift
                rShift = r_nozzle_circular(:, :, :, :, :, :, 1) - r_nozzle_parabolic(:, :, :, :, :, :, 1);
                r_nozzle_parabolic = r_nozzle_parabolic + rShift;
            
                % Flip z
                z_nozzle_parabolic = flip(z_nozzle_parabolic, num_dims_small + 1);
    
                %% Chamber circular narrow
                % Yes I realize it isn't circular, it used to be and I
                % never changed the name
                % Angle stays same as where it meets chamber circular widen
                % section.
                % alpha stays the same
    
                r1 = squeeze(Rc(i_pc, i_OF, i_eps, :, :, :, :, :, :)) - r_chamber_circular_widen(:, :, :, :, :, :, end);
    
                % Parabolic curve, solved by hand for a and b
                b = tan(squeeze(alpha(i_pc, i_OF, i_eps, :, :, :, :, :, :)));
                a = -b.^2 ./ (4 .* r1);
    
                z1 = (-b + (b.^2 + 4 .* a .* r1).^.5) ./ (2 .* a);
                if isreal(z1)
                   break
                else
                    etaRc = etaRc + .1 .* (1 - etaRc);
                end
            end
            L_chamber_circular_narrow(i_pc, i_OF, i_eps, :, :, :, :, :, :) = z1;

            z_chamber_circular_narrow = getReshapedSummationArray(linspace(0, 1, numelsnoz), num_dims_small);
            z_chamber_circular_narrow = z_chamber_circular_narrow .* squeeze(L_chamber_circular_narrow(i_pc, i_OF, i_eps, :, :, :, :, :, :));

            r_chamber_circular_narrow = a .* z_chamber_circular_narrow.^2 + b .* z_chamber_circular_narrow;

            % r and z should already be in the proper orientation, so just
            %   shift r out and z out
            z_chamber_circular_narrow = z_chamber_circular_narrow + z_chamber_circular_widen(:, :, :, :, :, :, end);
            r_chamber_circular_narrow = r_chamber_circular_narrow + r_chamber_circular_widen(:, :, :, :, :, :, end);

            % Adjust z and r arrays for nozzle_parabolic so elements are in
            %   right order but are still synced
            z_nozzle_parabolic = flip(z_nozzle_parabolic, num_dims_small + 1);
            r_nozzle_parabolic = flip(r_nozzle_parabolic, num_dims_small + 1);

            %% Chamber linear

            % Get volume of chamber circular narrow and chamber circular
            % widen sections to calculate what remains of Vc, derive
            % chamber linear dimensions from that remainder of Vc
            % Account for widen section volume first
            dz_chamber_circular_widen = diff(z_chamber_circular_widen, [], num_dims_small + 1);
            Vcl = squeeze(Vc(i_pc, i_OF, i_eps, :, :, :, :, :, :)) - pi .* sum(r_chamber_circular_widen(:, :, :, :, :, :, 1:end-1).^2 .* dz_chamber_circular_widen, num_dims_small + 1);
            % Then for narrow section volume
            dz_chamber_circular_narrow = diff(z_chamber_circular_narrow, [], num_dims_small + 1);
            Vcl = Vcl - pi .* sum(r_chamber_circular_narrow(:, :, :, :, :, :, 1:end-1).^2 .* dz_chamber_circular_narrow, num_dims_small + 1);

            L_chamber_linear(i_pc, i_OF, i_eps, :, :, :, :, :, :) = Vcl ./ (pi .* squeeze(Rc(i_pc, i_OF, i_eps, :, :, :, :, :, :)).^2);

            % Using 2 instead of numelsnoz in ones() because this section
            %   is straight, defined by only two (2) points
            r_chamber_linear = getReshapedSummationArray(ones(1, 2), num_dims_small);
            r_chamber_linear = r_chamber_linear .* squeeze(Rc(i_pc, i_OF, i_eps, :, :, :, :, :, :));

            % Using 2 instead of numelsnoz in linspace() because this
            %   section is straight, defined by only two (2) points
            z_chamber_linear = getReshapedSummationArray(linspace(0, 1, 2), num_dims_small);
            z_chamber_linear = z_chamber_linear .* squeeze(L_chamber_linear(i_pc, i_OF, i_eps, :, :, :, :, :, :));

            % Shift z
            z_chamber_linear = z_chamber_linear + max(z_chamber_circular_narrow, [], 7);

            %% Compile all sections to export to app
            r_engine(i_pc, i_OF, i_eps, :, :, :, :, :, :, :) = cat(7, r_nozzle_parabolic, r_nozzle_circular, r_chamber_circular_widen, r_chamber_circular_narrow, r_chamber_linear);
            z_engine(i_pc, i_OF, i_eps, :, :, :, :, :, :, :) = cat(7, z_nozzle_parabolic, z_nozzle_circular, z_chamber_circular_widen, z_chamber_circular_narrow, z_chamber_linear);
            vol_engine(i_pc, i_OF, i_eps, :, :, :, :, :, :) = pi .* sum((squeeze(r_engine(i_pc, i_OF, i_eps, :, :, :, :, :, :, :)) + 3 .* wall_t_range).^2 - squeeze(r_engine(i_pc, i_OF, i_eps, :, :, :, :, :, :, :)).^2 - num_channels_range .* d_channel_range.^2, 7);
            
            % Axial temperature gradient
            %   Get temps here:
            % --------------------
            % Chamber
            % Chamber parab -> Chamber circ
            % Throat
            % Nozzle circ -> Nozzle parab
            % Exit

            axial_temp_grad = [squeeze(z_engine(i_pc, i_OF, i_eps, 1, 1, 1, 1, 1, 1, :))'; zeros(1, length(z_engine(i_pc, i_OF, i_eps, 1, 1, 1, 1, 1, 1, :)))];
            axial_mach_grad = axial_temp_grad;
            axial_vel_grad = axial_temp_grad;
            axial_rho_grad = axial_temp_grad;
            mu_flow_grad = axial_temp_grad;
            k_flow_grad = axial_temp_grad;
            Pr_flow_grad = axial_temp_grad;
            area_ratios = squeeze(r_engine(i_pc, i_OF, i_eps, :, :, :, :, :, :, :)).^2 ./ Rt.^2;

            % area_ratios is the same for every for-loop iteration varying
            %   across expansion_ratio_range
            % For now don't investigate, but evidence
            %   suggests this is common across all dimensions, so just make
            %   it a scalar to save time and complexity
            area_ratios = squeeze(area_ratios(1, 1, 1, 1, 1, 1, :))';

            chamber_flow_mach = cea_out.get_Chamber_MachNumber(Pc = pc_c * 0.000145038, MR = OF, fac_CR = CR);
            chamber_flow_props = double(cea_out.get_Chamber_MolWt_gamma(Pc = pc_c * 0.000145038, MR = OF, eps = expansion_ratio));
            chamber_flow_gamma = chamber_flow_props(2);

            % Rearranged stagnation temp equation with knowns at chamber
            stag_flow_temp = chamber_flow_temp ./ (1 + (chamber_flow_gamma - 1) ./ 2 .* chamber_flow_mach.^2).^-1;
            
            % Assume isentropic flow

            % Use area_ratios to get Mach number
            %   Will have to use Newton Rhapson Mtd
            tol_low = .0001;
            syms Mn
            bool_subsonic = 1;

            % M term not present because M is 1
            temp_mach_constant = squeeze(throat_flow_temp(i_pc, i_OF, i_eps, 1, 1, 1, 1, 1, 1)) * (1 + (throat_flow_gamma - 1) / 2);
            fGetTemperatureOfMach = @(M, gamma) temp_mach_constant / (1 + (gamma - 1) / 2 * M^2);

            for i_AR = length(area_ratios):-1:1
                area_ratio = area_ratios(i_AR);
                
                % Gamma and M guesser
                % Checks if still in subsonic region
                if bool_subsonic % Still in chamber region
                    % Checks if throat has been reached yet
                    if abs(area_ratio - 1) <= tol_low % Throat reached, switch to using throat value
                        bool_subsonic = 0;
                        gamma_guess = throat_flow_gamma;
                        mu_flow_station = mu_flow_t;
                        k_flow_station = k_flow_t;
                        Pr_flow_station = Pr_flow_t;
                        M_guess = 1;
                    else % Throat not reached, keep using chamber value
                        gamma_guess = chamber_flow_gamma;
                        mu_flow_station = mu_flow_chamber;
                        k_flow_station = k_flow_chamber;
                        Pr_flow_station = Pr_flow_chamber;
                        M_guess = .01;
                    end
                else % In supersonic region, use throat value
                    gamma_guess = throat_flow_gamma;
                    mu_flow_station = mu_flow_t;
                    k_flow_station = k_flow_t;
                    Pr_flow_station = Pr_flow_t;

                    % Checks if M_guess should be 1 or 1.2
                    if abs(area_ratio - 1) <= tol_low
                        M_guess = 1;
                    else
                        M_guess = 1.2;
                    end
                end

                func_xn = (1 / Mn) * ((2 / (gamma_guess + 1)) * (1 + ((gamma_guess - 1) / 2) * Mn^2))^((gamma_guess + 1) / (2 * (gamma_guess - 1))) - area_ratio;
                func_prime_xn = diff(func_xn, Mn);

                M = M_guess;
                residual = double(subs(func_xn, Mn, M));
                while abs(residual) >= tol_low
                    M = M - double(subs(func_xn, Mn, M)) / double(subs(func_prime_xn, Mn, M));
                    residual = double(subs(func_xn, Mn, M));
                end

                % For debugging
                % fprintf("M is %f\n", M);
                axial_mach_grad(2, i_AR) = M;
                temp_i_AR = fGetTemperatureOfMach(M, gamma_guess);
                axial_temp_grad(2, i_AR) = temp_i_AR;
                axial_vel_grad(2, i_AR) = (gamma_guess .* R_universal .* temp_i_AR ./ M) .^ .5;
                % Just 1st engine config for now
                cross_section_area = area_ratio .* squeeze(At(i_pc, i_OF, i_eps, 1, 1, 1, 1, 1, 1));
                mu_flow_grad(2, i_AR) = mu_flow_station;
                k_flow_grad(2, i_AR) = k_flow_station;
                Pr_flow_grad(2, i_AR) = Pr_flow_station;
                % Will need grad for Re_D_flow too
            end

            % -------------------------------------------------------------
            

            % Needed to find film coeffs
            % flow velocity in chamber (just throat flow vel or sonic flow
            % vel bc we're at throat)
            flow_vel = flow_sonic;
            % hydraulic radius of channel is 4 * area / perimeter
            dH_channels = 4 .* A_channel_range ./ (4 .* d_channel_range);
            % Remember it's just fuel in channels
            mdot_channel = mdot_range .* (1 ./ (1 + OF)) ./ num_channels_range;
            % rackett equation used to calc coolant density
            rho_coolant = fDensity(rho_crit_eth, Zc_eth, T_coolant_i_range, T_crit_eth);
            k_coolant = fk_eth(rho_coolant, T_coolant_i_range);
            mu_coolant = fmu_eth(rho_coolant, T_coolant_i_range);
            coolant_vel = mdot_channel ./ A_channel_range ./ rho_coolant;
            % -------------------------------------------------------------

            % liquid and gas film coeffs - equas 8-21 and 8-24 in RPE by
            % Sutton
            % Check throat Re is high enough (> 10k) to use Sutton hl
            % equation
            % hydraulic diam is 4 * area / perimeter
            
            Re_D_flow = throat_flow_density .* squeeze(flow_vel(i_pc, i_OF, i_eps, :, :, :, :, :, :)) .* dt ./ mu_flow_t;
            % Check if Re_D_flow is laminar or turbulent
            Re_D_critical = 2300;
            Re_D_flow_laminar_mask = Re_D_flow <= Re_D_critical;
            Re_D_flow_turbulent_mask = ~Re_D_flow_laminar_mask;

            Re_coolant = dH_channels .* coolant_vel .* rho_coolant ./ mu_coolant;
            Pr_coolant = cp_eth_avg .* mu_coolant ./ k_coolant;
            % Exponent on Pr_coolant is .4 bc fluid is being heated - https://www.sciencedirect.com/topics/engineering/dittus-boelter-correlation?
            NU_coolant = .023 .* Re_coolant.^.8 .* Pr_coolant.^.4;
            hl_laminar_mask = Re_coolant <= Re_D_critical;
            hl_turbulent_mask = ~hl_laminar_mask;
            hl = zeros(range_lengths(4:end));
            % only valid for laminar
            hl(hl_laminar_mask) = .023 .* cp_eth_avg .* mdot_channel(hl_laminar_mask) ./ A_channel_range(hl_laminar_mask) .* Re_coolant(hl_laminar_mask).^-.2 .* (mu_coolant(hl_laminar_mask) .* cp_eth_avg ./ k_coolant(hl_laminar_mask)).^(-2./3);
            % Dittus Boelter correlation, used with caution from Re = 2300 to Re = 10k, above 10k it's pretty good
            hl(hl_turbulent_mask) = NU_coolant(hl_turbulent_mask) .* k_coolant(hl_turbulent_mask) ./ dH_channels(hl_turbulent_mask);
            
            hg = .023 .* (throat_flow_density .* squeeze(flow_vel(i_pc, i_OF, i_eps, :, :, :, :, :, :))).^.8 ./ dt.^.2 .* Pr_flow_t.^.4 .* k_flow_t ./ mu_flow_t.^.8;
            
            % pc_pe_c = get_PcOvPe(Pc = pc_c * 0.000145038, MR = OF, eps = expansion_ratio);
            % Convert to SI
            pc_pe_t = cea_out.get_Throat_PcOvPe(Pc = pc_c * 0.000145038, MR = OF);
            pc_t = pc_pe_t .* pe;
            

            % Get radial heat transfer through wall and hot wall temps
            % Accounts for hl coefficient being for heat transfer over
            %   larger area than hg coefficient (hot wall area facing
            %   channel per-cross-section is larger inside the channel than
            %   in the chamber)
            
            % h is convective heat transfer coefficient
            % k is conductive heat transfer coefficient
            % TR = thermal resistance
            
            % fGetBartzhg
            % h_flow_wall_convection = 
            k_innerwall_innerwall_conduction = k_wall_range;
            h_innerwall_coolant_convection = 1;
            h_coolant_outerwall_convection = 1;
            k_outerwall_outerwall_conduction = 1;
            % h_outerwall_air_convection;

            TR_flow_wall_convection = 1;
            TR_innerwall_innerwall_conduction = 1;
            TR_innerwall_coolant_convection = 1;
            TR_coolant_outerwall_convection = 1;
            TR_outerwall_outerwall_conduction = 1;
            TR_outerwall_air_convection = 1;
            % Not modeling any radiation
            
            % TR_lumped = 
            TR_lumped = (1 ./ hg + wall_t_range ./ k_wall_range + 1 ./ hl ./ ((dt + wall_t_range) ./ dt));
            q(i_pc, i_OF, i_eps, :, :, :, :, :, :) = (squeeze(throat_flow_temp(i_pc, i_OF, i_eps, :, :, :, :, :, :)) - T_coolant_i_range) ./ TR_lumped;
            Twg(i_pc, i_OF, i_eps, :, :, :, :, :, :) = squeeze(throat_flow_temp(i_pc, i_OF, i_eps, :, :, :, :, :, :)) - squeeze(q(i_pc, i_OF, i_eps, :, :, :, :, :, :)) ./ hg;
            Twl(i_pc, i_OF, i_eps, :, :, :, :, :, :) = T_coolant_i_range + squeeze(q(i_pc, i_OF, i_eps, :, :, :, :, :, :)) ./ hl;


            yieldstress_alloy(i_pc, i_OF, i_eps, :, :, :, :, :, :) = getYieldStress(squeeze(Twg(i_pc, i_OF, i_eps, :, :, :, :, :, :)));
                
            % Find q at axial nodes
            % Go from intersection of nozzle_parabolic and nozzle_circular
            %   up to intersection of chamber_circular and
            %   chamber_parabolic, only for nominal engine profile
            % First engine iteration only

            if i_pc == 1 && i_OF == 1 && i_eps == 1
                q_grad = [squeeze(z_engine(i_pc, i_OF, i_eps, 1, 1, 1, 1, 1, 1, :))'; zeros(1, length(z_engine(i_pc, i_OF, i_eps, 1, 1, 1, 1, 1, 1, :)))];

                % Loop
                % But some things are constant
                dH_channels_station = dH_channels(1, 1, 1, 1, 1, 1);
                mdot_channel_station = mdot_channel(1, 1, 1, 1, 1, 1);
                rho_coolant_station = rho_coolant(1, 1, 1, 1, 1, 1);
                k_coolant_station = k_coolant(1, 1, 1, 1, 1, 1);
                mu_coolant_station = mu_coolant(1, 1, 1, 1, 1, 1);
                coolant_vel_station = coolant_vel(1, 1, 1, 1, 1, 1);
                A_channel_station = A_channel_range(1, 1, 1, 1, 1, 1);
                mdot_flow = mdot_range(1, 1, 1, 1, 1, 1);

                Re_coolant_station = Re_coolant(1, 1, 1, 1, 1, 1);
                Pr_coolant_station = Pr_coolant(1, 1, 1, 1, 1, 1);
                % Exponent on Pr_coolant is .4 bc fluid is being heated - https://www.sciencedirect.com/topics/engineering/dittus-boelter-correlation?
                NU_coolant_station = .023 .* Re_coolant_station.^.8 .* Pr_coolant_station.^.4;
                bool_laminar_station = Re_coolant_station <= Re_D_critical;
                if bool_laminar_station % only valid for laminar
                    hl_station = .023 .* cp_eth_avg .* mdot_channel_station ./ A_channel_station .* Re_coolant_station.^-.2 .* (mu_coolant_station .* cp_eth_avg ./ k_coolant_station).^(-2./3);
                else % Dittus Boelter correlation, used with caution from Re = 2300 to Re = 10k, above 10k it's pretty good
                    hl_station = NU_coolant_station .* k_coolant_station ./ dH_channels_station;
                end

                cross_areas = area_ratios .* squeeze(At(i_pc, i_OF, i_eps, 1, 1, 1, 1, 1, 1));
                
                z_engine_slice = z_engine(i_pc, i_OF, i_eps, 1, 1, 1, 1, 1, 1, :);
                r_engine_slice = r_engine(i_pc, i_OF, i_eps, 1, 1, 1, 1, 1, 1, :);

                % z starts at nozzle and goes to injector, so iterate
                %   backwards to iterate along developing flow
                for i_station = length(z_engine_slice):-1:1
                    
                    % Get flow_vel_station
                    flow_vel_station = axial_vel_grad(2, i_station);

                    cross_area_station = cross_areas(i_station);
                    flow_rho_station = mdot_flow ./ cross_area_station ./ flow_vel_station;
                    mu_flow_station = mu_flow_grad(2, i_station);
                    k_flow_station = k_flow_grad(2, i_station);
                    Pr_flow_station = Pr_flow_grad(2, i_station);

                    % Doesn't exist yet
                    % Re_D_flow_station = Re_D_flow_grad(2, i_station);

                    d_chamber_station = (cross_area_station ./ pi .* 4).^.5;
                    hg_station = .023 .* (flow_rho_station .* flow_vel_station).^.8 ./ d_chamber_station.^.2 .* Pr_flow_station.^.4 .* k_flow_station ./ mu_flow_station.^.8;
                    
                    temp_flow_station = axial_temp_grad(2, i_station);
                   
                    z_engine_station = z_engine_slice(i_station);
                    % x must be distance from datum, which is injector
                    %   faceplate
                    x = z_engine_station(end) - z_engine_station;
                    r_engine_station = r_engine_slice(i_station);

                    D_station = 2 .* r_engine_station;


                    % Thermal resistances

                    % f_flow_wall_station = GetFrictionFactor();

                    Nu_D_flow_wall_convection_station = GetNu_D(f = ...
                        1, Re_D = 1, ...
                        Pr = Pr_flow_station, D = d_chamber_station, ...
                        L = x, x = x);

                    h_flow_wall_convection_station = ...
                        Geth(Nu_D_flow_wall_convection_station, ...
                        d_chamber_station, k_flow_station);

                    TR_flow_wall_convection_station = ...
                        GetThermalResistance(heat_transfer_type = ...
                            "forced convection", ...
                        h = h_flow_wall_convection_station, ...
                        r_0 = r_engine_station, ...
                        r_1 = r_engine_station);


                    k_innerwall_innerwall_conduction_station = 1;
                    r_0_innerwall_innerwall_conduction_station = 1;
                    r_1_innerwall_innerwall_conduction_station = 1;
                    r_2_innerwall_innerwall_conduction_station = 1;

                    % TR_innerwall_innerwall_conduction_station = ...
                    %     GetThermalResistance(k = ...
                    %     k_innerwall_innerwall_conduction_station);


                    TR_innerwall_coolant_convection_station = ...
                        GetThermalResistance(heat_transfer_type = ...
                            "forced convection", ...
                        h = 1, ...
                        r_0 = r_engine_station, ...
                        r_1 = 1);


                    TR_coolant_outerwall_convection_station = ...
                        GetThermalResistance(heat_transfer_type = ...
                            "forced convection", ...
                        h = 1, ...
                        r_0 = r_engine_station, ...
                        r_1 = 1);


                    TR_outerwall_outerwall_conduction_station = 1;


                    TR_outerwall_air_convection_station = ...
                        GetThermalResistance(heat_transfer_type = ...
                            "free convection", ...
                        h = 1, ...
                        r_0 = r_engine_station, ...
                        r_1 = 1);

                    % TR_lumped_station = TR_flow_wall_convection_station +
                    %   TR_innerwall_innerwall_conduction_station +
                    %   TR_innerwall_coolant_convection_station +
                    %   TR_coolant_outerwall_convection_station +
                    %   TR_outerwall_outerwall_conduction_station +
                    %   TR_outerwall_air_convection_station;
                    TR_lumped_station = (1 ./ hg_station + wall_t_range(1, 1, 1, 1, 1, 1) ./ k_wall_range(1, 1, 1, 1, 1, 1) + 1 ./ hl_station ./ ((d_chamber_station + wall_t_range(1, 1, 1, 1, 1, 1)) ./ d_chamber_station));
                    q_grad(2, i_station) = (temp_flow_station - T_coolant_i_range(1, 1, 1, 1, 1, 1)) ./ TR_lumped_station;
                end      
            end           

            % For now, this is just approximated using the throat heat
            %   transfer
            % delta T of coolant just at throat cross section
            deltaT_coolantslice = squeeze(q(i_pc, i_OF, i_eps, :, :, :, :, :, :)) .* d_channel_range ./ mdot_channel ./ cp_eth_avg;
            % assume at worst, it's that much at EVERY cross section
            % per-channel delta T
            l_channel = 2 .* max(squeeze(z_engine(i_pc, i_OF, i_eps, :, :, :, :, :, :, :)), [], 7);
            deltaT_coolant = deltaT_coolantslice .* l_channel;
            T_coolant_f(i_pc, i_OF, i_eps, :, :, :, :, :, :) = T_coolant_i_range + deltaT_coolant;

            % Very crude estimate, basically assumes solid engine. no
            %   cavities inside aka no chamber
            % Honestly meaningless atm, was used earlier but now not so
            %   much. May implement more in the future
            TWR(i_pc, i_OF, i_eps, :, :, :, :, :, :) = squeeze(thrust(i_pc, i_OF, i_eps, :, :, :, :, :, :)) ./ (g0 .* densalloy .* squeeze(vol_engine(i_pc, i_OF, i_eps, :, :, :, :, :, :)));
            if ~isreal(r_engine)
                disp('non real physical engine design');
            end
        end
    end
end
% min coolant press to prevent it boiling in the channels (w/in DF)
P_coolant_min = GetVaporizationPressure(T_coolant_f) ./ DF_p_coolant;
therm_stress(:, :, :, :, :, :, :, :, :) = E_alloy .* alpha_alloy .* (Twg - Twl);

% Get runtime diagnostics
runtime = toc(runtime)
num_engines = prod(range_lengths)
timeperengine = runtime / num_engines

% Haven't finished doing all the unit conversions yet for imperial system
% outputs
% constants
% K to deg C
T_AlSi10Mg_melt = T_AlSi10Mg_melt - 273.15;
T_w_max = T_AlSi10Mg_melt ./ DF_temp;
% Already in MPa
yieldstress_max = yieldstress_alloy ./ DF_stress;
% independent vars
% update this compact cell array too
% ranges = {pc_range, OF_range, expansion_ratio_range, mdot_range, d_channel_range, num_channels_range, T_coolant_i_range, wall_t_range, k_wall_range};
% pc_range -> Pa to psi
ranges{1} = ranges{1} .* .000145038;
% mdot_range -> kgm/s to lbm/s
ranges{4} = ranges{4} .* 2.20462;
% d_channel_range -> m to mm
ranges{5} = ranges{5} .* 10.^3;
% T_coolant_i_range -> K to deg C
ranges{7} = ranges{7} - 273.15;
% wall_t_range -> m to mm
ranges{8} = ranges{8} .* 10.^3;
% dependent vars
% K to deg C
T_coolant_f = T_coolant_f - 273.15;
Twg = Twg - 273.15;
Twl = Twl - 273.15;
axial_temp_grad(2, :) = axial_temp_grad(2, :) - 273.15;
% m to in
dt = sqrt(At ./ pi .* 4) .* 39.3701;
de = sqrt(Ae ./ pi .* 4) .* 39.3701;
% m^3 to mm^3
Vc = Vc .* 1000.^3;
% m/s to ft/s
cstar = cstar .* 3.28084;
cstar_theo = cstar_theo .* 3.28084;
% N to lbf
thrust = thrust .* 0.224809;
% Pa to psi
P_coolant_min = P_coolant_min .* .000145038;
% dimensionless to %
eta_cstar = eta_cstar .* 100;
% Pa to MPa
therm_stress = therm_stress ./ 10.^6;
hoop_stress_doghouse = hoop_stress_doghouse ./ 10.^6;
hoop_stress_fins = hoop_stress_fins ./ 10.^6;
total_stress_doghouse = therm_stress + hoop_stress_doghouse;
total_stress_fins = therm_stress + hoop_stress_fins;
% Engine volume and contour info
% m to mm
r_engine = r_engine .* 10.^3;
z_engine = z_engine .* 10.^3;
% m^3 to mm^3
vol_engine = vol_engine .* 10.^9;

contourvalnames = ["vol_engine", "L_nozzle_parabolic", "Re", "thetaN", "xN", "R1", "R1p", "alpha", "L_chamber_circular_narrow", "Rc", "L_chamber_linear", "dt"];

% Export to mat file for use in app
save(filename_datastorage, "axial_temp_grad", "T_AlSi10Mg_melt", "T_w_max", "yieldstress_alloy", "yieldstress_max", "list_var_names", "ranges", "pc_range", "OF_range", "expansion_ratio_range", "mdot_range", "d_channel_range", "num_channels_range", "T_coolant_i_range", "wall_t_range", "k_wall_range", "therm_stress", "total_stress_doghouse", "total_stress_fins", "hoop_stress_doghouse", "hoop_stress_fins", "T_coolant_f", "P_coolant_min", "Twg", "Twl", "q", "Isp", "prop_cost_rate", "dt", "cstar", "cstar_theo", "thrust", "de", "eta_cstar", "Vc", "CR", "flow_sonic", "r_engine", "z_engine", "vol_engine", "L_nozzle_parabolic", "Re", "thetaN", "xN", "R1", "R1p", "alpha", "L_chamber_circular_narrow", "Rc", "L_chamber_linear", "contourvalnames", "TWR");


%% More complex functions

% Reshape summation arrays for vector size compatibility during
%   parallelization
function reshaped_summation_array = getReshapedSummationArray(summation_array, num_dimensions)
    reshaped_summation_array = reshape(summation_array, [ones(1, num_dimensions) numel(summation_array)]);
end

% For vaporization pressure calclulation to check coolant doesn't boil in
% coolant channels
% antoine equation (T in K) - source: NIST, pvapeth in Pa
function p_vap_eth = GetVaporizationPressure(T)

    % Only works for ethanol right now
    Tcrit_eth = 513.91;

    idxslw = T < 273.15;
    idxs1 = 273.15 <= T & T < 292.77;
    idxs2 = 292.77 <= T & T < 364.8;
    idxs3 = 364.8 <= T & T < Tcrit_eth;
    idxshgh = Tcrit_eth <= T;
    idxsvalid = idxs1 | idxs2 | idxs3;

    p_vap_eth = nan(size(T));
    A = p_vap_eth;
    B = p_vap_eth;
    C = p_vap_eth;

    A(idxs1) = 5.37229;
    B(idxs1) = 1670.409;
    C(idxs1) = -40.191;

    A(idxs2) = 5.24677;
    B(idxs2) = 1598.673;
    C(idxs2) = -46.424;

    A(idxs3) = 4.92531;
    B(idxs3) = 1432.526;
    C(idxs3) = -61.819;

    if any(idxslw)
        warning("some input T's too low in GetVaporizationPressure function");
    end
    if any(idxshgh)
        warning("some input T's above T crit eth");
    end

    % bar to Pa
    p_vap_eth(idxsvalid) = 10.^(A(idxsvalid) - B(idxsvalid) ./ (T(idxsvalid) + C(idxsvalid))) .* 10.^5;
end

% Calculates thermal resistance for different sections in the rocket
%   heat_transfer_type = "conduction", "forced convection", or "free
%       convection"
%   k = conductive heat transfer coefficient
%   h = convective heat transfer coefficient
%   r_0 = reference radius for which basis q_s_flux is defined
%   r_1 =
%       For conduction: starting radius
%       For convection: boundary radius
%   r_2 = ending radius
function TR = GetThermalResistance(args)

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
        eval(append(arg_name, " = args.(arg_name)"));
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

% Calculates k of an alloy
% alloy_name = name of alloy as a string
% T = temperature at which k is to be calculated (Kelvin)
function k = Getk(material_name, T)
    material_names = ["AlSi10Mg"];

    % Check input
    if ~contains(material_name, material_names)
        error("Invalid 'alloy_name' parameter: '%s'", material_name);
    end

    % K to deg C for data parsing
    T = T - 273.15;

    switch material_name
        case "AlSi10Mg"
            Ts = [0;
                  25;
                  200;
                  400;
                  10000];

            % Averaging values for horizontal direction for 99 % and 99.5 %
            %   densities
            ks = [(115 + 122) ./ 2;
                  (115 + 122) ./ 2;
                  (114 + 140) ./ 2;
                  (141 + 187) ./ 2;
                  (141 + 187) ./ 2];
    end

    % Linearly interpolate ks using T to get k
    k = interp1(Ts, ks, T);
end

% Calculates darcy friction factor (f) at different axial slices along
%   chamber
% ----------
function f = GetFrictionFactor(D, L, delta_p, rho, u_bar)
    f = D ./ L .* delta_p ./ (rho .* u_bar.^2 ./ 2);
end

% Calculates Nu_D at different axial slices along the chamber
% ----------
% ASSUMES turbulent flow
    % Check for:
    %   1) entrance region, OR
    %   2) fully-developed region
% ----------
% Nu_D = Nusselt number using tube diameter as characteristic length
% f = friction factor
% Re_D = Reynold's number using tube diameter as characteristic length
% Pr = Prandtl number
% D = tube diameter (m)
% L = tube length (m)
% x = position in tube relative to datum (m)
% ----------
function Nu_D = GetNu_D(args)
    
    % Allows arguments to be optional and instantiated in the function call
    %   like: functionname(<varname> = <value>, ...)
    arguments
        args.f = [];
        args.Re_D = [];
        args.Pr = [];
        args.D = [];
        args.L = [];
        args.x = [];
    end
    arg_name_list = fieldnames(args);

    % Makes variables out of args' fieldnames
    for i_fieldname = 1:length(arg_name_list)
        arg_name = arg_name_list{i_fieldname};
        eval(append(arg_name, " = args.(arg_name)"));
    end

    % Avoid divide by zero error if L = 0
    % Scale tol_low to D
    tol_low = .01 .* 2.5 .* D;
    if L == 0
        L = tol_low;
    end

    % Check if developing
    % Get entrance lengths
    x_fd_t_over_D = GetThermalEntryLength(Re_D, Pr);
    x_fd_h_over_D = GetHydrodynamicEntryLength(Re_D);

    x_over_D = x ./ D;
    
    % For vectorization, uses logical multi-dimensional array-indexing
    % Creates masks
    x_over_D_developing_mask = x_over_D < max(x_fd_t_over_D, ...
        x_fd_h_over_D);
    x_over_D_fully_developed_mask = ~ x_over_D_developing_mask;

    % Assigns values based on masks
    D_over_L = zeros(size(x_over_D_fully_developed_mask));
    D_over_L(x_over_D_developing_mask) = D ./ L;
    D_over_L(x_over_D_fully_developed_mask) = 0;

    % From: Heat Convection 2nd Ed. by Latif M. Jiji
    %   Page 404, Eq. (10.17) (Gnielinski correlation)
    Nu_D = ((f ./ 8) .* (Re_D - 1000) .* Pr) ./ (1 + 12.7 .* ...
        sqrt((f ./ 8)) .* (Pr.^(2 ./ 3) - 1)) .* (1 + D_over_L.^(2 ./ 3));
end

% Calculates h for different sections in the rocket (W/m^2-K)
% ----------
% Nu_D = Nusselt number using tube diameter as the characteristic length
% D = tube hydraulic diameter (m)
% k = thermal conductivity (W/m-K)
% ----------
% Vectorized
function h = Geth(Nu_D, D, k)
    h = Nu_D .* k ./ D;
end

% Internal flow thermal entry length (nondimensionalized)
% From: Introduction to Heat Transfer 3rd Ed. by Incropera and DeWitt
%   Page 393, Eq. (8.23)
% in x_fd_t_over_D:
%   x = axial distance from datum
%   fd = fully developed
%   t = thermal
%   D = diameter of tube (for nondimensionalization)
function x_fd_t_over_D = GetThermalEntryLength(Re_D, Pr)

    % Determine if flow is laminar or turbulent
    % Not vectorized
    Re_D_transition = 2300;
    if Re_D <= Re_D_transition

        x_fd_t_over_D = .05 .* Re_D .* Pr;
    else
        % From Fundamentals of Thermal Fluid Sciences by Cengel and Turner
        %   Page 760, Eq. (17-42)
        %   in L_t_t:
        %       L = length
        %       t_t = thermal_turbulent
        %   I slightly rearranged it to exclude D so that it would be a
        %       nondimensionalized value
        L_t_t = 4.4 .* D .* Re_D.^(1 ./ 6);
        x_fd_t_over_D = L_t_t;
    end
end

% Internal flow hydrodynamic entry length (nondimensionalized)
% From: Introduction to Heat Transfer 3rd Ed. by Incropera and DeWitt
%   Page 389, Eq. (8.3)
% in x_fd_h_over_D:
%   x = axial distance from datum
%   fd = fully developed
%   h = hydrodynamic
%   D = diameter of tube (for nondimensionalization)
function x_fd_h_over_D = GetHydrodynamicEntryLength(Re_D)
    
    % Determine if flow is laminar or turbulent
    % Not vectorized
    Re_D_transition = 2300;
    if Re_D <= Re_D_transition

        x_fd_h_over_D = .05 .* Re_D;
    else
        % From Fundamentals of Thermal Fluid Sciences by Cengel and Turner
        %   Page 760, Eq. (17-42)
        %   in L_h_t:
        %       L = length
        %       h_t = hydrodynamic_turbulent
        %   I slightly rearranged it to exclude D so that it would be a
        %       nondimensionalized value
        L_h_t = 4.4 .* Re_D.^(1 ./ 6);
        x_fd_h_over_D = L_h_t;
    end
end

% Assuming material is AlSi10Mg
% Vectorized
% temp is Twg, hot wall temperature, in Kelvin
% Output is in MPa
function yieldStress = getYieldStress(temp)
    % Data sheet on material properties for AlSi10Mg - https://fathommfg.com/wp-content/uploads/2020/11/EOS_Aluminium_AlSi10Mg_en.pdf
    % MPa to Pa (270 +- 10) - heat treated would be 245, 230 +- 15
    
    % Also got these tabulated value from:
    % "The variation of the yield stress vs temperature for experimented materials"

    % K to deg C
    temp = temp - 273.15;
    % deg C, MPa
    % Also adding really high value just to avoid having to fix the NaN
    %   error returned by interp1 when you feed it a value outside of the x
    %   range
    temps = [0;
             150;
             250;
             350;
             450;
             10000];
    stresses = [280;
                280;
                210;
                135;
                65;
                65];
    yieldStress = interp1(temps, stresses, temp);
end

% Bartz Correlation from Huzel and Huang
% D_t: throat diameter, in
% mu: viscosity, lbm/ft-sec
% C_p: gas specifict heat capacity at constant pressure, Btu/lbm-degF
% Pr: Prandtl number
% p_c_ns: chamber pressure at this nozzle station, lbf/in^2
% g: gravitational acceleration, ft/s^2
% cstar: characteristic velocity, ft/s
% R: curvature of circular portion of the nozzle, in
% At: throat area
% A: area at this nozzle stations
% sigma: "Correction factor for property variations across boundary layer"
function Bartz_hg = fGetBartzhg()
    (.026 ./ dt.^.2 * (mu_flow_t.^.2 .* cp_flow_t ./ Pr_flow_t.^.6) .* (pc_t .* g ./ squeeze(cstar(i_pc, i_OF, i_eps, :, :, :, :, :, :))).^.8 .* (dt ./ squeeze(R1(i_pc, i_OF, i_eps, :, :, :, :, :, :))))
end