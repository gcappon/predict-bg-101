function evaluation = evaluate()
    
    %load cgm data and predicted cgm data
    load(fullfile('temp','cgmDataRetained'));
    load(fullfile('temp','cgmDataPred'));
    
    %synchronize data and cut
    data = synchronize(cgmData,cgmDataPred);
    idxFirst = find(data.Time == (data.Time(1)+minutes(PH)));
    idxLast = find(data.Time == (data.Time(end)-minutes(PH)));
    data = data(idxFirst:idxLast,:);
    
    %Compute metrics over synchronized data
    evaluation.predictionMetrics.RMSE = sqrt(nanmean((data.Glucose_cgmData-data.Glucose_cgmDataPred).^2));
    
    %Compute statistics
    evaluation.stats.nanNumerosity = sum(isnan(data.Glucose_cgmDataPred));
    evaluation.stats.dataLength = data.Time(end)-data.Time(1);
    
    %if a result directory does not exist, create it
    if(~exist('results'))
       mkdir('results');
    end 
    
    %Clear temporary data
    if(exist('temp'))
       rmdir('temp','s');
    end
    
    %Store evaluation for analysis
    save(fullfile('results','evaluation'),'evaluation');
    save(fullfile('results','cgmDataPred'),'cgmDataPred');
    
end