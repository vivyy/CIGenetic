filename = 'risk_data.xlsx';
gen_factors =  xlsread(filename, 'D31:G101');
gen_perc = xlsread(filename,  'I32:I101');
i=1;


%% Risk Caution MLP %%
 
R1L1 = xlsread('neural_data.xlsx','R32:R101');
R1L2 = xlsread('neural_data.xlsx','V32:V101');
R1L3 = xlsread('neural_data.xlsx','Z32:Z101');
R1T = xlsread('neural_data.xlsx','AA32:AA101');
 
R2L1 = xlsread('neural_data.xlsx','AE32:AE101');
R2L2 = xlsread('neural_data.xlsx','AI32:AI101');
R2L3 = xlsread('neural_data.xlsx','AL32:AL101');
R2T = xlsread('neural_data.xlsx','AM32:AM101');

R3L1 = xlsread('neural_data.xlsx','AQ32:AQ101');
R3L2 = xlsread('neural_data.xlsx','AU32:AU101');
R3L3 = xlsread('neural_data.xlsx','AX32:AX101');
R3T = xlsread('neural_data.xlsx','AY32:AY101');
 
R1Input = [R1L1, R1L2, R1L3];
R2Input = [R2L1, R2L2, R2L3];
R3Input = [R3L1, R3L2, R3L3];
 
%%
                                %%%%%%%%%%%%%%%%
                             %%%%    GP MLP    %%%%
                                %%%%%%%%%%%%%%%%

 
for n= 6:10 
[res,testmse,testreg]= mlp_avg_mse(gen_factors,gen_perc,n,10);
Mse(i) = testmse;
Reg(i) = testreg;
Array{i} = res;
i=i+1;
end

Minimum = min(Mse);
for j= 1:i-1
    if (Mse(j) == Minimum)
        Min_Net = j;
    end
end
    MinCell = [];
    for p = 1:10
        MinCell(p) = Array{Min_Net}{p}.perf;
        
    end;
   [minimo, minimoindice] = min(MinCell);
   
   MinNet = Array{1,Min_Net}{1,minimoindice};
   
   plot((MinNeurons:MaxNeurons),Mse);
   
%% 
                            %%%%%%%%%%%%%%%%
                         %%%%  RISK 1 MLP  %%%%
                            %%%%%%%%%%%%%%%%

iterations = 10;
MinNeurons = 6;
MaxNeurons = 15;

Mse_R1(MaxNeurons-MinNeurons) = zeros;
Reg_R1(MaxNeurons-MinNeurons) = zeros;
Array_R1{1,MaxNeurons-MinNeurons} = zeros;

i=1;
for n= MinNeurons:MaxNeurons
[res_R1,testmse_R1,testreg_R1]= mlp_avg_mse(R1Input,R1T,n,iterations);
Mse_R1(i) = testmse_R1;
Reg_R1(i) = testreg_R1;
Array_R1{i} = res_R1;
i=i+1;
end
 
Minimum_R1 = min(Mse_R1);
for j= 1:i-1
    if (Mse_R1(j) == Minimum_R1)
        Min_Net_R1 = j;
    end
end
 
    MinCell_R1 (iterations) = zeros;
for p = 1:iterations
    MinCell_R1(p) = Array_R1{Min_Net_R1}{p}.perf;
end;
[minimo_R1, minimoindice_R1] = min(MinCell_R1);
   
MinNet_R1 = Array_R1{1,Min_Net_R1}{1,minimoindice_R1};
plot((MinNeurons:MaxNeurons),Mse_R1);

    
%% 
                            %%%%%%%%%%%%%%%%
                         %%%%  RISK 2 MLP  %%%%
                            %%%%%%%%%%%%%%%%

Mse_R2(MaxNeurons-MinNeurons) = zeros;
Reg_R2(MaxNeurons-MinNeurons) = zeros;
Array_R2{1,MaxNeurons-MinNeurons} = zeros;

i=1;
for n= MinNeurons:MaxNeurons 
[res_R2,testmse_R2,testreg_R2]= mlp_avg_mse(R2Input,R2T,n,iterations);
Mse_R2(i) = testmse_R2;
Reg_R2(i) = testreg_R2;
Array_R2{i} = res_R2;
i=i+1;
end
 
Minimum_R2 = min(Mse_R2);
for j= 1:i-1
    if (Mse_R2(j) == Minimum_R2)
        Min_Net_R2 = j;
    end
