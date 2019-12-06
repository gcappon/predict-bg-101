function plotResults()
    
    load(fullfile('temp','cgmDataRetained'));
    load(fullfile('temp','cgmDataPred'));
    
    figure;
    stairs(cgmData.Time,cgmData.Glucose,'r','linewidth',3);
    hold on
    stairs(cgmDataPred.Time,cgmDataPred.Glucose,'b','linewidth',3);
    xlabel('time (datetime)');
    ylabel('Glucose (mg/dL)');
    
    legend({'CGM data','Predicted CGM data'});
    
end