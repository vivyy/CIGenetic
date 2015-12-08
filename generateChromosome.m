function Chromosome = generateChromosome(max_n,min_n,inMLP1,inMLP2,tarMLP1,tarMLP2,inRBF1,...
    inRBF2,tarRBF1,tarRBF2,inANFIS1,inANFIS2,tarANFIS1,tarANFIS2)

n = randi([min_n,max_n],1,1);
MLP1Net = generate_mlp(inMLP1,tarMLP1,n);
n = randi([min_n,max_n],1,1);
MLP2Net = generate_mlp(inMLP2,tarMLP2,n);

%% Train networks with unsupervised and supervised data

inMLP1 = inMLP1';
inMLP2 = inMLP2';

outputMLP1 = MLP1Net(inMLP1);
NewTargetsMLP2 = outputMLP1;
MLP2Net = train(MLP2Net,inMLP2,NewTargetsMLP2);

outputMLP2 = MLP2Net(inMLP2);
NewTargetsMLP1 = outputMLP2;
MLP1Net = train(MLP1Net,inMLP1,NewTargetsMLP1);
                        
%%
MaxNeurons = 50;
Spread = rand();
RBF1Net = GenerateRBF(inRBF1,tarRBF1,Spread,MaxNeurons);

Spread = rand();
RBF2Net = GenerateRBF(inRBF2,tarRBF2,Spread,MaxNeurons);

%% Train networks with unsupervised and supervised data
outputRBF1 = RBF1Net(inRBF1); 
NewTargetsRBF2 = outputRBF1;
RBF2Net = train(RBF2Net,inRBF2,NewTargetsRBF2); 

outputRBF2 = RBF2Net(inRBF2);
NewTargetsRBF1 = outputRBF2;
RBF1Net = train(RBF1Net,inRBF1,NewTargetsRBF1);
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This section will be modified with the correspond function for the 
% ANFIS systems 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ANFIS1
TrainData = [inANFIS1 tarANFIS1];
NumMfs = 5;
MfType = 'gbellmf';
NumEpochs = 20;
InputFismat = genfis1(TrainData, NumMfs, MfType);
[ANFIS1Net,MseAnfis1] = anfis(TrainData, InputFismat, NumEpochs);
MinMSEAnfis1 = min(MseAnfis1);

% ANFIS2

TrainData = [inANFIS2 tarANFIS2];
NumMfs = 5;
MfType = 'gbellmf';
NumEpochs = 20;
InputFismat = genfis1(TrainData, NumMfs, MfType);
[ANFIS2Net,MseAnfis2] = anfis(TrainData, InputFismat, NumEpochs);
MinMSEAnfis2 = min(MseAnfis2);

%Part2 Generating Training Samples
Output1 = evalfis(inANFIS1,ANFIS1Net);
Output2 = evalfis(inANFIS2,ANFIS2Net);
% Training Samples for Classifier 1 are (InputsANFIS1,Output2)
%Training Samples for Classier 2 are(InputsANFIS2,Output1)

%Now we have to Train Six System with above Training Samples
%For Classifier 1[Training ANFIS1]
TrainData = [inANFIS1 Output2];
NumMfs = 5;
MfType = 'gbellmf';
NumEpochs = 20;
InputFismat = genfis1(TrainData, NumMfs, MfType);
ANFIS1Net = anfis(TrainData, InputFismat, NumEpochs);

% For Classifier 2
TrainData = [inANFIS2 Output1];
NumMfs = 5;
MfType = 'gbellmf';
NumEpochs = 20;
InputFismat = genfis1(TrainData, NumMfs, MfType);
ANFIS2Net = anfis(TrainData, InputFismat, NumEpochs);           

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Chromosome = struct;
Chromosome.r1 = randi([1,3],1,1);
Chromosome.MLP1 = MLP1Net;
Chromosome.RBF1 = RBF1Net;
Chromosome.ANFIS1 = ANFIS1Net;
Chromosome.r2 = randi([1,3],1,1);
Chromosome.MLP2 = MLP2Net;
Chromosome.RBF2 = RBF2Net;
Chromosome.ANFIS2 = ANFIS2Net;

%%


end