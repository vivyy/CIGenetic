function Chromosome = generateChromosome()

n = randi([min_n,max_n],1,1);
MLP1Net = generate_mlp(inputsMLP1,targetsMLP1,n);
n = randi([min_n,max_n],1,1);
MLP2Net = generate_mlp(inputsMLP2,targetsMLP2,n);

%% Train networks with unsupervised and supervised data
outputMLP1 = MLP1Net(inputsMLP1);
NewTargetsMLP2 = outputMLP1;
MLP2Net = train(MLP2Net,inputsMLP2,NewTargetsMLP2);

outputMLP2 = MLP2Net(inputsMLP2);
NewTargetsMLP1 = outputMLP2;
MLP1Net = train(MLP1Net,inputsMLP1,NewTargetsMLP1);
                        
%%
MaxNeurons = 50;
Spread = rand();
RBF1Net = GenerateRBF(inputsRBF1,targetsRBF1,Spread,MaxNeurons);
Spread = rand();
RBF2Net = GenerateRBF(inputsRBF2,targetsRBF2,Spread,MaxNeurons);

%% Train networks with unsupervised and supervised data
outputRBF1 = RBF1Net(inputsRBF1); 
NewTargetsRBF2 = outputRBF1;
RBF2Net = train(RBF2Net,inputsRBF2,NewTargetsRBF2); 

outputRBF2 = RBF2Net(inputsRBF2);
NewTargetsRBF1 = outputRBF2;
RBF1Net = train(RBF1Net,inputsRBF1,NewTargetsRBF1);
%%

Chromosome = struct;
Chromosome.r1 = randi([1,3],1,1);
Chromosome.MLP1 = MLP1Net;
Chromosome.RBF1Net = RBF1Net;
Chromosome.r2 = randi([1,3],1,1);
Chromosome.MLP2 = MLP2Net;
Chromosome.RBF1 = RBF1Net;

%%


end