end
 
    MinCell_R2 (iterations) = zeros;
    for p = 1:iterations
        MinCell_R2(p) = Array_R2{Min_Net_R2}{p}.perf;
        
    end;
   [minimo_R2, minimoindice_R2] = min(MinCell_R2);
   
   MinNet_R2 = Array_R2{1,Min_Net_R2}{1,minimoindice_R2};
   
   plot((MinNeurons:MaxNeurons),Mse_R2);


%% 
                            %%%%%%%%%%%%%%%%
                         %%%%  RISK 3 MLP  %%%%
                            %%%%%%%%%%%%%%%%

Mse_R3(MaxNeurons-MinNeurons) = zeros;
Reg_R3(MaxNeurons-MinNeurons) = zeros;
Array_R3{1,MaxNeurons-MinNeurons} = zeros;
i=1;

for n= MinNeurons:MaxNeurons 
[res_R3,testmse_R3,testreg_R3]= mlp_avg_mse(R3Input,R3T,n,iterations);
Mse_R3(i) = testmse_R3;
Reg_R3(i) = testreg_R3;
Array_R3{i} = res_R3;
i=i+1;
end

 
Minimum_R3 = min(Mse_R3);
for j= 1:i-1
    if (Mse_R3(j) == Minimum_R3)
        Min_Net_R3 = j;
    end
end
 
    MinCell_R3 (iterations) = zeros;
    for p = 1:iterations
        MinCell_R3(p) = Array_R3{Min_Net_R3}{p}.perf;
        
    end;
   [minimo_R3, minimoindice_R3] = min(MinCell_R3);
   
   MinNet_R3 = Array_R3{1,Min_Net_R3}{1,minimoindice_R3};
   plot((MinNeurons:MaxNeurons),Mse_R3);
   
%%   
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%             Part II - Design of the Classifiers C1 & C2                 %           
%                                                                         %
%  Each classifier x is composed by three systems: MLPx, RBFx and ANFISx  %
%                                                                         %
%              Training the Systems: Step one - Supervised data           %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                              %%%%%%%%%%%%%%%%%%
                           %%%%% CLASSIFIER 1 %%%%%
                              %%%%%%%%%%%%%%%%%%

% Classifier 1 inputs
C1F1 = xlsread('neural_data.xlsx','K32:K101');
C1F2 = xlsread('neural_data.xlsx','L32:L101');
C1GP = xlsread('neural_data.xlsx','I32:I101');
C1F1T = C1F1';
C1F2T = C1F2';
C1GPT = C1GP';
inputsRBF1 = [C1F1T; C1F2T; C1GPT];
inputsMLP1 = [C1F1, C1F2, C1GP];
inputsANFIS1 = [C1F1 C1F2 C1GP];
% Classifier 1 targets
targetsRBF1 = xlsread('neural_data.xlsx','N32:N101');
targetsRBF1 = targetsRBF1';
targetsMLP1 = xlsread('neural_data.xlsx','N32:N101');
targetsANFIS1 = xlsread('neural_data.xlsx','N32:N101');



%% MLP1 %%
%%%%%%%%%%

iterations = 2;
n = rand();
MLP1Net = generateMLP(inputsMLP1,targetsMLP1,n,iterations);


%% RBF1 %%
%%%%%%%%%%

MaxNeurons = 50;
Spread = 0.5;
RBF1Net = GenerateRBF(inputsRBF1,targetsRBF1,MaxNeurons,Spread);

%%

%% ANFIS 1 %%
%%%%%%%%%%%%%

% Classifier 1 output

TrainData = [inputsANFIS1 targetsANFIS1];
NumMfs = 5;
MfType = 'gbellmf';
NumEpochs = 20;
InputFismat = genfis1(TrainData, NumMfs, MfType);
[ANFIS1,MseAnfis1] = anfis(TrainData, InputFismat, NumEpochs);
MinMSEAnfis1 = min(MseAnfis1);



%%
                              %%%%%%%%%%%%%%%%%%
                           %%%%% CLASSIFIER 2 %%%%%
                              %%%%%%%%%%%%%%%%%%
% Classifier 2 inputs
C2IR1 = xlsread('neural_data.xlsx','AA32:AA101'); % CLASSIFIER 2 INPUT RISK 1
C2IR2 = xlsread('neural_data.xlsx','AM32:AM101'); % CLASSIFIER 2 INPUT RISK 2
C2IR3 = xlsread('neural_data.xlsx','AY32:AY101'); % CLASSIFIER 2 INPUT RISK 3
C2IR1t = C2IR1';
C2IR2t = C2IR2';
C2IR3t = C2IR3';
inputsRBF2 = [C2IR1t; C2IR2t; C2IR3t];
inputsMLP2 = [C2IR1, C2IR2, C2IR3];
% Classifier 1 targets
targetsMLP2 = xlsread('neural_data.xlsx','BA32:BA101');
targetsRBF2 = targetsMLP2';



