%%function output = perturb(input,max_range,min_range)

%% 10% perturbation
filename = 'neural_data.xlsx';
NewF1 =  xlsread(filename, 'D32:D81');
NewF2 =  xlsread(filename, 'E32:E81');
NewF3 =  xlsread(filename, 'F32:F81');
NewF4 =  xlsread(filename, 'G32:G81');
NewFs = [NewF1, NewF2, NewF3, NewF4];
%%
TENpert = 0.90 + (1.1-0.90).*rand(50,4);
TWENTYpert = 0.80 + (1.2-0.60).*rand(50,4);

PertNewFs = TENpert.*NewFs;
PertNewFs20 = TWENTYpert.*NewFs;


for i = 1:4
    for j = 1:50
    if (PertNewFs(j,i) > 1), PertNewFs(j,i)=1; end
    end
end
  
for i = 1:4
    for j = 1:50
    if (PertNewFs20(j,i) > 1), PertNewFs20(j,i)=1; end
    end
end
    
%% Plot results disturbing F1 and F4 %%

% Max 10% disturbance
close all
subplot(2,2,1), plot(NewF1,NewF4,'+'), title('F1 VS F4');
subplot(2,2,2), plot(PertNewFs(:,1),NewF4,'+'), title('PertF1 VS F4');
subplot(2,2,3), plot(NewF1,PertNewFs(:,4),'+'), title('F1 VS PertF4');
subplot(2,2,4), plot(PertNewFs(:,1),PertNewFs(:,4),'+'), title('PertF1 VS PertF4');

% Max 20% disturbance
figure
subplot(2,2,1), plot(NewF1,NewF4,'o'), title('F1 VS F4');
subplot(2,2,2), plot(PertNewFs20(:,1),NewF4,'o'), title('PertF1 VS F4');
subplot(2,2,3), plot(NewF1,PertNewFs20(:,4),'o'), title('F1 VS PertF4');
subplot(2,2,4), plot(PertNewFs20(:,1),PertNewFs20(:,4),'o'), title('PertF1 VS PertF4');

%% Plot results disturbing F2 and F3 %%
% Max 10% disturbance
close all
subplot(2,2,1), plot(NewF2,NewF3,'+'), title('F2 VS F3');
subplot(2,2,2), plot(PertNewFs(:,2),NewF3,'+'), title('PertF2 VS F3');
subplot(2,2,3), plot(NewF2,PertNewFs(:,3),'+'), title('F2 VS PertF3');
subplot(2,2,4), plot(PertNewFs(:,2),PertNewFs(:,3),'+'), title('PertF2 VS PertF3');

% Max 20% disturbance
figure
subplot(2,2,1), plot(NewF2,NewF3,'o'), title('F2 VS F3');
subplot(2,2,2), plot(PertNewFs20(:,2),NewF3,'o'), title('PertF2 VS F3');
subplot(2,2,3), plot(NewF2,PertNewFs20(:,3),'o'), title('F2 VS PertF3');
subplot(2,2,4), plot(PertNewFs20(:,2),PertNewFs20(:,3),'o'), title('PertF2 VS PertF3');