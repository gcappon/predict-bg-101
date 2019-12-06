function storePrediction(timePred,cgmPred)
    
    switch nargin
        case 2
        case 1
            error("storePrediction: Missing input arguments (timePred).");
        case 0
            error("storePrediction: Missing input arguments.");
        otherwise
            error("storePrediction: Too many input arguments.");
    end
    
        
    if(~exist("temp"))
        error("storePrediction: No cgmData are currently retained.");
    end
        
                
    %load currentTimeIndex, retained cgmData, and stored cgmDataPred 
    load(fullfile('temp','currentTimeIndex'));
    load(fullfile('temp','cgmDataRetained'));
    load(fullfile('temp','cgmDataPred'));

    %check if the provided timePred is valid: has to be equal to
    %the time previously provided + PH.
    if((cgmData.Time(currentTimeIndex)+minutes(PH)) ~= timePred)
        error("storePrediction: Provided timePred is invalid. Must be the one previously provided + PH minutes")
    end

    %insert the predicted value
    cgmDataPred.Glucose(currentTimeIndex) = cgmPred;
    save(fullfile('temp','cgmDataPred'),'cgmDataPred');

end