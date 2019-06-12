close all
load('Ranvier.mat')
model_data_tree
forceRange=20; % force difference between largest and smallest MU
n = 1:1:nMu;
P = exp( log(forceRange).* (n-1) / (nMu-1));
P2=round(P*nMu*nNMJ/sum(P));

n_fibers=sort(n_fibers);
twitch=n_fibers/min(n_fibers);
diameter=2*min_rad*sqrt(n_fibers);

figure(1)
plot(P2,'r','LineWidth',2)
hold on
% plot(n_fibers,'.','MarkerSize',8,'Color',[0 0 0])
plot(n_fibers,'.b','MarkerSize',8)
xlabel('Motor Unit Number')
ylabel('Number of Fibers')
box off

figure(2)
plot(twitch,'.b','MarkerSize',10)
xlabel('Motor Unit Number')
ylabel('Normalized Twitch Force')
box off

figure (3)
histogram(twitch,5,'Normalization','probability')
box off
ylabel('Proportion of Motor Units')
xlabel('Normalized Twitch Force')

figure (4)
histogram(1e6*diameter,7,'Normalization','probability')
box off
ylabel('Proportion of Motor Units')
xlabel('Axon Diameter (\mum)')





