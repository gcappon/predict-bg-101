%% ============== Initialize workspace ====================================
    close all
    clear all
    clc

    addpath(genpath(fullfile('..','src'))); %add binary files to current source path
    
% =========================================================================

%% ============== Step 0: Load CGM data to test your algorithm on ========
    load(fullfile('data','data'));
    cgmData = cgmData(1:288,:);
% =========================================================================

%% ============== Step 1: Retain data and set PH ==========================
    PH = 30; %(min)
    retainData(cgmData,PH);
% =========================================================================

%% ============== Step 2: Obtain the first measurement ====================
    availableCgmMeas = [];
    availableTime = [];
    availableDataCount = 0;
% =========================================================================
   
%% == Step 3: Do predictions until data are available, and store them =====
    
    while(hasNextMeasurement())
        
        %Obtain next cgm measurement
        [nextTime, nextCgm] = nextMeasurement();
        
        % =========  Insert here the prediction "logic" =======================
        availableCgmMeas = [availableCgmMeas nextCgm];
        availableTime = [availableTime nextTime];
        availableDataCount = availableDataCount + 1;
        
        cgmPred = availableCgmMeas(availableDataCount) + 1; %really dumb logic
        timePred = availableTime(availableDataCount)+minutes(30);
        % =====================================================================
        
        %Store prediction
        storePrediction(timePred,cgmPred);
        
    end

% =========================================================================
   
%% ============== Step 4: Evaluate your prediction model ==================
    evaluation = evaluate();
    plotResults();
% =========================================================================


