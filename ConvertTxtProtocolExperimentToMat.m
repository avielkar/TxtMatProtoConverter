function ConvertTxtProtocolExperimentToMat( file_path )
    %open file  , and take the id of the pointer to it.
    fid = fopen(file_path , 'rt');

    %read the data of the txt file until the end of file.
    tline = fgetl(fid);
    current_parameter_struct = struct;
    parameter_index = 1;
    trial_num = 1;
    first_trial = true;
    savedInfo = struct;
    trial_struct_array = struct;
    while(ischar(tline))
    %read line from the file one by constructing structures untill each
    %'Trial#' apperas

        %split the field and value.
        splined_line = strsplit(tline , ':');
        field_name = splined_line(1);
        field_val = splined_line(2);

        %fill the parameter struct
        current_parameter_struct.name = char(field_name);
        current_parameter_struct.value = char(field_val);
        [numeric_value , success]  = str2num(current_parameter_struct.value);
        if(success == 1)
            current_parameter_struct.value = numeric_value;
        end

        if(strcmp(field_name, 'Trial') == 1 && ~first_trial)
            savedInfo(trial_num).TrialData= trial_struct_array;
            %init the trial_struct_array
            parameter_index = 1;
            trial_num = trial_num + 1;
            trial_struct_array = struct;
        else
            first_trial = false;
        end

        %save the parameter to the ciurrent trial.
        trial_struct_array.Param(parameter_index).name = current_parameter_struct.name;
        trial_struct_array.Param(parameter_index).value = current_parameter_struct.value;
        parameter_index = parameter_index + 1;

        tline = fgetl(fid);
    end

    %save the data struct to a mat file.
    splitted_file_path= strsplit(file_path , 'txt');
    splitted_file_path_string = char(splitted_file_path);
    parsed_file_path = strcat(splitted_file_path_string , '.mat');
    save ( parsed_file_path , 'savedInfo');
