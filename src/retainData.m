function retainData(cgmData,PH)
%retainData is a function that safely retain CGM data to be used during the
%evaluation of the user-defined glucose prediction algorithm
%Input:
%   * cgmData: a timeTable which contains CGM readings in 2 columns, i.e.
%   Time, in datetime format, and Glucose, in double.
%   * PH: the prediction horizon, in a double format (in minutes).
%Output:
%   * Time: a vector, in a datetime format, that contains the timestamps
%   corresponging to the provided cgmData.
    
    % =============== Input consistency check =============================
    %check the number of inputs
    switch nargin
        case 2
        case 1
            error("retainData: Missing input argument (PH).");
        case 0
            error("retainData: Missing input arguments.");
        otherwise
            error("retainData: Too many input arguments.");
    end
    
    %check the type of the inputs
    if(~isa(cgmData,'timetable')) %check whether cgmData is a timeTable or not.
        error("retainData: Specified cgmData is not a timetable");
    end
    if(~isa(PH,'double')) %check whether PH is a double or not.
        error("retainData: Specified PH is not a double");
    end
    
    %check if cgmData has more than 1 attribute
    if(length(cgmData.Properties.VariableNames) > 1)
        error("retainData: Provided input argument has more than 1 attribute.");
    end
    if(isempty(cgmData.Properties.VariableNames))
        error("retainData: Provided input argument has no attribute.");
    end
    
    %check if cgmData's attribute is Glucose
    if(~(cgmData.Properties.VariableNames{1} == "Glucose"))
        error("retainData: Provided cgmData has no columns called 'Glucose'.");
    end
    
    %check if the provided timetable's Time contains NaT
    if(sum(isnat(cgmData.Time))>0)
        error("retainData: Provided cgmData Time contains one or more NaT.");
    end
    % =====================================================================
    
    % == Return cgmData.Time and retain cgmData, PH and currentTimeIndex ==
    
    %if a temporary directory exists yet, wipe it
    if(exist('temp'))
       rmdir('temp','s');
    end 
    mkdir('temp');
    
    %initialize currentTimeIndex
    currentTimeIndex = 0;
    
    %save
    save(fullfile('temp','cgmDataRetained'), 'cgmData','PH');
    save(fullfile('temp','currentTimeIndex'), 'currentTimeIndex');
    
    % ==== Initialize cgmDataPred vector ==================================
    cgmDataPred = cgmData;
    cgmDataPred.Time = cgmDataPred.Time + minutes(PH);
    cgmDataPred.Glucose(:) = nan;
    save(fullfile('temp','cgmDataPred'),'cgmDataPred');
    % =====================================================================
end