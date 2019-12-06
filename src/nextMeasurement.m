function [nextTime, nextCgm] = nextMeasurement()
    
    switch nargin
        case 0
        otherwise
            error("nextMeasurement: Too many input arguments.");
    end
    
        
    if(~exist("temp"))
        error("nextMeasurement: No cgmData are currently retained.");
    end
        
    %load retained cgmData and currentimeIndex
    load(fullfile('temp','cgmDataRetained'));
    load(fullfile('temp','currentTimeIndex'));

    %increment currentTimeIndex by 1
    currentTimeIndex = currentTimeIndex + 1;
    save(fullfile('temp','currentTimeIndex'),'currentTimeIndex');

    %provide the next cgmData entry
    nextTime = cgmData.Time(currentTimeIndex);
    nextCgm = cgmData.Glucose(currentTimeIndex);
    
end