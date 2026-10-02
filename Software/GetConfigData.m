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
%       string or char
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
% Document Version 1.0, former versions:
%   - <Later Version>
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
        args.configFile = []; % Should NOT be vector input
        args.configName = []; % Can be vector input
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

            % Checks if assigned argument was string or char - all
            %   arguments passed should be strings or chars
            if class(arg_val) == "string" || class(arg_val) == "char"

                % Initializes assigned arguments
                eval(append(arg_name, " = arg_val;"));
            else

                % If assigned argument was not string type
                error("Passed '%s' argument must be string or char types, but was passed as %s", arg_name, class(arg_val));
            end

        % If argument was unassigned, checks if it was optional
        elseif ~ismember(arg_name, optional_arg_names)
            
            % If unassigned argument was non-optional, throws error
            error("No input for non-optional '%s' argument", arg_name);
        end
    end

    splitChar = "%"; % Character denoting end of instructions section and beginning of configs.

    % Unit Conversions

    % Intermediate Calculations

    % Take out instructions header
    rawText = readlines(configFile);
    splitLineNumber = find(rawText == splitChar);
    allConfigsText = rawText(splitLineNumber + 1:end);
    % Get number of elements in configName
    % For counting them, must be strings
    if isstring(configName)
        numConfigNames = numel(configName);
    else
        numConfigNames = numel(string(configName));
    end
    data = repmat(struct, size(configName));

    % Take out everything except config. of interest, filtered by
    %   configName
    for i = 1:numConfigNames
        thisConfigName = configName(i);
        configStartLineNumber = find(allConfigsText == "\" + thisConfigName + "\");
        % Technically possible at this point for a valid string or char type
        % input to have been passed to configName that isn't in the configFile,
        % so check for that
        if isempty(configStartLineNumber)
            error("Config ""%s"" not found in ""%s""\n", thisConfigName, configFile);
        end
        remainingConfigsText = allConfigsText(configStartLineNumber:end);
        configEndLineNumber = find(remainingConfigsText == "\END\", 1);
        thisConfigText = remainingConfigsText(1:configEndLineNumber);
        % Remove header and footer lines
        thisConfigText = thisConfigText(2:end - 1);
        % Loop through lines
        for j = 1:length(thisConfigText)
            thisLine = thisConfigText(j);
            % Split line by spaces
            wordsOfLine = split(thisLine, " ");
            lastWord = wordsOfLine(3);
            lastValue = eval(lastWord + ";");
            % First "word" is this line's variable name
            varName = wordsOfLine(1);
            % Check if value is a string
            if ~isstring(lastValue)
                % If not, assign it to data struct
                data(i).(varName) = lastValue;
            else
                % If this line's value was a string, check for whether it was a
                % filename or "correlation"
                fileSearchMatches = dir(fullfile(pwd, "**", lastValue));
                % If any matches were folders, not files (because dir doesn't
                % know the difference), remove them
                fileSearchMatches = fileSearchMatches(~[fileSearchMatches.isdir]);
                if ~isempty(fileSearchMatches)
                    % If the string was a filename, read in its contents
                    cellData = readcell(fullfile(fileSearchMatches(1).folder, fileSearchMatches(1).name));
                    structFieldnames = cellData(1, :);
                    % Check if any elements in first row are empty- this
                    % sometimes happens when excel stores empty characters
                    % in cells that used to have values but don't anymore
                    structFieldnames = structFieldnames(~ismissing(structFieldnames));
                    numColumns = numel(structFieldnames);
                    % For this varName struct, make a field for each value in
                    % structFieldnames, and assign the values under it in that
                    % column in cellData to that field
                    for k = 1:numColumns
                        data(i).(varName).(structFieldnames{k}) = [cellData{2:end, k}]';
                    end
    
                % Or, if the string was "correlation"
                elseif lastValue == "correlation"
                    % Set value to "flagCorrelation" flag, as a string, that
                    % will signal for the calling subclass object to
                    % initialize/overwrite this value by running its
                    % correlation method for this variable.
                    data(i).(varName) = "flagCorrelation";
                else
                    data(i).(varName) = lastValue;
                end
            end
        end
    end

    % Final Calculations

    % Display Results and/or Plotting

    return;
end