%% MLP2 %%
%%%%%%%%%%
iterations = 10;
MinNeurons = 6;
MaxNeurons = 15;

MLP1Net = generateMLP(inputsMLP1,targetsMLP1,MaxNeurons,MinNeurons,iterations);


%% RBF2 %%
%%%%%%%%%%

MaxNeurons = 50;
Spread = rand();
RBF2Net = GenerateRBF(inputsRBF2,targetsRBF2,Spread,MaxNeurons);


%% ANFIS 2 %%
%%%%%%%%%%%%%

% Classifier 2 inputs
R1T = xlsread('neural_data.xlsx','AA32:AA101');
R2T = xlsread('neural_data.xlsx','AM32:AM101');
R3T = xlsread('neural_data.xlsx','AY32:AY101');
inputsANFIS2 = [R1T R2T R3T];

% Classifier 2 output
C2OUT = xlsread('neural_data.xlsx','BA32:BA101');
TrainData = [inputsANFIS2 C2OUT];
NumMfs = 5;
MfType = 'gbellmf';
NumEpochs = 20;
InputFismat = genfis1(TrainData, NumMfs, MfType);
[ANFIS2,MseAnfis2] = anfis(TrainData, InputFismat, NumEpochs);
MinMSEAnfis2 = min(MseAnfis2);




%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                   Training the systems: Step two.                       %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                        %% MLP1 & MLP2 %%
outputMLP1 = MLP1Net(inputsMLP1);
NewTargetsMLP2 = outputMLP1;
MLP2Net = train(MLP2Net,inputsMLP2,NewTargetsMLP2);

outputMLP2 = MLP2Net(inputsMLP2);
NewTargetsMLP1 = outputMLP2;
MLP1Net = train(MLP1Net,inputsMLP1,NewTargetsMLP1);
                        
                        %% RBF1 & RBF2 %%
                        
% Unsupervised data (only inputs) --> RFB1 Output ---> Target of RBF2 
% --> Output of RBF2 --> Target of RBF1


outputRBF1 = RBF1Net(inputsRBF1); 
NewTargetsRBF2 = outputRBF1;
RBF2Net = train(RBF2Net,inputsRBF2,NewTargetsRBF2); 

outputRBF2 = RBF2Net(inputsRBF2);
NewTargetsRBF1 = outputRBF2;
RBF1Net = train(RBF1Net,inputsRBF1,NewTargetsRBF1);

                        %% ANFIS1 & ANFIS2 %%

%Part2 Generating Training Samples
Output1 = evalfis(inputsANFIS1,ANFIS1);
Output2 = evalfis(inputsANFIS2,ANFIS2);
% Training Samples for Classifier 1 are (InputsANFIS1,Output2)
%Training Samples for Classier 2 are(InputsANFIS2,Output1)

%Now we have to Train Six System with above Training Samples
%For Classifier 1[Training ANFIS1]
TrainData = [inputsANFIS1 Output2];
NumMfs = 5;
MfType = 'gbellmf';
NumEpochs = 20;
InputFismat = genfis1(TrainData, NumMfs, MfType);
ANFIS1Net = anfis(TrainData, InputFismat, NumEpochs);

% For Classifier 2
TrainData = [inputsANFIS2 Output1];
NumMfs = 5;
MfType = 'gbellmf';
NumEpochs = 20;
InputFismat = genfis1(TrainData, NumMfs, MfType);
ANFIS2Net = anfis(TrainData, InputFismat, NumEpochs);                      


                        

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                   Representation of the chromosome:                     %
%                                                                         %
%             |_r_|_MLP1_|_RBF1_|_ANFIS1_|_r_|_MLP2_|_RBF2_|_ANFIS2_|     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Chromo = cell(1,8);
Chromo{1,1} = randi([1,3],1,1);
Chromo{1,2} = MLP1Net; % generateMLP
Chromo{1,3} = RBF1Net; % generateRBF
Chromo{1,4} = ANFIS1Net; %generateANFIS
Chromo{1,5} = randi([1,3],1,1);
Chromo{1,6} = generateMLP2Net; % generateMLP
Chromo{1,7} = generateRBF2Net; % generateRBF
Chromo{1,8} = ANFIS2Net; %generateANFIS

% Parameter for each function:
neurons = randi([MinNeurons,MaxNeurons],1,1); % Number of neurons for MLP
spread = rand(); % Spread value for RBF
MembershipFunctions = randi([3,7],1,1); % Number of mem. funct. for ANFIS

