function data = GetConfigData(args)
% Reads a config. file, searches for the config. by name, which is passed
% in as an argument, and returns a struct containing the data, or an
% identifier that indicates that property is calculated as the output of a
% method specific to that configs. subclass dependent on state conditions.
%                                                    Returns data as struct
% -------------------------------------------------------------------------
% Arguments
%   1) configFile = config. file name, pass as string
%   2) configName = name of specific config. in config. file, pass as
%       string
% -------------------------------------------------------------------------
% Dependencies
%   #) <Dependency Filepath>
% -------------------------------------------------------------------------
% Assumptions
%   #) <Assumption>
% -------------------------------------------------------------------------
% Sources
%   #) <Source>
% -------------------------------------------------------------------------
% MATLAB Version <Oldest Version>, also compatible with:
%   - <Later Version>
% -------------------------------------------------------------------------
% Developed by Alex Vance (AlexVance00 on Github)
% -------------------------------------------------------------------------

    % Allows arguments to be optional and assigned in the function call
    %   as in: FunctionTemplate(<arg_name> = <arg_val>, ...)

    % List all argument names
    arguments
        args.configFile = [];
        args.configName = [];
    end
    arg_name_list = fieldnames(args);

    % List those argument names which are optional in 1D string array
    optional_arg_names = [];

    % Makes variables out of args' fieldnames
    for i_fieldname = 1:length(arg_name_list)
        arg_name = arg_name_list{i_fieldname};
        arg_val = args.(arg_name);

        % Input Checking
        % Checks if this argument was assigned
        if ~isempty(arg_val) 

            % Checks if assigned argument was string - all arguments passed
            %   should be strings
            if class(arg_val) == "string"

                % Initializes assigned arguments
                eval(append(arg_name, " = arg_val;"));
            else

                % If assigned argument was not string type
                error("Passed '%s' argument must be string type, but was passed as %s", arg_name, class(arg_val));
            end

        % If argument was unassigned, checks if it was optional
        elseif ~ismember(arg_name, optional_arg_names)
            
            % If unassigned argument was non-optional, throws error
            error("No input for non-optional '%s' argument", arg_name);
        end
    end

    splitChar = "%"; % Character denoting end of instructions section and beginning of configs.
    data = struct;

    % Unit Conversions

    % Intermediate Calculations
    % Take out instructions header
    rawText = readlines(configFile);
    splitLineNumber = find(rawText == splitChar);
    allConfigsText = rawText(splitLineNumber + 1:end);
    % Take out everything except config. of interest, filtered by
    %   configName
    configStartLineNumber = find(allConfigsText == "\" + configName + "\");
    remainingConfigsText = allConfigsText(configStartLineNumber:end);
    configEndLineNumber = find(remainingConfigsText == "\end\", 1);
    thisConfigText = remainingConfigsText(1:configEndLineNumber);
    % Remove header and footer lines
    thisConfigText = thisConfigText(2:end - 1);
    % Loop through lines
    for i = length(thisConfigText)
        thisLine = thisConfigText(i);
        % Check if value is "varies"
        if ~containts(thisLine, "correlation")
            % If not, eval this variable and assign it to data struct
            eval(thisLine);
            % Split line by spaces
            wordsOfLine = split(thisLine, " ");
            % First "word" is this line's variable name
            varName = wordsOfLine(1);
            data.(varName) = eval(varName);
        else
            % If this line does contain "varies"
        end
    end

    % Final Calculations

    % Display Results and/or Plotting

    return;
end