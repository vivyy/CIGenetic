function ANFISNet = GenerateANFIS(inputsANFIS1,targetsANFIS1,NumMfs,NumEpochs)
TrainData = [inputsANFIS1 targetsANFIS1];
MfType = 'gaussmf';  % Gaussian Membership functions
InputFismat = genfis1(TrainData, NumMfs, MfType); % Using Grid Partitioning
[ANFISNet MseAnfis1]  = anfis(TrainData, InputFismat, NumEpochs);
MinMSEAnfis1 = min(MseAnfis1);
end
