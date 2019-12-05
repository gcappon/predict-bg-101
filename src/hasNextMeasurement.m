function hasIt = hasNextMeasurement()


    if(~exist("temp"))
    	error("nextMeasurement: No cgmData are currently retained.");
    end
    if(~exist(fullfile("temp","currentTimeIndex.mat")))
        error("nextMeasurement: No measurements have been initialized.");
    end
    
    load(fullfile('temp','currentTimeIndex'));
    load(fullfile('temp','cgmDataRetained'));
    
    if(currentTimeIndex < height(cgmData))
        hasIt = 1;
    else
        hasIt = 0;
    end
    
end
