function RBFNet = GenerateRBF(inputsRBF,targetsRBF,Spread,MaxNeurons)

n = 1;
StepSize = 0.1;
TotalNetSet = 1/StepSize;

% Allocate arrays
RBFNetArray = cell(1,TotalNetSet);
RBFPerfArray(TotalNetSet) = zeros;

% Generate diferent networks for each Spread value
for i = 0.1:StepSize:1    
RBFNetArray{1,n} = newrb(inputsRBF,targetsRBF,0,Spread); % substitute Spread for i
RBFNetArray{1,n}.trainFcn = 'trainlm';
outputs = RBFNetArray{1,n}(inputsRBF);
RBFPerfArray(n) = perform(RBFNetArray{1,n},targetsRBF,outputs);
n = n+1; 
end

% Select the best network performance. 
BestPerf = min(RBFPerfArray);
for i = 1:TotalNetSet
if (RBFPerfArray(i) == BestPerf), RBFNet = RBFNetArray{1,i}; end
end

end 
