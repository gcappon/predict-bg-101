%% ============== Initialize workspace ====================================
    close all
    clear all
    clc

    addpath(genpath(fullfile('..','src'))); %add binary files to current source path
    
% =========================================================================

%% ============== Step 0a: Load CGM data to test your algorithm on ========
    load(fullfile('data','data'));
% =========================================================================

%% ============== Step 0b: Load your prediction model ============+========
    load(fullfile('model','predictionModel'));
% =========================================================================

%% ============== Step 1: Retain data and set PH ==========================
    PH = 30; %(min)
    retainData(cgmData,PH);
% =========================================================================

%% ============== Step 2: Obtain the first measurement ====================
    [time0, cgm0] = nextMeasurement('init');
    availableCgmMeas = [cgm0];
    availableTime = [time0];
    availableDataCount = 1;
% =========================================================================
   
%% ============== Step 3: Do predictions until data are available =========
    

    while(hasNextMeasurement())

        % =========  Insert here the prediction "logic" =======================
        cgmPred = availableCgmMeas(availableDataCount) + 1; %really dumb logic
        timePred = availableTime(availableDataCount);
        % =====================================================================

        %obtain next cgm measurement
        [nextTime, nextCgm] = nextMeasurement("prediction",cgmPred,timePred);
        availableCgmMeas = [availableCgmMeas nextCgm];
        availableTime = [availableTime nextTime];
        availableDataCount = availableDataCount + 1

    end


