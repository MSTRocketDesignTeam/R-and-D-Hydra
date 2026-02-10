classdef SCRIPTVERSIONregenEngineTradesViewer < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        TabGroupmain                   matlab.ui.container.TabGroup
        AutomateTradeStudyTab          matlab.ui.container.Tab
        cstarPanel                     matlab.ui.container.Panel
        knobcstar                      matlab.ui.control.DiscreteKnob
        Priority1highestKnob_15Label   matlab.ui.control.Label
        PreferenceSwitchcstar          matlab.ui.control.Switch
        PreferenceSwitch_15Label       matlab.ui.control.Label
        Lampcstar                      matlab.ui.control.Lamp
        Switchcstar                    matlab.ui.control.ToggleSwitch
        TWRPanel                       matlab.ui.container.Panel
        knobTWR                        matlab.ui.control.DiscreteKnob
        Priority1highestKnob_14Label   matlab.ui.control.Label
        PreferenceSwitchTWR            matlab.ui.control.Switch
        PreferenceSwitch_14Label       matlab.ui.control.Label
        LampTWR                        matlab.ui.control.Lamp
        SwitchTWR                      matlab.ui.control.ToggleSwitch
        eta_cstarPanel                 matlab.ui.container.Panel
        knobeta_cstar                  matlab.ui.control.DiscreteKnob
        Priority1highestKnob_13Label   matlab.ui.control.Label
        PreferenceSwitcheta_cstar      matlab.ui.control.Switch
        PreferenceSwitch_13Label       matlab.ui.control.Label
        Lampeta_cstar                  matlab.ui.control.Lamp
        Switcheta_cstar                matlab.ui.control.ToggleSwitch
        prop_cost_ratePanel                 matlab.ui.container.Panel
        knobprop_cost_rate                  matlab.ui.control.DiscreteKnob
        Priority1highestKnob_12Label   matlab.ui.control.Label
        PreferenceSwitchprop_cost_rate      matlab.ui.control.Switch
        PreferenceSwitch_12Label       matlab.ui.control.Label
        Lampprop_cost_rate                  matlab.ui.control.Lamp
        Switchprop_cost_rate                matlab.ui.control.ToggleSwitch
        dePanel                        matlab.ui.container.Panel
        knobde                         matlab.ui.control.DiscreteKnob
        Priority1highestKnob_11Label   matlab.ui.control.Label
        PreferenceSwitchde             matlab.ui.control.Switch
        PreferenceSwitch_11Label       matlab.ui.control.Label
        Lampde                         matlab.ui.control.Lamp
        Switchde                       matlab.ui.control.ToggleSwitch
        dtPanel                        matlab.ui.container.Panel
        knobdt                         matlab.ui.control.DiscreteKnob
        Priority1highestKnob_10Label   matlab.ui.control.Label
        PreferenceSwitchdt             matlab.ui.control.Switch
        PreferenceSwitch_10Label       matlab.ui.control.Label
        Lampdt                         matlab.ui.control.Lamp
        Switchdt                       matlab.ui.control.ToggleSwitch
        thrustPanel                    matlab.ui.container.Panel
        knobthrust                     matlab.ui.control.DiscreteKnob
        Priority1highestKnob_9Label    matlab.ui.control.Label
        PreferenceSwitchthrust         matlab.ui.control.Switch
        PreferenceSwitch_9Label        matlab.ui.control.Label
        Lampthrust                     matlab.ui.control.Lamp
        Switchthrust                   matlab.ui.control.ToggleSwitch
        T_coolant_fPanel               matlab.ui.container.Panel
        knobT_coolant_f                matlab.ui.control.DiscreteKnob
        Priority1highestKnob_8Label    matlab.ui.control.Label
        PreferenceSwitchT_coolant_f    matlab.ui.control.Switch
        PreferenceSwitch_8Label        matlab.ui.control.Label
        LampT_coolant_f                matlab.ui.control.Lamp
        SwitchT_coolant_f              matlab.ui.control.ToggleSwitch
        IspPanel                       matlab.ui.container.Panel
        knobIsp                        matlab.ui.control.DiscreteKnob
        Priority1highestKnob_7Label    matlab.ui.control.Label
        PreferenceSwitchIsp            matlab.ui.control.Switch
        PreferenceSwitch_7Label        matlab.ui.control.Label
        LampIsp                        matlab.ui.control.Lamp
        SwitchIsp                      matlab.ui.control.ToggleSwitch
        P_coolant_minPanel             matlab.ui.container.Panel
        knobP_coolant_min              matlab.ui.control.DiscreteKnob
        Priority1highestKnob_6Label    matlab.ui.control.Label
        PreferenceSwitchP_coolant_min  matlab.ui.control.Switch
        PreferenceSwitch_6Label        matlab.ui.control.Label
        LampP_coolant_min              matlab.ui.control.Lamp
        SwitchP_coolant_min            matlab.ui.control.ToggleSwitch
        hoop_stress_doghousePanel      matlab.ui.container.Panel
        knobhoop_stress_doghouse       matlab.ui.control.DiscreteKnob
        Priority1highestKnob_5Label    matlab.ui.control.Label
        PreferenceSwitchhoop_stress_doghouse    matlab.ui.control.Switch
        PreferenceSwitch_5Label        matlab.ui.control.Label
        Lamphoop_stress_doghouse       matlab.ui.control.Lamp
        Switchhoop_stress_doghouse     matlab.ui.control.ToggleSwitch
        TwgPanel                       matlab.ui.container.Panel
        knobTwg                        matlab.ui.control.DiscreteKnob
        Priority1highestKnob_4Label    matlab.ui.control.Label
        PreferenceSwitchTwg            matlab.ui.control.Switch
        PreferenceSwitch_4Label        matlab.ui.control.Label
        LampTwg                        matlab.ui.control.Lamp
        SwitchTwg                      matlab.ui.control.ToggleSwitch
        total_stress_doghousePanel     matlab.ui.container.Panel
        knobtotal_stress_doghouse      matlab.ui.control.DiscreteKnob
        Priority1highestKnob_3Label    matlab.ui.control.Label
        PreferenceSwitchtotal_stress_doghouse matlab.ui.control.Switch
        PreferenceSwitch_3Label        matlab.ui.control.Label
        Lamptotal_stress_doghouse      matlab.ui.control.Lamp
        Switchtotal_stress_doghouse    matlab.ui.control.ToggleSwitch
        therm_stressPanel               matlab.ui.container.Panel
        knobtherm_stress                matlab.ui.control.DiscreteKnob
        Priority1highestKnobLabel      matlab.ui.control.Label
        PreferenceSwitchtherm_stress    matlab.ui.control.Switch
        PreferenceSwitchLabel          matlab.ui.control.Label
        Lamptherm_stress                matlab.ui.control.Lamp
        Switchtherm_stress              matlab.ui.control.ToggleSwitch
        DataTab                        matlab.ui.container.Tab
        RunningLamp                    matlab.ui.control.Lamp
        RunningLampLabel               matlab.ui.control.Label
        EditFielddt                    matlab.ui.control.NumericEditField
        Volumemm3Label_12              matlab.ui.control.Label
        EditFieldL_chamber_linear      matlab.ui.control.NumericEditField
        Volumemm3Label_11              matlab.ui.control.Label
        EditFieldRc                    matlab.ui.control.NumericEditField
        Volumemm3Label_10              matlab.ui.control.Label
        EditFieldL_chamber_circular_narrow  matlab.ui.control.NumericEditField
        Volumemm3Label_9               matlab.ui.control.Label
        EditFieldalpha                 matlab.ui.control.NumericEditField
        Volumemm3Label_8               matlab.ui.control.Label
        EditFieldR1p                   matlab.ui.control.NumericEditField
        Volumemm3Label_7               matlab.ui.control.Label
        EditFieldR1                    matlab.ui.control.NumericEditField
        Volumemm3Label_6               matlab.ui.control.Label
        EditFieldxN                    matlab.ui.control.NumericEditField
        Volumemm3Label_5               matlab.ui.control.Label
        EditFieldthetaN                matlab.ui.control.NumericEditField
        Volumemm3Label_4               matlab.ui.control.Label
        EditFieldRe                    matlab.ui.control.NumericEditField
        Volumemm3Label_3               matlab.ui.control.Label
        EditFieldL_nozzle_parabolic    matlab.ui.control.NumericEditField
        Volumemm3Label_2               matlab.ui.control.Label
        EditFieldvol_engine            matlab.ui.control.NumericEditField
        Volumemm3Label                 matlab.ui.control.Label
        num_channelsSliderLabel        matlab.ui.control.Label
        Slidernum_channels             matlab.ui.control.Slider
        Sliderk_wall                   matlab.ui.control.Slider
        k_wallWmKLabel                 matlab.ui.control.Label
        Sliderwall_t                    matlab.ui.control.Slider
        wall_thicknessmmSliderLabel     matlab.ui.control.Label
        Slidermdot                     matlab.ui.control.Slider
        dtmmLabel                      matlab.ui.control.Label
        SliderT_coolant_i                matlab.ui.control.Slider
        T_coolant_idegCSlider_2Label     matlab.ui.control.Label
        Sliderexpansion_ratio          matlab.ui.control.Slider
        expansionratioSliderLabel      matlab.ui.control.Label
        SliderOF                       matlab.ui.control.Slider
        OFSliderLabel                  matlab.ui.control.Label
        Sliderd_channel                matlab.ui.control.Slider
        d_channelmmSliderLabel         matlab.ui.control.Label
        Sliderpc_c                       matlab.ui.control.Slider
        pc_cpsiSliderLabel               matlab.ui.control.Label
        yaxisDropDown                  matlab.ui.control.DropDown
        yaxisDropDownLabel             matlab.ui.control.Label
        UIAxespc_c                       matlab.ui.control.UIAxes
        UIAxesd_channel                matlab.ui.control.UIAxes
        UIAxesOF                       matlab.ui.control.UIAxes
        UIAxesnum_channels             matlab.ui.control.UIAxes
        UIAxesexpansion_ratio          matlab.ui.control.UIAxes
        UIAxesT_coolant_i                matlab.ui.control.UIAxes
        UIAxesmdot                     matlab.ui.control.UIAxes
        UIAxeswall_t                    matlab.ui.control.UIAxes
        UIAxesk_wall                   matlab.ui.control.UIAxes
        ShowthermallimitsButton        matlab.ui.control.StateButton
        TabGroup                       matlab.ui.container.TabGroup
        viewofwholeengineTab           matlab.ui.container.Tab
        UIAxesview_of_whole_engine     matlab.ui.control.UIAxes
        viewofthroatTab                matlab.ui.container.Tab
        UIAxesview_of_throat           matlab.ui.control.UIAxes
    end


    % Public properties that correspond to the Simulink model
    properties (Access = public, Transient)
        Simulation simulink.Simulation
    end

    methods (Access = public)
        function fRefreshPlots(app, yaxisname)
            % Green
            app.RunningLamp.Color = [0, 1, 0];
            drawnow;
            % For debugging
            disp("Refreshing plots");
            
            % Assume regenEngineTradesCalculator.m is in same folder
            load("regenEngineTradesData.mat");

            % To avoid floating point errors
            tol_low = 1E-12;

            % for showing extra thermal stress data, like limits
            boolextrathermals = app.ShowthermallimitsButton.Value;

            %% Plot data on graphs
            % Go through every graph
            for i_var = 1:length(list_var_names)
                var_name = list_var_names(i_var);
                app.("UIAxes" + var_name).ColorOrder = [0, 0, 1; 1, 0.8, 0; 1, 0, 0];
                y_vals = eval(yaxisname);

                y_vals_indices = ones(1, length(list_var_names));
                y_vals_indices = num2cell(y_vals_indices);
                % Finds indices of data arrays we want to navigate to,
                % based on what the sliders are currently set to
                for i_i = 1:length(y_vals_indices)
                    y_vals_indices{i_i} = find(abs(ranges{i_i} - (app.("Slider" + list_var_names(i_i)).Value)) <= tol_low, 1);
                end

                % For each graph, make sure the variable corresponding to
                % that graph is varied, not a constant. So include the
                % entire range
                y_vals_indices{i_var} = 1:length(ranges{i_var});

                % Grab the slice of the data those indices point to
                if ~strcmp(yaxisname, "axial_temp_grad")
                    y_vals = squeeze(y_vals(y_vals_indices{:}));
                else
                    y_vals = axial_temp_grad;
                end
                % Fixes weird MATLAB quirk where when squeezing everything
                %   but the second dimension of an ndarray, the resultant
                %   is a row vector. But, I want col vectors for the
                %   following switch case
                if i_var == 2
                    y_vals = y_vals(:);
                end

                % Show extra data for some data, like limits or comparable
                % values
                switch yaxisname
                    case "therm_stress"
                        if boolextrathermals
                            y_vals(:, 2) = squeeze(yieldstress_max(y_vals_indices{:}));
                            y_vals(:, 3) = squeeze(yieldstress_alloy(y_vals_indices{:}));
                        end
                    case "hoop_stress_doghouse"
                        if boolextrathermals
                            y_vals(:, 2) = squeeze(yieldstress_max(y_vals_indices{:}));
                            y_vals(:, 3) = squeeze(yieldstress_alloy(y_vals_indices{:}));
                        end
                    case "hoop_stress_fins"
                        if boolextrathermals
                            y_vals(:, 2) = squeeze(yieldstress_max(y_vals_indices{:}));
                            y_vals(:, 3) = squeeze(yieldstress_alloy(y_vals_indices{:}));
                        end
                    case "total_stress_doghouse"
                        if boolextrathermals
                            y_vals(:, 2) = squeeze(yieldstress_max(y_vals_indices{:}));
                            y_vals(:, 3) = squeeze(yieldstress_alloy(y_vals_indices{:}));
                        end
                    case "total_stress_fins"
                        if boolextrathermals
                            y_vals(:, 2) = squeeze(yieldstress_max(y_vals_indices{:}));
                            y_vals(:, 3) = squeeze(yieldstress_alloy(y_vals_indices{:}));
                        end
                    case "Twg"
                        if boolextrathermals
                            y_vals(:, 2) = T_w_max;
                            y_vals(:, 3) = T_AlSi10Mg_melt;
                        end
                    case "P_coolant_min"
                        % if not "varying pc_c" graph
                        % if i_var ~= 1
                        y_vals(:, 2) = app.("Slider" + list_var_names(i_i)).Value;
                        % end
                end
                try
                    if ~strcmp(yaxisname, "axial_temp_grad")
                        plot(eval("app.UIAxes" + var_name), ranges{i_var}, y_vals);
                    else
                        plot(eval("app.UIAxes" + var_name), axial_temp_grad(1, :), axial_temp_grad(2, :));
                    end

                    legend(eval("app.UIAxes" + var_name), "off");
                catch
                    error("Couldn't plot, likely problem with y_vals");
                end
            end

            % Legend handling for plots with more than one y range
            switch yaxisname
                case "therm_stress"
                    if boolextrathermals
                        for i_var = 1:length(list_var_names)
                            var_name = list_var_names(i_var);
                            legend(eval("app.UIAxes" + var_name), "thermal stress", "max allowable stress", "alloy yield stress");
                        end
                    end
                case "hoop_stress_doghouse"
                    if boolextrathermals
                        for i_var = 1:length(list_var_names)
                            var_name = list_var_names(i_var);
                            legend(eval("app.UIAxes" + var_name), "hoop stress (doghouse)", "max allowable stress", "alloy yield stress");
                        end
                    end
                case "hoop_stress_fins"
                    if boolextrathermals
                        for i_var = 1:length(list_var_names)
                            var_name = list_var_names(i_var);
                            legend(eval("app.UIAxes" + var_name), "hoop stress (fins)", "max allowable stress", "alloy yield stress");
                        end
                    end
                case "total_stress_doghouse"
                    if boolextrathermals
                        for i_var = 1:length(list_var_names)
                            var_name = list_var_names(i_var);
                            legend(eval("app.UIAxes" + var_name), "total stress (doghouse)", "max allowable stress", "alloy yield stress");
                        end
                    end
                case "total_stress_fins"
                    if boolextrathermals
                        for i_var = 1:length(list_var_names)
                            var_name = list_var_names(i_var);
                            legend(eval("app.UIAxes" + var_name), "total stress (fins)", "max allowable stress", "alloy yield stress");
                        end
                    end
                case "Twg"
                    if boolextrathermals
                        for i_var = 1:length(list_var_names)
                            var_name = list_var_names(i_var);
                            legend(eval("app.UIAxes" + var_name), "hot-side hot wall temp", "max allowable temp", "alloy melt temp");
                        end
                    end
                case "P_coolant_min"
                    for i_var = 1:length(list_var_names)
                        % if not "varying pc_c" graph, show how min. required
                        % coolant press compares to specified chamber press
                        % if i_var ~= 1
                        var_name = list_var_names(i_var);
                        legend(eval("app.UIAxes" + var_name), "min allowable coolant press", "pc_c");
                        % end
                    end
            end

            %% Display contour data
            data_indices = ones(1, length(list_var_names));
            data_indices = num2cell(data_indices);
            for i_i = 1:length(data_indices)
                data_indices{i_i} = find(abs(ranges{i_i} - (app.("Slider" + list_var_names(i_i)).Value)) <= tol_low, 1);
            end

            % Convert to mm scale
            % vol_engine already in mm^3
            vol_engine = squeeze(vol_engine(data_indices{:}));
            % m to mm
            L_nozzle_parabolic = squeeze(L_nozzle_parabolic(data_indices{:})) .* 10.^3;
            % m to mm
            Re = squeeze(Re(data_indices{:})) .* 10.^3;
            % rad to deg
            thetaN = squeeze(thetaN(data_indices{:})) .* 180 ./ pi;
            % m to mm
            xN = squeeze(xN(data_indices{:})) .* 10.^3;
            % m to mm
            R1 = squeeze(R1(data_indices{:})) .* 10.^3;
            % m to mm
            R1p = squeeze(R1p(data_indices{:})) .* 10.^3;
            % rad to deg
            alpha = squeeze(alpha(data_indices{:})) .* 180 ./ pi;
            % m to mm
            L_chamber_circular_narrow = squeeze(L_chamber_circular_narrow(data_indices{:})) .* 10.^3;
            % m to mm
            Rc  = squeeze(Rc(data_indices{:})) .* 10.^3;
            % m to mm
            L_chamber_linear = squeeze(L_chamber_linear(data_indices{:})) .* 10.^3;
            % in to mm
            dt = squeeze(dt(data_indices{:})) .* 25.4;

            for icv = 1:length(contourvalnames)
                app.("EditField" + contourvalnames(icv)).Value = eval(contourvalnames(icv));
            end

            %% Now show throat view
            num_channels = app.Slidernum_channels.Value;
            wall_t = app.Sliderwall_t.Value;
            
            cla(app.UIAxesview_of_throat);
            hold(app.UIAxesview_of_throat, "on");
            axis(app.UIAxesview_of_throat, "equal");
        
            % ===== CIRCLE =====
            R = dt ./ 2;
            theta = linspace(0, 2 .* pi, 500);
            plot(app.UIAxesview_of_throat, R*cos(theta), R*sin(theta), 'b', 'LineWidth', 2);
        
            % ===== CHANNEL SHAPE DEFINITION =====
            % Shape is a square
            side = app.Sliderd_channel.Value;  % square side length
        
            % Channel vertices (in clockwise order)
            baseLeft   = [-side/2, 0];
            baseRight  = [ side/2, 0];
            topRight   = [ side/2, side];
            topLeft    = [-side/2, side];
        
            houseShape = [ baseLeft;
                           baseRight;
                           topRight;
                           topLeft;
                           baseLeft ]; % close polygon

            % ----- ROTATE SHAPE 90° TO THE RIGHT -----
            % Seems unnecessary because it's a square, but if this is
            %   removed, the rotation matrix in the for loop below would
            %   need to be adjusted, because then it won't place the
            %   channels right in the wall
            rot90cw = [0 1; -1 0];
            houseShape = (rot90cw * houseShape.').';
        
            % ===== PLACE CHANNELS AROUND CIRCLE =====
            for k = 1:num_channels
                % Angle for this channel
                ang = (k-1) * 2*pi/num_channels;
        
                % Distance from origin to base of the shape
                r_place = R + wall_t;
        
                % Translation to position the **base midpoint** at correct location
                base_mid = [0, 0]; % in local coords, base is centered at origin
                target = r_place * [cos(ang), sin(ang)];
        
                % Rotation matrix so the shape points radially outward
                Rmat = [cos(ang), -sin(ang);
                        sin(ang),  cos(ang)];
        
                % Apply rotation and translation
                transformed = (Rmat * (houseShape - base_mid)').' + target;
        
                % Plot channel
                plot(app.UIAxesview_of_throat, transformed(:,1), transformed(:,2), 'b', 'LineWidth', 1.5);
            end

            % Outer wall
            outerWallRadius = R + 2 .* wall_t + side;   % channel height = 2*side
            plot(app.UIAxesview_of_throat, outerWallRadius*cos(theta), outerWallRadius*sin(theta), 'b', 'LineWidth', 2);

            %% Now show perspetive view of engine
            ax = app.UIAxesview_of_whole_engine;
            thetaarray = linspace(0, 2 .* pi, size(z_engine, ndims(z_engine)));

            % Graph
            ztograph = squeeze(z_engine(data_indices{:}, :));
            [thetatograph, ztograph] = meshgrid(thetaarray, ztograph);
            rtograph = repmat(squeeze(r_engine(data_indices{:}, :)), 1, length(thetaarray));
            xtograph = rtograph .* cos(thetatograph);
            ytograph = rtograph .* sin(thetatograph);
            surf(ax, xtograph, ytograph, ztograph, 'FaceColor', [0.7 0.7 0.7], 'EdgeColor', 'none');

            % Corner perspective and nice graph stuff
            view(ax, 45, 30);
            camlight(ax);
            lighting(ax, 'gouraud');
            axis(ax, "equal");

            %% Normally have to refresh figure after all that
            % Red
            app.RunningLamp.Color = [1, 0, 0];
            drawnow;
        end
        
        function snapSlider(app, slidername)
            val = app.(slidername).Value;
            mjrs = app.(slidername).MajorTicks;
            idx2 = find(mjrs > val, 1);
            if isempty(idx2)
                idx2 = length(mjrs);
            end
            idx1 = idx2 - 1;
            dif2 = abs(mjrs(idx2) - val);
            dif1 = abs(mjrs(idx1) - val);
            if dif2 <= dif1
                val = mjrs(idx2);
            else
                val = mjrs(idx1);
            end

            app.(slidername).Value = val;
        end
        
        function updateAutoTrade(app, varName)
            prefSwitchName = append("PreferenceSwitch", varName);
            val = app.(prefSwitchName).Value;
            if strcmp("No", val)
                % Red
                boolauto = 0;
                clr = [1, 0, 0];
            else
                % Green
                boolauto = 1;
                clr = [0, 1, 0];
            end
            lampName = append("Lamp", varName);
            app.(lampName).Color = clr;

            % Load priorities to adjust them and the panel settings
            filenamePriorities = append(pwd, "\autoTradePriorities.mat");
            load(filenamePriorities);
            % Loads:    allVarPriorities
            %           countPrioritizedVars
            idxthisvar = find(strcmp([allVarPriorities{1, :}], varName), 1);
            knobname = append("knob", varName);
            switchname = append("Switch", varName);
            oldpriority = allVarPriorities{2, idxthisvar};
            newpriority = str2double(app.(knobname).Value);
            if boolauto
                % Var is now or was already prioritized
                if allVarPriorities{2, idxthisvar} == 0
                    % Var was not already prioritized, give last priority
                    %   in new ranking
                    % Also enable features
                    app.(knobname).Enable = "on";
                    app.(switchname).Enable = "on";
                    newpriority = max([allVarPriorities{2, :}]) + 1;
                    allVarPriorities{2, idxthisvar} = newpriority;
                    countPrioritizedVars = countPrioritizedVars + 1;
                    % Go through all knobs and change items
                    if countPrioritizedVars == 0
                        newItemsOn = {'0', '0'};
                        newItemsOff = newItemsOn;
                    elseif countPrioritizedVars == 1
                        newItemsOn = {'0', '1'};
                        newItemsOff = newItemsOn;
                    else % Can't be negative, must be 1-size(allVarPrioritizes{1, :}, 1)
                        newItemsOn = cell(1, countPrioritizedVars);
                        newItemsOff = cell(1, countPrioritizedVars + 1);
                        for ipriorvar = 0:countPrioritizedVars
                            if ipriorvar > 0
                                newItemsOn{1, ipriorvar} = char(string(ipriorvar));
                            end
                            newItemsOff{1, ipriorvar + 1} = char(string(ipriorvar));
                        end
                    end
                    for iknob = 1:size(allVarPriorities, 2)
                        thisknobname = append("knob", allVarPriorities{1, iknob});
                        if allVarPriorities{2, iknob} == 0
                            % This var is not prioritized, should get
                            %   0-inclusive newItems cell array
                            %   (newItemsOff)
                            app.(thisknobname).Items = newItemsOff;
                        else
                            app.(thisknobname).Items = newItemsOn;
                        end
                    end
                else
                    % Var was already prioritized
                    if  newpriority ~= oldpriority
                        % Priority value changed
                        % Swap priority values with var that already had
                        %   that priority value to avoid dupes
                        idxtoswapwith = find([allVarPriorities{2, :}] == newpriority);
                        allVarPriorities{2, idxthisvar} = newpriority;
                        allVarPriorities{2, idxtoswapwith} = oldpriority;
                        knobnameswap = append("knob", allVarPriorities{1, idxtoswapwith});
                        app.(knobnameswap).Value = char(string(oldpriority));
                    else
                        % Priority didn't change, do nothing
                    end
                end
            else
                % Var is now NOT or was already NOT prioritized
                if allVarPriorities{2, idxthisvar} ~= 0
                    % Var was prioritized, needs to be unprioritized
                    % Move lower priorities up 1, which means their
                    %   numbers actually decrease 1
                    idxslwrs = find([allVarPriorities{2, :}] > newpriority, size(allVarPriorities, 2));
                    for idxlwr = idxslwrs
                        thisoldpriority = allVarPriorities{2, idxlwr};
                        thisnewpriority = thisoldpriority - 1;
                        thisknobname = append("knob", allVarPriorities{1, idxlwr});
                        allVarPriorities{2, idxlwr} = thisnewpriority;
                        app.(thisknobname).Value = char(string(thisnewpriority));
                    end
                    countPrioritizedVars = countPrioritizedVars - 1;
                    allVarPriorities{2, idxthisvar} = 0;
                    newpriority = 0;
                    % Go through all knobs and change items
                    if countPrioritizedVars == 0
                        newItemsOn = {'0', '0'};
                        newItemsOff = newItemsOn;
                    elseif countPrioritizedVars == 1
                        newItemsOn = {'0', '1'};
                        newItemsOff = newItemsOn;
                    else % Can't be negative, must be 1-size(allVarPrioritizes{1, :}, 1)
                        newItemsOn = cell(1, countPrioritizedVars);
                        newItemsOff = cell(1, countPrioritizedVars + 1);
                        for ipriorvar = 0:countPrioritizedVars
                            if ipriorvar > 0
                                newItemsOn{1, ipriorvar} = char(string(ipriorvar));
                            end
                            newItemsOff{1, ipriorvar + 1} = char(string(ipriorvar));
                        end
                    end
                    for iknob = 1:size(allVarPriorities, 2)
                        thisknobname = append("knob", allVarPriorities{1, iknob});
                        if allVarPriorities{2, iknob} == 0
                            % This var is not prioritized, should get
                            %   0-inclusive newItems cell array
                            %   (newItemsOff)
                            app.(thisknobname).Items = newItemsOff;
                        else
                            app.(thisknobname).Items = newItemsOn;
                        end
                    end
                    % Also disable features
                    app.(knobname).Enable = "off";
                    app.(switchname).Enable = "off";
                else
                    % Var was already NOT prioritized, do nothing
                end
            end
            app.(knobname).Value = char(string(newpriority));
            % Check for "Min" or "Max" change
            oldminormax = allVarPriorities{3, idxthisvar};
            newminormax = app.(switchname).Value;
            if ~strcmp(oldminormax, newminormax)
                % "Min" or "Max" changed, update
                allVarPriorities{3, idxthisvar} = newminormax;
            else
                % Nothing changed, do nothing
            end
            save(filenamePriorities, "allVarPriorities", "countPrioritizedVars");
        end
    end

    % Callbacks that handle component events
    methods (Access = public)

        % Code that executes after component creation
        function startupFcn(app)
            clc
            
            % Assume file is in same folder
            load("regenEngineTradesData.mat");
            app.yaxisDropDown.Items = ["therm_stress (MPa)", "axial_temp_grad (deg C)", "hoop_stress_doghouse (MPa)", "hoop_stress_fins (MPa)", "total_stress_doghouse (MPa)", "total_stress_fins (MPa)", "vol_engine (mm^3)", "Twg (deg C)", "T_coolant_f (deg C)", "P_coolant_min (psi)", "Isp (s)", "thrust (lbf)", "prop_cost_rate ($)", "dt (in)", "de (in)", "cstar (ft/s)", "eta_cstar (%)", "TWR"];

            % Still WIP - should probably some day be updated to not be
            %   recalculated every app use
            % Gets cell array of all var names
            filenamePriorities = append(pwd, "\autoTradePriorities.mat");
            allVarPriorities = cell(3, length(app.yaxisDropDown.Items));
            % Format will be {[varNames]; [priority numbers]; ["Min"/"Max"]}
            for ivarname = 1:length(allVarPriorities)
                allVarPriorities{1, ivarname} = string(app.yaxisDropDown.Items{ivarname});
                thisvarname = split(allVarPriorities{1, ivarname}, " ");
                thisvarname = thisvarname(1);
                allVarPriorities{1, ivarname} = thisvarname;
                % Put priorities at 0 at first
                allVarPriorities{2, ivarname} = 0;
                % Put each at "Min" at first
                allVarPriorities{3, ivarname} = "Min";
            end
            % 0 on startup
            countPrioritizedVars = 0;
            save(filenamePriorities, "allVarPriorities", "countPrioritizedVars");

            for i_var = 1:length(list_var_names)
                try
                    varname = list_var_names(i_var);
                    axesname = "UIAxes" + varname;
                    axesobj = app.(axesname);
                    slidername = "Slider" + varname;
                    sliderobj = app.(slidername);
                    sliderobj.Limits = [ranges{i_var}(1), ranges{i_var}(end)];
                    sliderobj.MajorTicks = ranges{i_var};
                catch
                    if exist(varname, "var")
                        error("Couldn't initiate app for %s data\nrange: %f", varname, ranges{i_var});
                    else
                        error("Couldn't initiate varname %d in app startup", i_var);
                    end
                end
            end

            % Initial plots
            yaxisname = split(string(app.yaxisDropDown.Items(1)), " ");
            yaxisname = yaxisname(1);
            fRefreshPlots(app, yaxisname)
        end

        % Value changed function: yaxisDropDown
        function yaxisDropDownValueChanged(app, event)
            yaxisname = split(string(app.yaxisDropDown.Value), " ");
            yaxisname = yaxisname(1);
            
            % Refresh Plots
            fRefreshPlots(app, yaxisname);
        end

        % Value changed function: Sliderpc_c
        function Sliderpc_cValueChanged(app, event)
            snapSlider(app, "Sliderpc_c");
            yaxisDropDownValueChanged(app, event);
        end

        % Value changed function: SliderOF
        function SliderOFValueChanged(app, event)
            snapSlider(app, "SliderOF");
            yaxisDropDownValueChanged(app, event);
        end

        % Value changed function: Sliderexpansion_ratio
        function Sliderexpansion_ratioValueChanged(app, event)
            snapSlider(app, "Sliderexpansion_ratio");
            yaxisDropDownValueChanged(app, event);
        end

        % Value changed function: Slidermdot
        function SlidermdotValueChanged(app, event)
            snapSlider(app, "Slidermdot");
            yaxisDropDownValueChanged(app, event);
        end

        % Callback function
        function Slidereta_cstarValueChanged(app, event)
            snapSlider(app, "Slidereta_cstar");
            yaxisDropDownValueChanged(app, event);
        end

        % Value changed function: Sliderd_channel
        function Sliderd_channelValueChanged(app, event)
            snapSlider(app, "Sliderd_channel");
            yaxisDropDownValueChanged(app, event);
        end

        % Value changed function: Slidernum_channels
        function Slidernum_channelsValueChanged(app, event)
            snapSlider(app, "Slidernum_channels");
            yaxisDropDownValueChanged(app, event);
        end

        % Value changed function: SliderT_coolant_i
        function SliderT_coolant_iValueChanged(app, event)
            snapSlider(app, "SliderT_coolant_i");
            yaxisDropDownValueChanged(app, event);
        end

        % Value changed function: Sliderwall_t
        function Sliderwall_tValueChanged(app, event)
            snapSlider(app, "Sliderwall_t");
            yaxisDropDownValueChanged(app, event);
        end

        % Value changed function: Sliderk_wall
        function Sliderk_wallValueChanged(app, event)
            snapSlider(app, "Sliderk_wall");
            yaxisDropDownValueChanged(app, event);
        end

        % Value changed function: ShowthermallimitsButton
        function ShowthermallimitsButtonValueChanged(app, event)
            value = app.ShowthermallimitsButton.Value;
            yaxisDropDownValueChanged(app, event);
        end

        % Value changed function: PreferenceSwitchtherm_stress, 
        % ...and 1 other component
        function PreferenceSwitchtherm_stressValueChanged(app, event)
            updateAutoTrade(app, "therm_stress");
        end

        % Value changed function: PreferenceSwitchhoop_stress_doghouse, 
        % ...and 1 other component
        function PreferenceSwitchhoop_stress_doghouseValueChanged(app, event)
            updateAutoTrade(app, "hoop_stress_doghouse");
        end

        % Value changed function: PreferenceSwitchtotal_stress_doghouse, 
        % ...and 1 other component
        function PreferenceSwitchtotal_stress_doghouseValueChanged(app, event)
            updateAutoTrade(app, "total_stress_doghouse");
        end

        % Value changed function: PreferenceSwitchTwg, knobTwg
        function PreferenceSwitchTwgValueChanged(app, event)
            updateAutoTrade(app, "Twg");
        end

        % Value changed function: PreferenceSwitchT_coolant_f, 
        % ...and 1 other component
        function PreferenceSwitchT_coolant_fValueChanged(app, event)
            updateAutoTrade(app, "T_coolant_f");
        end

        % Value changed function: PreferenceSwitchP_coolant_min, 
        % ...and 1 other component
        function PreferenceSwitchP_coolant_minValueChanged(app, event)
            updateAutoTrade(app, "P_coolant_min");
        end

        % Value changed function: PreferenceSwitchIsp, knobIsp
        function PreferenceSwitchIspValueChanged(app, event)
            updateAutoTrade(app, "Isp");
        end

        % Value changed function: PreferenceSwitchthrust, knobthrust
        function PreferenceSwitchthrustValueChanged(app, event)
            updateAutoTrade(app, "thrust");
        end

        % Value changed function: PreferenceSwitchprop_cost_rate, knobprop_cost_rate
        function PreferenceSwitchprop_cost_rateValueChanged(app, event)
            updateAutoTrade(app, "prop_cost_rate");
        end

        % Value changed function: PreferenceSwitchdt, knobdt
        function PreferenceSwitchdtValueChanged(app, event)
            updateAutoTrade(app, "dt");
        end

        % Value changed function: PreferenceSwitchde, knobde
        function PreferenceSwitchdeValueChanged(app, event)
            updateAutoTrade(app, "de");
        end

        % Value changed function: PreferenceSwitchcstar, knobcstar
        function PreferenceSwitchcstarValueChanged(app, event)
            updateAutoTrade(app, "cstar");
        end

        % Value changed function: PreferenceSwitcheta_cstar, knobeta_cstar
        function PreferenceSwitcheta_cstarValueChanged(app, event)
            updateAutoTrade(app, "eta_cstar");
        end

        % Value changed function: PreferenceSwitchTWR, knobTWR
        function PreferenceSwitchTWRValueChanged(app, event)
            updateAutoTrade(app, "TWR");
        end
    end

    % Component initialization
    methods (Access = public)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1527 817];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroupmain
            app.TabGroupmain = uitabgroup(app.UIFigure);
            app.TabGroupmain.Position = [1 3 1526 815];

            % Create DataTab
            app.DataTab = uitab(app.TabGroupmain);
            app.DataTab.Title = 'Data';

            % Create UIAxesk_wall
            app.UIAxesk_wall = uiaxes(app.DataTab);
            title(app.UIAxesk_wall, 'varying k wall')
            xlabel(app.UIAxesk_wall, 'X')
            ylabel(app.UIAxesk_wall, 'Y')
            zlabel(app.UIAxesk_wall, 'Z')
            app.UIAxesk_wall.Position = [1201 185 300 300];

            % Create UIAxeswall_t
            app.UIAxeswall_t = uiaxes(app.DataTab);
            title(app.UIAxeswall_t, 'varying wall thickness')
            xlabel(app.UIAxeswall_t, 'X')
            ylabel(app.UIAxeswall_t, 'Y')
            zlabel(app.UIAxeswall_t, 'Z')
            app.UIAxeswall_t.Position = [897 186 300 300];

            % Create UIAxesmdot
            app.UIAxesmdot = uiaxes(app.DataTab);
            title(app.UIAxesmdot, 'varying mdot')
            xlabel(app.UIAxesmdot, 'X')
            ylabel(app.UIAxesmdot, 'Y')
            zlabel(app.UIAxesmdot, 'Z')
            app.UIAxesmdot.Position = [897 485 300 300];

            % Create UIAxesT_coolant_i
            app.UIAxesT_coolant_i = uiaxes(app.DataTab);
            title(app.UIAxesT_coolant_i, 'varying T coolant')
            xlabel(app.UIAxesT_coolant_i, 'X')
            ylabel(app.UIAxesT_coolant_i, 'Y')
            zlabel(app.UIAxesT_coolant_i, 'Z')
            app.UIAxesT_coolant_i.Position = [600 186 300 300];

            % Create UIAxesexpansion_ratio
            app.UIAxesexpansion_ratio = uiaxes(app.DataTab);
            title(app.UIAxesexpansion_ratio, 'varying expansion ratio')
            xlabel(app.UIAxesexpansion_ratio, 'X')
            ylabel(app.UIAxesexpansion_ratio, 'Y')
            zlabel(app.UIAxesexpansion_ratio, 'Z')
            app.UIAxesexpansion_ratio.Position = [600 485 300 300];

            % Create UIAxesnum_channels
            app.UIAxesnum_channels = uiaxes(app.DataTab);
            title(app.UIAxesnum_channels, 'varying # of channels')
            xlabel(app.UIAxesnum_channels, 'X')
            ylabel(app.UIAxesnum_channels, 'Y')
            zlabel(app.UIAxesnum_channels, 'Z')
            app.UIAxesnum_channels.Position = [301 186 300 300];

            % Create UIAxesOF
            app.UIAxesOF = uiaxes(app.DataTab);
            title(app.UIAxesOF, 'varying OF')
            xlabel(app.UIAxesOF, 'X')
            ylabel(app.UIAxesOF, 'Y')
            zlabel(app.UIAxesOF, 'Z')
            app.UIAxesOF.Position = [301 485 300 300];

            % Create UIAxesd_channel
            app.UIAxesd_channel = uiaxes(app.DataTab);
            title(app.UIAxesd_channel, 'varying d channels')
            xlabel(app.UIAxesd_channel, 'X')
            ylabel(app.UIAxesd_channel, 'Y')
            zlabel(app.UIAxesd_channel, 'Z')
            app.UIAxesd_channel.Position = [4 186 300 300];

            % Create UIAxespc_c
            app.UIAxespc_c = uiaxes(app.DataTab);
            title(app.UIAxespc_c, 'varying pc_c')
            xlabel(app.UIAxespc_c, 'X')
            ylabel(app.UIAxespc_c, 'Y')
            zlabel(app.UIAxespc_c, 'Z')
            app.UIAxespc_c.Position = [4 485 300 300];

            % Create TabGroup
            app.TabGroup = uitabgroup(app.DataTab);
            app.TabGroup.Position = [1196 485 326 305];

            % Create viewofthroatTab
            app.viewofthroatTab = uitab(app.TabGroup);
            app.viewofthroatTab.Title = 'view of throat';

            % Create UIAxesview_of_throat
            app.UIAxesview_of_throat = uiaxes(app.viewofthroatTab);
            title(app.UIAxesview_of_throat, 'view of throat (units=mm)')
            xlabel(app.UIAxesview_of_throat, 'X')
            ylabel(app.UIAxesview_of_throat, 'Y')
            zlabel(app.UIAxesview_of_throat, 'Z')
            app.UIAxesview_of_throat.Position = [33 6 275 275];

            % Create viewofwholeengineTab
            app.viewofwholeengineTab = uitab(app.TabGroup);
            app.viewofwholeengineTab.Title = 'view of whole engine';

            % Create UIAxesview_of_whole_engine
            app.UIAxesview_of_whole_engine = uiaxes(app.viewofwholeengineTab);
            title(app.UIAxesview_of_whole_engine, 'view of whole engine (units=mm)')
            xlabel(app.UIAxesview_of_whole_engine, 'X')
            ylabel(app.UIAxesview_of_whole_engine, 'Y')
            zlabel(app.UIAxesview_of_whole_engine, 'Z')
            app.UIAxesview_of_whole_engine.Position = [33 6 275 275];

            % Create ShowthermallimitsButton
            app.ShowthermallimitsButton = uibutton(app.DataTab, 'state');
            app.ShowthermallimitsButton.ValueChangedFcn = createCallbackFcn(app, @ShowthermallimitsButtonValueChanged, true);
            app.ShowthermallimitsButton.Text = 'Show thermal limits';
            app.ShowthermallimitsButton.Position = [2 150 119 22];

            % Create yaxisDropDownLabel
            app.yaxisDropDownLabel = uilabel(app.DataTab);
            app.yaxisDropDownLabel.HorizontalAlignment = 'right';
            app.yaxisDropDownLabel.Position = [4 176 36 22];
            app.yaxisDropDownLabel.Text = 'y-axis';

            % Create yaxisDropDown
            app.yaxisDropDown = uidropdown(app.DataTab);
            app.yaxisDropDown.ValueChangedFcn = createCallbackFcn(app, @yaxisDropDownValueChanged, true);
            app.yaxisDropDown.Position = [55 176 100 22];

            % Create pc_cpsiSliderLabel
            app.pc_cpsiSliderLabel = uilabel(app.DataTab);
            app.pc_cpsiSliderLabel.HorizontalAlignment = 'right';
            app.pc_cpsiSliderLabel.Position = [93 93 28 30];
            app.pc_cpsiSliderLabel.Text = {'pc_c'; '(psi)'};

            % Create Sliderpc_c
            app.Sliderpc_c = uislider(app.DataTab);
            app.Sliderpc_c.ValueChangedFcn = createCallbackFcn(app, @Sliderpc_cValueChanged, true);
            app.Sliderpc_c.Position = [143 110 150 3];

            % Create d_channelmmSliderLabel
            app.d_channelmmSliderLabel = uilabel(app.DataTab);
            app.d_channelmmSliderLabel.HorizontalAlignment = 'right';
            app.d_channelmmSliderLabel.Position = [61 25 60 30];
            app.d_channelmmSliderLabel.Text = {'d_channel'; '(mm)'};

            % Create Sliderd_channel
            app.Sliderd_channel = uislider(app.DataTab);
            app.Sliderd_channel.ValueChangedFcn = createCallbackFcn(app, @Sliderd_channelValueChanged, true);
            app.Sliderd_channel.Position = [143 42 150 3];

            % Create OFSliderLabel
            app.OFSliderLabel = uilabel(app.DataTab);
            app.OFSliderLabel.HorizontalAlignment = 'right';
            app.OFSliderLabel.Position = [393 101 25 22];
            app.OFSliderLabel.Text = 'OF';

            % Create SliderOF
            app.SliderOF = uislider(app.DataTab);
            app.SliderOF.ValueChangedFcn = createCallbackFcn(app, @SliderOFValueChanged, true);
            app.SliderOF.Position = [440 110 150 3];

            % Create expansionratioSliderLabel
            app.expansionratioSliderLabel = uilabel(app.DataTab);
            app.expansionratioSliderLabel.HorizontalAlignment = 'right';
            app.expansionratioSliderLabel.Position = [631 101 86 22];
            app.expansionratioSliderLabel.Text = 'expansion ratio';

            % Create Sliderexpansion_ratio
            app.Sliderexpansion_ratio = uislider(app.DataTab);
            app.Sliderexpansion_ratio.ValueChangedFcn = createCallbackFcn(app, @Sliderexpansion_ratioValueChanged, true);
            app.Sliderexpansion_ratio.Position = [739 110 150 3];

            % Create T_coolant_idegCSlider_2Label
            app.T_coolant_idegCSlider_2Label = uilabel(app.DataTab);
            app.T_coolant_idegCSlider_2Label.HorizontalAlignment = 'right';
            app.T_coolant_idegCSlider_2Label.Position = [659 25 58 30];
            app.T_coolant_idegCSlider_2Label.Text = {'T_coolant_i'; '(deg C)'};

            % Create SliderT_coolant_i
            app.SliderT_coolant_i = uislider(app.DataTab);
            app.SliderT_coolant_i.ValueChangedFcn = createCallbackFcn(app, @SliderT_coolant_iValueChanged, true);
            app.SliderT_coolant_i.Position = [739 42 150 3];

            % Create dtmmLabel
            app.dtmmLabel = uilabel(app.DataTab);
            app.dtmmLabel.HorizontalAlignment = 'right';
            app.dtmmLabel.Position = [972 93 42 30];
            app.dtmmLabel.Text = {'mdot'; '(lbm/s)'};

            % Create Slidermdot
            app.Slidermdot = uislider(app.DataTab);
            app.Slidermdot.ValueChangedFcn = createCallbackFcn(app, @SlidermdotValueChanged, true);
            app.Slidermdot.Position = [1036 110 150 3];

            % Create wall_thicknessmmSliderLabel
            app.wall_thicknessmmSliderLabel = uilabel(app.DataTab);
            app.wall_thicknessmmSliderLabel.HorizontalAlignment = 'right';
            app.wall_thicknessmmSliderLabel.Position = [935 25 79 30];
            app.wall_thicknessmmSliderLabel.Text = {'wall thickness'; '(mm)'};

            % Create Sliderwall_t
            app.Sliderwall_t = uislider(app.DataTab);
            app.Sliderwall_t.ValueChangedFcn = createCallbackFcn(app, @Sliderwall_tValueChanged, true);
            app.Sliderwall_t.Position = [1036 42 150 3];

            % Create k_wallWmKLabel
            app.k_wallWmKLabel = uilabel(app.DataTab);
            app.k_wallWmKLabel.HorizontalAlignment = 'right';
            app.k_wallWmKLabel.Position = [1232 33 86 22];
            app.k_wallWmKLabel.Text = 'k_wall (W/m-K)';

            % Create Sliderk_wall
            app.Sliderk_wall = uislider(app.DataTab);
            app.Sliderk_wall.ValueChangedFcn = createCallbackFcn(app, @Sliderk_wallValueChanged, true);
            app.Sliderk_wall.Position = [1340 42 150 3];

            % Create Slidernum_channels
            app.Slidernum_channels = uislider(app.DataTab);
            app.Slidernum_channels.ValueChangedFcn = createCallbackFcn(app, @Slidernum_channelsValueChanged, true);
            app.Slidernum_channels.Position = [440 42 150 3];

            % Create num_channelsSliderLabel
            app.num_channelsSliderLabel = uilabel(app.DataTab);
            app.num_channelsSliderLabel.HorizontalAlignment = 'right';
            app.num_channelsSliderLabel.Position = [335 33 83 22];
            app.num_channelsSliderLabel.Text = 'num_channels';

            % Create Volumemm3Label
            app.Volumemm3Label = uilabel(app.DataTab);
            app.Volumemm3Label.HorizontalAlignment = 'right';
            app.Volumemm3Label.Position = [1315 164 89 22];
            app.Volumemm3Label.Text = 'Volume (mm^3)';

            % Create EditFieldvol_engine
            app.EditFieldvol_engine = uieditfield(app.DataTab, 'numeric');
            app.EditFieldvol_engine.Editable = 'off';
            app.EditFieldvol_engine.Position = [1419 164 100 22];

            % Create Volumemm3Label_2
            app.Volumemm3Label_2 = uilabel(app.DataTab);
            app.Volumemm3Label_2.HorizontalAlignment = 'right';
            app.Volumemm3Label_2.Position = [1131 164 106 22];
            app.Volumemm3Label_2.Text = 'L_noz_parab (mm)';

            % Create EditFieldL_nozzle_parabolic
            app.EditFieldL_nozzle_parabolic = uieditfield(app.DataTab, 'numeric');
            app.EditFieldL_nozzle_parabolic.Editable = 'off';
            app.EditFieldL_nozzle_parabolic.Position = [1252 164 66 22];

            % Create Volumemm3Label_3
            app.Volumemm3Label_3 = uilabel(app.DataTab);
            app.Volumemm3Label_3.HorizontalAlignment = 'right';
            app.Volumemm3Label_3.Position = [1184 134 52 22];
            app.Volumemm3Label_3.Text = 'Re (mm)';

            % Create EditFieldRe
            app.EditFieldRe = uieditfield(app.DataTab, 'numeric');
            app.EditFieldRe.Editable = 'off';
            app.EditFieldRe.Position = [1251 134 66 22];

            % Create Volumemm3Label_4
            app.Volumemm3Label_4 = uilabel(app.DataTab);
            app.Volumemm3Label_4.HorizontalAlignment = 'right';
            app.Volumemm3Label_4.Position = [978 164 72 22];
            app.Volumemm3Label_4.Text = 'thetaN (deg)';

            % Create EditFieldthetaN
            app.EditFieldthetaN = uieditfield(app.DataTab, 'numeric');
            app.EditFieldthetaN.Editable = 'off';
            app.EditFieldthetaN.Position = [1065 164 66 22];

            % Create Volumemm3Label_5
            app.Volumemm3Label_5 = uilabel(app.DataTab);
            app.Volumemm3Label_5.HorizontalAlignment = 'right';
            app.Volumemm3Label_5.Position = [823 164 51 22];
            app.Volumemm3Label_5.Text = 'xN (mm)';

            % Create EditFieldxN
            app.EditFieldxN = uieditfield(app.DataTab, 'numeric');
            app.EditFieldxN.Editable = 'off';
            app.EditFieldxN.Position = [889 164 66 22];

            % Create Volumemm3Label_6
            app.Volumemm3Label_6 = uilabel(app.DataTab);
            app.Volumemm3Label_6.HorizontalAlignment = 'right';
            app.Volumemm3Label_6.Position = [822 134 52 22];
            app.Volumemm3Label_6.Text = 'R1 (mm)';

            % Create EditFieldR1
            app.EditFieldR1 = uieditfield(app.DataTab, 'numeric');
            app.EditFieldR1.Editable = 'off';
            app.EditFieldR1.Position = [889 134 66 22];

            % Create Volumemm3Label_7
            app.Volumemm3Label_7 = uilabel(app.DataTab);
            app.Volumemm3Label_7.HorizontalAlignment = 'right';
            app.Volumemm3Label_7.Position = [534 164 58 22];
            app.Volumemm3Label_7.Text = 'R1p (mm)';

            % Create EditFieldR1p
            app.EditFieldR1p = uieditfield(app.DataTab, 'numeric');
            app.EditFieldR1p.Editable = 'off';
            app.EditFieldR1p.Position = [607 164 66 22];

            % Create Volumemm3Label_8
            app.Volumemm3Label_8 = uilabel(app.DataTab);
            app.Volumemm3Label_8.HorizontalAlignment = 'right';
            app.Volumemm3Label_8.Position = [525 134 66 22];
            app.Volumemm3Label_8.Text = 'alpha (deg)';

            % Create EditFieldalpha
            app.EditFieldalpha = uieditfield(app.DataTab, 'numeric');
            app.EditFieldalpha.Editable = 'off';
            app.EditFieldalpha.Position = [606 134 66 22];

            % Create Volumemm3Label_9
            app.Volumemm3Label_9 = uilabel(app.DataTab);
            app.Volumemm3Label_9.HorizontalAlignment = 'right';
            app.Volumemm3Label_9.Position = [292 165 132 22];
            app.Volumemm3Label_9.Text = 'L_chmb_crc_nrrw (mm)';

            % Create EditFieldL_chamber_circular_narrow
            app.EditFieldL_chamber_circular_narrow = uieditfield(app.DataTab, 'numeric');
            app.EditFieldL_chamber_circular_narrow.Editable = 'off';
            app.EditFieldL_chamber_circular_narrow.Position = [439 165 66 22];

            % Create Volumemm3Label_10
            app.Volumemm3Label_10 = uilabel(app.DataTab);
            app.Volumemm3Label_10.HorizontalAlignment = 'right';
            app.Volumemm3Label_10.Position = [372 134 51 22];
            app.Volumemm3Label_10.Text = 'Rc (mm)';

            % Create EditFieldRc
            app.EditFieldRc = uieditfield(app.DataTab, 'numeric');
            app.EditFieldRc.Editable = 'off';
            app.EditFieldRc.Position = [438 134 66 22];

            % Create Volumemm3Label_11
            app.Volumemm3Label_11 = uilabel(app.DataTab);
            app.Volumemm3Label_11.HorizontalAlignment = 'right';
            app.Volumemm3Label_11.Position = [119 134 79 22];
            app.Volumemm3Label_11.Text = 'L_chmb (mm)';

            % Create EditFieldL_chamber_linear
            app.EditFieldL_chamber_linear = uieditfield(app.DataTab, 'numeric');
            app.EditFieldL_chamber_linear.Editable = 'off';
            app.EditFieldL_chamber_linear.Position = [213 134 66 22];

            % Create Volumemm3Label_12
            app.Volumemm3Label_12 = uilabel(app.DataTab);
            app.Volumemm3Label_12.HorizontalAlignment = 'right';
            app.Volumemm3Label_12.Position = [694 164 46 22];
            app.Volumemm3Label_12.Text = 'dt (mm)';

            % Create EditFielddt
            app.EditFielddt = uieditfield(app.DataTab, 'numeric');
            app.EditFielddt.Editable = 'off';
            app.EditFielddt.Position = [755 164 66 22];

            % Create RunningLampLabel
            app.RunningLampLabel = uilabel(app.DataTab);
            app.RunningLampLabel.HorizontalAlignment = 'right';
            app.RunningLampLabel.Position = [4 120 50 22];
            app.RunningLampLabel.Text = 'Running';

            % Create RunningLamp
            app.RunningLamp = uilamp(app.DataTab);
            app.RunningLamp.Position = [69 120 20 20];
            app.RunningLamp.Color = [1 0 0];

            % Create AutomateTradeStudyTab
            app.AutomateTradeStudyTab = uitab(app.TabGroupmain);
            app.AutomateTradeStudyTab.Title = 'Automate Trade Study';

            % Create therm_stressPanel
            app.therm_stressPanel = uipanel(app.AutomateTradeStudyTab);
            app.therm_stressPanel.Title = 'therm_stress';
            app.therm_stressPanel.Position = [5 588 194 197];

            % Create Switchtherm_stress
            app.Switchtherm_stress = uiswitch(app.therm_stressPanel, 'toggle');
            app.Switchtherm_stress.Items = {'Min', 'Max'};
            app.Switchtherm_stress.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchtherm_stressValueChanged, true);
            app.Switchtherm_stress.Enable = 'off';
            app.Switchtherm_stress.Position = [162 105 20 45];
            app.Switchtherm_stress.Value = 'Min';

            % Create Lamptherm_stress
            app.Lamptherm_stress = uilamp(app.therm_stressPanel);
            app.Lamptherm_stress.Position = [107 149 20 20];
            app.Lamptherm_stress.Color = [1 0 0];

            % Create PreferenceSwitchLabel
            app.PreferenceSwitchLabel = uilabel(app.therm_stressPanel);
            app.PreferenceSwitchLabel.HorizontalAlignment = 'center';
            app.PreferenceSwitchLabel.Position = [17 123 70 22];
            app.PreferenceSwitchLabel.Text = 'Preference?';

            % Create PreferenceSwitchtherm_stress
            app.PreferenceSwitchtherm_stress = uiswitch(app.therm_stressPanel, 'slider');
            app.PreferenceSwitchtherm_stress.Items = {'No', 'Yes'};
            app.PreferenceSwitchtherm_stress.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchtherm_stressValueChanged, true);
            app.PreferenceSwitchtherm_stress.Position = [28 149 45 20];
            app.PreferenceSwitchtherm_stress.Value = 'No';

            % Create Priority1highestKnobLabel
            app.Priority1highestKnobLabel = uilabel(app.therm_stressPanel);
            app.Priority1highestKnobLabel.HorizontalAlignment = 'center';
            app.Priority1highestKnobLabel.Enable = 'off';
            app.Priority1highestKnobLabel.Position = [38 5 102 22];
            app.Priority1highestKnobLabel.Text = 'Priority (1 highest)';

            % Create knobtherm_stress
            app.knobtherm_stress = uiknob(app.therm_stressPanel, 'discrete');
            app.knobtherm_stress.Items = {'0', '0'};
            app.knobtherm_stress.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchtherm_stressValueChanged, true);
            app.knobtherm_stress.Enable = 'off';
            app.knobtherm_stress.Position = [55 31 60 60];
            app.knobtherm_stress.Value = '0';

            % Create total_stress_doghousePanel
            app.total_stress_doghousePanel = uipanel(app.AutomateTradeStudyTab);
            app.total_stress_doghousePanel.Title = 'total_stress_doghouse';
            app.total_stress_doghousePanel.Position = [400 588 194 197];

            % Create Switchtotal_stress_doghouse
            app.Switchtotal_stress_doghouse = uiswitch(app.total_stress_doghousePanel, 'toggle');
            app.Switchtotal_stress_doghouse.Items = {'Min', 'Max'};
            app.Switchtotal_stress_doghouse.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchtotal_stress_doghouseValueChanged, true);
            app.Switchtotal_stress_doghouse.Enable = 'off';
            app.Switchtotal_stress_doghouse.Position = [162 105 20 45];
            app.Switchtotal_stress_doghouse.Value = 'Min';

            % Create Lamptotal_stress_doghouse
            app.Lamptotal_stress_doghouse = uilamp(app.total_stress_doghousePanel);
            app.Lamptotal_stress_doghouse.Position = [107 149 20 20];
            app.Lamptotal_stress_doghouse.Color = [1 0 0];

            % Create PreferenceSwitch_3Label
            app.PreferenceSwitch_3Label = uilabel(app.total_stress_doghousePanel);
            app.PreferenceSwitch_3Label.HorizontalAlignment = 'center';
            app.PreferenceSwitch_3Label.Position = [17 123 70 22];
            app.PreferenceSwitch_3Label.Text = 'Preference?';

            % Create PreferenceSwitchtotal_stress_doghouse
            app.PreferenceSwitchtotal_stress_doghouse = uiswitch(app.total_stress_doghousePanel, 'slider');
            app.PreferenceSwitchtotal_stress_doghouse.Items = {'No', 'Yes'};
            app.PreferenceSwitchtotal_stress_doghouse.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchtotal_stress_doghouseValueChanged, true);
            app.PreferenceSwitchtotal_stress_doghouse.Position = [28 149 45 20];
            app.PreferenceSwitchtotal_stress_doghouse.Value = 'No';

            % Create Priority1highestKnob_3Label
            app.Priority1highestKnob_3Label = uilabel(app.total_stress_doghousePanel);
            app.Priority1highestKnob_3Label.HorizontalAlignment = 'center';
            app.Priority1highestKnob_3Label.Enable = 'off';
            app.Priority1highestKnob_3Label.Position = [38 5 102 22];
            app.Priority1highestKnob_3Label.Text = 'Priority (1 highest)';

            % Create knobtotal_stress_doghouse
            app.knobtotal_stress_doghouse = uiknob(app.total_stress_doghousePanel, 'discrete');
            app.knobtotal_stress_doghouse.Items = {'0', '0'};
            app.knobtotal_stress_doghouse.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchtotal_stress_doghouseValueChanged, true);
            app.knobtotal_stress_doghouse.Enable = 'off';
            app.knobtotal_stress_doghouse.Position = [55 31 60 60];
            app.knobtotal_stress_doghouse.Value = '0';

            % Create TwgPanel
            app.TwgPanel = uipanel(app.AutomateTradeStudyTab);
            app.TwgPanel.Title = 'Twg';
            app.TwgPanel.Position = [597 588 194 197];

            % Create SwitchTwg
            app.SwitchTwg = uiswitch(app.TwgPanel, 'toggle');
            app.SwitchTwg.Items = {'Min', 'Max'};
            app.SwitchTwg.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchTwgValueChanged, true);
            app.SwitchTwg.Enable = 'off';
            app.SwitchTwg.Position = [162 105 20 45];
            app.SwitchTwg.Value = 'Min';

            % Create LampTwg
            app.LampTwg = uilamp(app.TwgPanel);
            app.LampTwg.Position = [107 149 20 20];
            app.LampTwg.Color = [1 0 0];

            % Create PreferenceSwitch_4Label
            app.PreferenceSwitch_4Label = uilabel(app.TwgPanel);
            app.PreferenceSwitch_4Label.HorizontalAlignment = 'center';
            app.PreferenceSwitch_4Label.Position = [17 123 70 22];
            app.PreferenceSwitch_4Label.Text = 'Preference?';

            % Create PreferenceSwitchTwg
            app.PreferenceSwitchTwg = uiswitch(app.TwgPanel, 'slider');
            app.PreferenceSwitchTwg.Items = {'No', 'Yes'};
            app.PreferenceSwitchTwg.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchTwgValueChanged, true);
            app.PreferenceSwitchTwg.Position = [28 149 45 20];
            app.PreferenceSwitchTwg.Value = 'No';

            % Create Priority1highestKnob_4Label
            app.Priority1highestKnob_4Label = uilabel(app.TwgPanel);
            app.Priority1highestKnob_4Label.HorizontalAlignment = 'center';
            app.Priority1highestKnob_4Label.Enable = 'off';
            app.Priority1highestKnob_4Label.Position = [38 5 102 22];
            app.Priority1highestKnob_4Label.Text = 'Priority (1 highest)';

            % Create knobTwg
            app.knobTwg = uiknob(app.TwgPanel, 'discrete');
            app.knobTwg.Items = {'0', '0'};
            app.knobTwg.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchTwgValueChanged, true);
            app.knobTwg.Enable = 'off';
            app.knobTwg.Position = [55 31 60 60];
            app.knobTwg.Value = '0';

            % Create hoop_stress_doghousePanel
            app.hoop_stress_doghousePanel = uipanel(app.AutomateTradeStudyTab);
            app.hoop_stress_doghousePanel.Title = 'hoop_stress_doghouse';
            app.hoop_stress_doghousePanel.Position = [203 588 194 197];

            % Create Switchhoop_stress_doghouse
            app.Switchhoop_stress_doghouse = uiswitch(app.hoop_stress_doghousePanel, 'toggle');
            app.Switchhoop_stress_doghouse.Items = {'Min', 'Max'};
            app.Switchhoop_stress_doghouse.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchhoop_stress_doghouseValueChanged, true);
            app.Switchhoop_stress_doghouse.Enable = 'off';
            app.Switchhoop_stress_doghouse.Position = [162 105 20 45];
            app.Switchhoop_stress_doghouse.Value = 'Min';

            % Create Lamphoop_stress_doghouse
            app.Lamphoop_stress_doghouse = uilamp(app.hoop_stress_doghousePanel);
            app.Lamphoop_stress_doghouse.Position = [107 149 20 20];
            app.Lamphoop_stress_doghouse.Color = [1 0 0];

            % Create PreferenceSwitch_5Label
            app.PreferenceSwitch_5Label = uilabel(app.hoop_stress_doghousePanel);
            app.PreferenceSwitch_5Label.HorizontalAlignment = 'center';
            app.PreferenceSwitch_5Label.Position = [17 123 70 22];
            app.PreferenceSwitch_5Label.Text = 'Preference?';

            % Create PreferenceSwitchhoop_stress_doghouse
            app.PreferenceSwitchhoop_stress_doghouse = uiswitch(app.hoop_stress_doghousePanel, 'slider');
            app.PreferenceSwitchhoop_stress_doghouse.Items = {'No', 'Yes'};
            app.PreferenceSwitchhoop_stress_doghouse.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchhoop_stress_doghouseValueChanged, true);
            app.PreferenceSwitchhoop_stress_doghouse.Position = [28 149 45 20];
            app.PreferenceSwitchhoop_stress_doghouse.Value = 'No';

            % Create Priority1highestKnob_5Label
            app.Priority1highestKnob_5Label = uilabel(app.hoop_stress_doghousePanel);
            app.Priority1highestKnob_5Label.HorizontalAlignment = 'center';
            app.Priority1highestKnob_5Label.Enable = 'off';
            app.Priority1highestKnob_5Label.Position = [38 5 102 22];
            app.Priority1highestKnob_5Label.Text = 'Priority (1 highest)';

            % Create knobhoop_stress_doghouse
            app.knobhoop_stress_doghouse = uiknob(app.hoop_stress_doghousePanel, 'discrete');
            app.knobhoop_stress_doghouse.Items = {'0', '0'};
            app.knobhoop_stress_doghouse.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchhoop_stress_doghouseValueChanged, true);
            app.knobhoop_stress_doghouse.Enable = 'off';
            app.knobhoop_stress_doghouse.Position = [55 31 60 60];
            app.knobhoop_stress_doghouse.Value = '0';

            % Create P_coolant_minPanel
            app.P_coolant_minPanel = uipanel(app.AutomateTradeStudyTab);
            app.P_coolant_minPanel.Title = 'P_coolant_min';
            app.P_coolant_minPanel.Position = [989 588 194 197];

            % Create SwitchP_coolant_min
            app.SwitchP_coolant_min = uiswitch(app.P_coolant_minPanel, 'toggle');
            app.SwitchP_coolant_min.Items = {'Min', 'Max'};
            app.SwitchP_coolant_min.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchP_coolant_minValueChanged, true);
            app.SwitchP_coolant_min.Enable = 'off';
            app.SwitchP_coolant_min.Position = [162 105 20 45];
            app.SwitchP_coolant_min.Value = 'Min';

            % Create LampP_coolant_min
            app.LampP_coolant_min = uilamp(app.P_coolant_minPanel);
            app.LampP_coolant_min.Position = [107 149 20 20];
            app.LampP_coolant_min.Color = [1 0 0];

            % Create PreferenceSwitch_6Label
            app.PreferenceSwitch_6Label = uilabel(app.P_coolant_minPanel);
            app.PreferenceSwitch_6Label.HorizontalAlignment = 'center';
            app.PreferenceSwitch_6Label.Position = [17 123 70 22];
            app.PreferenceSwitch_6Label.Text = 'Preference?';

            % Create PreferenceSwitchP_coolant_min
            app.PreferenceSwitchP_coolant_min = uiswitch(app.P_coolant_minPanel, 'slider');
            app.PreferenceSwitchP_coolant_min.Items = {'No', 'Yes'};
            app.PreferenceSwitchP_coolant_min.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchP_coolant_minValueChanged, true);
            app.PreferenceSwitchP_coolant_min.Position = [28 149 45 20];
            app.PreferenceSwitchP_coolant_min.Value = 'No';

            % Create Priority1highestKnob_6Label
            app.Priority1highestKnob_6Label = uilabel(app.P_coolant_minPanel);
            app.Priority1highestKnob_6Label.HorizontalAlignment = 'center';
            app.Priority1highestKnob_6Label.Enable = 'off';
            app.Priority1highestKnob_6Label.Position = [38 5 102 22];
            app.Priority1highestKnob_6Label.Text = 'Priority (1 highest)';

            % Create knobP_coolant_min
            app.knobP_coolant_min = uiknob(app.P_coolant_minPanel, 'discrete');
            app.knobP_coolant_min.Items = {'0', '0'};
            app.knobP_coolant_min.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchP_coolant_minValueChanged, true);
            app.knobP_coolant_min.Enable = 'off';
            app.knobP_coolant_min.Position = [55 31 60 60];
            app.knobP_coolant_min.Value = '0';

            % Create IspPanel
            app.IspPanel = uipanel(app.AutomateTradeStudyTab);
            app.IspPanel.Title = 'Isp';
            app.IspPanel.Position = [1186 588 194 197];

            % Create SwitchIsp
            app.SwitchIsp = uiswitch(app.IspPanel, 'toggle');
            app.SwitchIsp.Items = {'Min', 'Max'};
            app.SwitchIsp.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchIspValueChanged, true);
            app.SwitchIsp.Enable = 'off';
            app.SwitchIsp.Position = [162 105 20 45];
            app.SwitchIsp.Value = 'Min';

            % Create LampIsp
            app.LampIsp = uilamp(app.IspPanel);
            app.LampIsp.Position = [107 149 20 20];
            app.LampIsp.Color = [1 0 0];

            % Create PreferenceSwitch_7Label
            app.PreferenceSwitch_7Label = uilabel(app.IspPanel);
            app.PreferenceSwitch_7Label.HorizontalAlignment = 'center';
            app.PreferenceSwitch_7Label.Position = [17 123 70 22];
            app.PreferenceSwitch_7Label.Text = 'Preference?';

            % Create PreferenceSwitchIsp
            app.PreferenceSwitchIsp = uiswitch(app.IspPanel, 'slider');
            app.PreferenceSwitchIsp.Items = {'No', 'Yes'};
            app.PreferenceSwitchIsp.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchIspValueChanged, true);
            app.PreferenceSwitchIsp.Position = [28 149 45 20];
            app.PreferenceSwitchIsp.Value = 'No';

            % Create Priority1highestKnob_7Label
            app.Priority1highestKnob_7Label = uilabel(app.IspPanel);
            app.Priority1highestKnob_7Label.HorizontalAlignment = 'center';
            app.Priority1highestKnob_7Label.Enable = 'off';
            app.Priority1highestKnob_7Label.Position = [38 5 102 22];
            app.Priority1highestKnob_7Label.Text = 'Priority (1 highest)';

            % Create knobIsp
            app.knobIsp = uiknob(app.IspPanel, 'discrete');
            app.knobIsp.Items = {'0', '0'};
            app.knobIsp.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchIspValueChanged, true);
            app.knobIsp.Enable = 'off';
            app.knobIsp.Position = [55 31 60 60];
            app.knobIsp.Value = '0';

            % Create T_coolant_fPanel
            app.T_coolant_fPanel = uipanel(app.AutomateTradeStudyTab);
            app.T_coolant_fPanel.Title = 'T_coolant_f';
            app.T_coolant_fPanel.Position = [792 588 194 197];

            % Create SwitchT_coolant_f
            app.SwitchT_coolant_f = uiswitch(app.T_coolant_fPanel, 'toggle');
            app.SwitchT_coolant_f.Items = {'Min', 'Max'};
            app.SwitchT_coolant_f.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchT_coolant_fValueChanged, true);
            app.SwitchT_coolant_f.Enable = 'off';
            app.SwitchT_coolant_f.Position = [162 105 20 45];
            app.SwitchT_coolant_f.Value = 'Min';

            % Create LampT_coolant_f
            app.LampT_coolant_f = uilamp(app.T_coolant_fPanel);
            app.LampT_coolant_f.Position = [107 149 20 20];
            app.LampT_coolant_f.Color = [1 0 0];

            % Create PreferenceSwitch_8Label
            app.PreferenceSwitch_8Label = uilabel(app.T_coolant_fPanel);
            app.PreferenceSwitch_8Label.HorizontalAlignment = 'center';
            app.PreferenceSwitch_8Label.Position = [17 123 70 22];
            app.PreferenceSwitch_8Label.Text = 'Preference?';

            % Create PreferenceSwitchT_coolant_f
            app.PreferenceSwitchT_coolant_f = uiswitch(app.T_coolant_fPanel, 'slider');
            app.PreferenceSwitchT_coolant_f.Items = {'No', 'Yes'};
            app.PreferenceSwitchT_coolant_f.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchT_coolant_fValueChanged, true);
            app.PreferenceSwitchT_coolant_f.Position = [28 149 45 20];
            app.PreferenceSwitchT_coolant_f.Value = 'No';

            % Create Priority1highestKnob_8Label
            app.Priority1highestKnob_8Label = uilabel(app.T_coolant_fPanel);
            app.Priority1highestKnob_8Label.HorizontalAlignment = 'center';
            app.Priority1highestKnob_8Label.Enable = 'off';
            app.Priority1highestKnob_8Label.Position = [38 5 102 22];
            app.Priority1highestKnob_8Label.Text = 'Priority (1 highest)';

            % Create knobT_coolant_f
            app.knobT_coolant_f = uiknob(app.T_coolant_fPanel, 'discrete');
            app.knobT_coolant_f.Items = {'0', '0'};
            app.knobT_coolant_f.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchT_coolant_fValueChanged, true);
            app.knobT_coolant_f.Enable = 'off';
            app.knobT_coolant_f.Position = [55 31 60 60];
            app.knobT_coolant_f.Value = '0';

            % Create thrustPanel
            app.thrustPanel = uipanel(app.AutomateTradeStudyTab);
            app.thrustPanel.Title = 'thrust';
            app.thrustPanel.Position = [5 387 194 197];

            % Create Switchthrust
            app.Switchthrust = uiswitch(app.thrustPanel, 'toggle');
            app.Switchthrust.Items = {'Min', 'Max'};
            app.Switchthrust.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchthrustValueChanged, true);
            app.Switchthrust.Enable = 'off';
            app.Switchthrust.Position = [162 105 20 45];
            app.Switchthrust.Value = 'Min';

            % Create Lampthrust
            app.Lampthrust = uilamp(app.thrustPanel);
            app.Lampthrust.Position = [107 149 20 20];
            app.Lampthrust.Color = [1 0 0];

            % Create PreferenceSwitch_9Label
            app.PreferenceSwitch_9Label = uilabel(app.thrustPanel);
            app.PreferenceSwitch_9Label.HorizontalAlignment = 'center';
            app.PreferenceSwitch_9Label.Position = [17 123 70 22];
            app.PreferenceSwitch_9Label.Text = 'Preference?';

            % Create PreferenceSwitchthrust
            app.PreferenceSwitchthrust = uiswitch(app.thrustPanel, 'slider');
            app.PreferenceSwitchthrust.Items = {'No', 'Yes'};
            app.PreferenceSwitchthrust.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchthrustValueChanged, true);
            app.PreferenceSwitchthrust.Position = [28 149 45 20];
            app.PreferenceSwitchthrust.Value = 'No';

            % Create Priority1highestKnob_9Label
            app.Priority1highestKnob_9Label = uilabel(app.thrustPanel);
            app.Priority1highestKnob_9Label.HorizontalAlignment = 'center';
            app.Priority1highestKnob_9Label.Enable = 'off';
            app.Priority1highestKnob_9Label.Position = [38 5 102 22];
            app.Priority1highestKnob_9Label.Text = 'Priority (1 highest)';

            % Create knobthrust
            app.knobthrust = uiknob(app.thrustPanel, 'discrete');
            app.knobthrust.Items = {'0', '0'};
            app.knobthrust.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchthrustValueChanged, true);
            app.knobthrust.Enable = 'off';
            app.knobthrust.Position = [55 31 60 60];
            app.knobthrust.Value = '0';

            % Create dtPanel
            app.dtPanel = uipanel(app.AutomateTradeStudyTab);
            app.dtPanel.Title = 'dt';
            app.dtPanel.Position = [400 387 194 197];

            % Create Switchdt
            app.Switchdt = uiswitch(app.dtPanel, 'toggle');
            app.Switchdt.Items = {'Min', 'Max'};
            app.Switchdt.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchdtValueChanged, true);
            app.Switchdt.Enable = 'off';
            app.Switchdt.Position = [162 105 20 45];
            app.Switchdt.Value = 'Min';

            % Create Lampdt
            app.Lampdt = uilamp(app.dtPanel);
            app.Lampdt.Position = [107 149 20 20];
            app.Lampdt.Color = [1 0 0];

            % Create PreferenceSwitch_10Label
            app.PreferenceSwitch_10Label = uilabel(app.dtPanel);
            app.PreferenceSwitch_10Label.HorizontalAlignment = 'center';
            app.PreferenceSwitch_10Label.Position = [17 123 70 22];
            app.PreferenceSwitch_10Label.Text = 'Preference?';

            % Create PreferenceSwitchdt
            app.PreferenceSwitchdt = uiswitch(app.dtPanel, 'slider');
            app.PreferenceSwitchdt.Items = {'No', 'Yes'};
            app.PreferenceSwitchdt.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchdtValueChanged, true);
            app.PreferenceSwitchdt.Position = [28 149 45 20];
            app.PreferenceSwitchdt.Value = 'No';

            % Create Priority1highestKnob_10Label
            app.Priority1highestKnob_10Label = uilabel(app.dtPanel);
            app.Priority1highestKnob_10Label.HorizontalAlignment = 'center';
            app.Priority1highestKnob_10Label.Enable = 'off';
            app.Priority1highestKnob_10Label.Position = [38 5 102 22];
            app.Priority1highestKnob_10Label.Text = 'Priority (1 highest)';

            % Create knobdt
            app.knobdt = uiknob(app.dtPanel, 'discrete');
            app.knobdt.Items = {'0', '0'};
            app.knobdt.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchdtValueChanged, true);
            app.knobdt.Enable = 'off';
            app.knobdt.Position = [55 31 60 60];
            app.knobdt.Value = '0';

            % Create dePanel
            app.dePanel = uipanel(app.AutomateTradeStudyTab);
            app.dePanel.Title = 'de';
            app.dePanel.Position = [597 387 194 197];

            % Create Switchde
            app.Switchde = uiswitch(app.dePanel, 'toggle');
            app.Switchde.Items = {'Min', 'Max'};
            app.Switchde.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchdeValueChanged, true);
            app.Switchde.Enable = 'off';
            app.Switchde.Position = [162 105 20 45];
            app.Switchde.Value = 'Min';

            % Create Lampde
            app.Lampde = uilamp(app.dePanel);
            app.Lampde.Position = [107 149 20 20];
            app.Lampde.Color = [1 0 0];

            % Create PreferenceSwitch_11Label
            app.PreferenceSwitch_11Label = uilabel(app.dePanel);
            app.PreferenceSwitch_11Label.HorizontalAlignment = 'center';
            app.PreferenceSwitch_11Label.Position = [17 123 70 22];
            app.PreferenceSwitch_11Label.Text = 'Preference?';

            % Create PreferenceSwitchde
            app.PreferenceSwitchde = uiswitch(app.dePanel, 'slider');
            app.PreferenceSwitchde.Items = {'No', 'Yes'};
            app.PreferenceSwitchde.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchdeValueChanged, true);
            app.PreferenceSwitchde.Position = [28 149 45 20];
            app.PreferenceSwitchde.Value = 'No';

            % Create Priority1highestKnob_11Label
            app.Priority1highestKnob_11Label = uilabel(app.dePanel);
            app.Priority1highestKnob_11Label.HorizontalAlignment = 'center';
            app.Priority1highestKnob_11Label.Enable = 'off';
            app.Priority1highestKnob_11Label.Position = [38 5 102 22];
            app.Priority1highestKnob_11Label.Text = 'Priority (1 highest)';

            % Create knobde
            app.knobde = uiknob(app.dePanel, 'discrete');
            app.knobde.Items = {'0', '0'};
            app.knobde.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchdeValueChanged, true);
            app.knobde.Enable = 'off';
            app.knobde.Position = [55 31 60 60];
            app.knobde.Value = '0';

            % Create prop_cost_ratePanel
            app.prop_cost_ratePanel = uipanel(app.AutomateTradeStudyTab);
            app.prop_cost_ratePanel.Title = 'prop_cost_rate';
            app.prop_cost_ratePanel.Position = [203 387 194 197];

            % Create Switchprop_cost_rate
            app.Switchprop_cost_rate = uiswitch(app.prop_cost_ratePanel, 'toggle');
            app.Switchprop_cost_rate.Items = {'Min', 'Max'};
            app.Switchprop_cost_rate.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchprop_cost_rateValueChanged, true);
            app.Switchprop_cost_rate.Enable = 'off';
            app.Switchprop_cost_rate.Position = [162 105 20 45];
            app.Switchprop_cost_rate.Value = 'Min';

            % Create Lampprop_cost_rate
            app.Lampprop_cost_rate = uilamp(app.prop_cost_ratePanel);
            app.Lampprop_cost_rate.Position = [107 149 20 20];
            app.Lampprop_cost_rate.Color = [1 0 0];

            % Create PreferenceSwitch_12Label
            app.PreferenceSwitch_12Label = uilabel(app.prop_cost_ratePanel);
            app.PreferenceSwitch_12Label.HorizontalAlignment = 'center';
            app.PreferenceSwitch_12Label.Position = [17 123 70 22];
            app.PreferenceSwitch_12Label.Text = 'Preference?';

            % Create PreferenceSwitchprop_cost_rate
            app.PreferenceSwitchprop_cost_rate = uiswitch(app.prop_cost_ratePanel, 'slider');
            app.PreferenceSwitchprop_cost_rate.Items = {'No', 'Yes'};
            app.PreferenceSwitchprop_cost_rate.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchprop_cost_rateValueChanged, true);
            app.PreferenceSwitchprop_cost_rate.Position = [28 149 45 20];
            app.PreferenceSwitchprop_cost_rate.Value = 'No';

            % Create Priority1highestKnob_12Label
            app.Priority1highestKnob_12Label = uilabel(app.prop_cost_ratePanel);
            app.Priority1highestKnob_12Label.HorizontalAlignment = 'center';
            app.Priority1highestKnob_12Label.Enable = 'off';
            app.Priority1highestKnob_12Label.Position = [38 5 102 22];
            app.Priority1highestKnob_12Label.Text = 'Priority (1 highest)';

            % Create knobprop_cost_rate
            app.knobprop_cost_rate = uiknob(app.prop_cost_ratePanel, 'discrete');
            app.knobprop_cost_rate.Items = {'0', '0'};
            app.knobprop_cost_rate.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchprop_cost_rateValueChanged, true);
            app.knobprop_cost_rate.Enable = 'off';
            app.knobprop_cost_rate.Position = [55 31 60 60];
            app.knobprop_cost_rate.Value = '0';

            % Create eta_cstarPanel
            app.eta_cstarPanel = uipanel(app.AutomateTradeStudyTab);
            app.eta_cstarPanel.Title = 'eta_cstar';
            app.eta_cstarPanel.Position = [989 387 194 197];

            % Create Switcheta_cstar
            app.Switcheta_cstar = uiswitch(app.eta_cstarPanel, 'toggle');
            app.Switcheta_cstar.Items = {'Min', 'Max'};
            app.Switcheta_cstar.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitcheta_cstarValueChanged, true);
            app.Switcheta_cstar.Enable = 'off';
            app.Switcheta_cstar.Position = [162 105 20 45];
            app.Switcheta_cstar.Value = 'Min';

            % Create Lampeta_cstar
            app.Lampeta_cstar = uilamp(app.eta_cstarPanel);
            app.Lampeta_cstar.Position = [107 149 20 20];
            app.Lampeta_cstar.Color = [1 0 0];

            % Create PreferenceSwitch_13Label
            app.PreferenceSwitch_13Label = uilabel(app.eta_cstarPanel);
            app.PreferenceSwitch_13Label.HorizontalAlignment = 'center';
            app.PreferenceSwitch_13Label.Position = [17 123 70 22];
            app.PreferenceSwitch_13Label.Text = 'Preference?';

            % Create PreferenceSwitcheta_cstar
            app.PreferenceSwitcheta_cstar = uiswitch(app.eta_cstarPanel, 'slider');
            app.PreferenceSwitcheta_cstar.Items = {'No', 'Yes'};
            app.PreferenceSwitcheta_cstar.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitcheta_cstarValueChanged, true);
            app.PreferenceSwitcheta_cstar.Position = [28 149 45 20];
            app.PreferenceSwitcheta_cstar.Value = 'No';

            % Create Priority1highestKnob_13Label
            app.Priority1highestKnob_13Label = uilabel(app.eta_cstarPanel);
            app.Priority1highestKnob_13Label.HorizontalAlignment = 'center';
            app.Priority1highestKnob_13Label.Enable = 'off';
            app.Priority1highestKnob_13Label.Position = [38 5 102 22];
            app.Priority1highestKnob_13Label.Text = 'Priority (1 highest)';

            % Create knobeta_cstar
            app.knobeta_cstar = uiknob(app.eta_cstarPanel, 'discrete');
            app.knobeta_cstar.Items = {'0', '0'};
            app.knobeta_cstar.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitcheta_cstarValueChanged, true);
            app.knobeta_cstar.Enable = 'off';
            app.knobeta_cstar.Position = [55 31 60 60];
            app.knobeta_cstar.Value = '0';

            % Create TWRPanel
            app.TWRPanel = uipanel(app.AutomateTradeStudyTab);
            app.TWRPanel.Title = 'TWR';
            app.TWRPanel.Position = [1186 387 194 197];

            % Create SwitchTWR
            app.SwitchTWR = uiswitch(app.TWRPanel, 'toggle');
            app.SwitchTWR.Items = {'Min', 'Max'};
            app.SwitchTWR.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchTWRValueChanged, true);
            app.SwitchTWR.Enable = 'off';
            app.SwitchTWR.Position = [162 105 20 45];
            app.SwitchTWR.Value = 'Min';

            % Create LampTWR
            app.LampTWR = uilamp(app.TWRPanel);
            app.LampTWR.Position = [107 149 20 20];
            app.LampTWR.Color = [1 0 0];

            % Create PreferenceSwitch_14Label
            app.PreferenceSwitch_14Label = uilabel(app.TWRPanel);
            app.PreferenceSwitch_14Label.HorizontalAlignment = 'center';
            app.PreferenceSwitch_14Label.Position = [17 123 70 22];
            app.PreferenceSwitch_14Label.Text = 'Preference?';

            % Create PreferenceSwitchTWR
            app.PreferenceSwitchTWR = uiswitch(app.TWRPanel, 'slider');
            app.PreferenceSwitchTWR.Items = {'No', 'Yes'};
            app.PreferenceSwitchTWR.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchTWRValueChanged, true);
            app.PreferenceSwitchTWR.Position = [28 149 45 20];
            app.PreferenceSwitchTWR.Value = 'No';

            % Create Priority1highestKnob_14Label
            app.Priority1highestKnob_14Label = uilabel(app.TWRPanel);
            app.Priority1highestKnob_14Label.HorizontalAlignment = 'center';
            app.Priority1highestKnob_14Label.Enable = 'off';
            app.Priority1highestKnob_14Label.Position = [38 5 102 22];
            app.Priority1highestKnob_14Label.Text = 'Priority (1 highest)';

            % Create knobTWR
            app.knobTWR = uiknob(app.TWRPanel, 'discrete');
            app.knobTWR.Items = {'0', '0'};
            app.knobTWR.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchTWRValueChanged, true);
            app.knobTWR.Enable = 'off';
            app.knobTWR.Position = [55 31 60 60];
            app.knobTWR.Value = '0';

            % Create cstarPanel
            app.cstarPanel = uipanel(app.AutomateTradeStudyTab);
            app.cstarPanel.Title = 'cstar';
            app.cstarPanel.Position = [792 387 194 197];

            % Create Switchcstar
            app.Switchcstar = uiswitch(app.cstarPanel, 'toggle');
            app.Switchcstar.Items = {'Min', 'Max'};
            app.Switchcstar.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchcstarValueChanged, true);
            app.Switchcstar.Enable = 'off';
            app.Switchcstar.Position = [162 105 20 45];
            app.Switchcstar.Value = 'Min';

            % Create Lampcstar
            app.Lampcstar = uilamp(app.cstarPanel);
            app.Lampcstar.Position = [107 149 20 20];
            app.Lampcstar.Color = [1 0 0];

            % Create PreferenceSwitch_15Label
            app.PreferenceSwitch_15Label = uilabel(app.cstarPanel);
            app.PreferenceSwitch_15Label.HorizontalAlignment = 'center';
            app.PreferenceSwitch_15Label.Position = [17 123 70 22];
            app.PreferenceSwitch_15Label.Text = 'Preference?';

            % Create PreferenceSwitchcstar
            app.PreferenceSwitchcstar = uiswitch(app.cstarPanel, 'slider');
            app.PreferenceSwitchcstar.Items = {'No', 'Yes'};
            app.PreferenceSwitchcstar.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchcstarValueChanged, true);
            app.PreferenceSwitchcstar.Position = [28 149 45 20];
            app.PreferenceSwitchcstar.Value = 'No';

            % Create Priority1highestKnob_15Label
            app.Priority1highestKnob_15Label = uilabel(app.cstarPanel);
            app.Priority1highestKnob_15Label.HorizontalAlignment = 'center';
            app.Priority1highestKnob_15Label.Enable = 'off';
            app.Priority1highestKnob_15Label.Position = [38 5 102 22];
            app.Priority1highestKnob_15Label.Text = 'Priority (1 highest)';

            % Create knobcstar
            app.knobcstar = uiknob(app.cstarPanel, 'discrete');
            app.knobcstar.Items = {'0', '0'};
            app.knobcstar.ValueChangedFcn = createCallbackFcn(app, @PreferenceSwitchcstarValueChanged, true);
            app.knobcstar.Enable = 'off';
            app.knobcstar.Position = [55 31 60 60];
            app.knobcstar.Value = '0';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = SCRIPTVERSIONregenEngineTradesViewer

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end