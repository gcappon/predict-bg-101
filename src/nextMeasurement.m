function [nextTime, nextCgm] = nextMeasurement(mode,cgmPred,timePred)
    
    switch nargin
        case 3
            if(mode ~= "prediction")
                error("nextMeasurement: Unknown mode for specified input arguments.");
            end
        case 2
            if(mode ~= "prediction")
                error("nextMeasurement: Unknown mode.");
            end
            error("nextMeasurement: Missing input arguments (tPred).");
        case 1
            if(mode ~= "init")
                error("nextMeasurement: Unknown mode for specified input arguments.");
            end
        case 0
            error("nextMeasurement: Missing input arguments.");
        otherwise
            error("nextMeasurement: Too many input arguments.");
    end
    
    if(mode == "init")
        
        %check existence of retained data
        if(~exist("temp"))
            error("nextMeasurement: No cgmData are currently retained.");
        end
        
        %initialize currentTimeIndex to 1 and save it
        currentTimeIndex = 1;
        save(fullfile('temp','currentTimeIndex'),'currentTimeIndex');
        
        %load retained data and provide the first cgmData entry
        load(fullfile('temp','cgmDataRetained'));
        nextTime = cgmData.Time(currentTimeIndex);
        nextCgm = cgmData.Glucose(currentTimeIndex);
        
        %initialize predicted cgmData timeTable
        cgmDataPred = cgmData;
        cgmDataPred.Glucose(:) = nan;
        save(fullfile('temp','cgmDataPred'),'cgmDataPred');
        
    end
    
    if(mode == "prediction") 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%TODO: manage time and fill a prediction vector
        
        if(~exist("temp"))
            error("nextMeasurement: No cgmData are currently retained.");
        end
        if(~exist(fullfile("temp","currentTimeIndex.mat")))
            error("nextMeasurement: No measurements have been initialized.");
        end
        
        if(hasNextMeasurement())
            %load currentTimeIndex and retained cgmData 
            load(fullfile('temp','currentTimeIndex'));
            load(fullfile('temp','cgmDataRetained'));
            
            %check if the provided timePred is valid: has to be equal to
            %the one previously provided.
            if(cgmData.Time ~= timePred)
                error("nextMeasurement (prediction mode): Provided timePred is invalid. You have to provide the same time and the previously obtained nextTime")
            end
            
            %load the cgmDataPred vector and insert the predicted value
            load(fullfile('temp','cgmDataPred'));
            cgmDataPred.Glucose(cgmDataPred.Time == timePred) = cgmPred;
            
            %increment currentTimeIndex by 1
            currentTimeIndex = currentTimeIndex + 1;
            save(fullfile('temp','currentTimeIndex'),'currentTimeIndex');

            %provide the next cgmData entry
            nextTime = cgmData.Time(currentTimeIndex);
            nextCgm = cgmData.Glucose(currentTimeIndex);
            
        end
    end
    
    
end