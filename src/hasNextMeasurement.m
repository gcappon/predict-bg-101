function hasIt = hasNextMeasurement()

    %check whether the toolbox has been initialized
    if(~exist("temp"))
    	error("nextMeasurement: No cgmData are currently retained.");
    end
    
    %load retained data
    load(fullfile('temp','cgmDataRetained'));
    load(fullfile('temp','currentTimeIndex'));
    
    %check for data availability
    if(currentTimeIndex < height(cgmData))
        hasIt = 1;
    else
        hasIt = 0;
    end
    
end
