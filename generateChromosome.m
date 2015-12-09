function Chromosome = generateChromosome(max_n,min_n,inMLP1,inMLP2,tarMLP1,tarMLP2,inRBF1,inRBF2,tarRBF1,tarRBF2)

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
%%%%

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

Chromosome = struct;
Chromosome.r1 = randi([1,3],1,1);
Chromosome.MLP1 = MLP1Net;
Chromosome.RBF1Net = RBF1Net;
Chromosome.r2 = randi([1,3],1,1);
Chromosome.MLP2 = MLP2Net;
Chromosome.RBF1 = RBF2Net;


end
