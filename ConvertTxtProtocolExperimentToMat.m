

file_path = 'C:\AvisData\2018_08_01_11-55 Rat 20 - Remy.txt';

%open file  , and take the id of the pointer to it.
fid = fopen(file_path , 'rt');

%read the data of the txt file until the end of file.
tline = fgetl(fid);
current_parameter_struct = struct;
parameter_index = 1;
trial_num = 1;
first_trial = true;
savedInfo = struct;
while(ischar(tline))
%read line from the file one by constructing structures untill each
%'Trial#' apperas

    %split the field and value.
    splined_line = strsplit(tline , ':');
    field_name = splined_line(1);
    field_val = splined_line(2);
    
    %fill the parameter struct
    current_parameter_struct.name = field_name;
    current_parameter_struct.value = field_val;
    
    if(strcmp(field_name, 'Trial') == 1 && ~first_trial)
        savedInfo(trial_num).TrialData= trial_struct_array;
        %init the trial_struct_array
        parameter_index = 1;
        trial_num = trial_num + 1;
    else
        first_trial = false;
    end
    
    trial_struct_array(parameter_index) = current_parameter_struct;
    parameter_index = parameter_index + 1;
    
    tline = fgetl(fid)
end