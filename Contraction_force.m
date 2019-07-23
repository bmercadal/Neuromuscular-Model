% This routine calculates the response of each axon to an electrical
% stimulus. The relative twitch force is calculated by adding the muscle
% fibers from all MUs that have been activated by the electrical stimulus
% and dividing that by the total number of muscle fibers.
clear all
tic
addpath('plot_functions','tree_functions','Membrane_model')
load Ranvier.mat
model_data_tree

%% model parameters
rho=5; % muscle resistivity
el_pos=[0.05 0 0.005]; % position of the electrode
t_pulse=250e-6; % pulse length
force=n_fibers/sum(n_fibers); % relative force of each MU
% I_el=1e-3*(0:0.125:1.5); % electrode current
I_el=0.3;
%%
activity=zeros(nMu,length(I_el));
for k=1:length(I_el)
k     
for i=1:nMu
    i
Axon=cell2mat(Ranvier(i,1));
Adjacent=cell2mat(Ranvier(i,2));
Radius=cell2mat(Ranvier(i,3));

% calculate voltages
dist=zeros(size(Axon,1),1);
for j=1:size(Axon,1)
dist(j)=distance3D(Axon(j,:),el_pos);    
end
Voltage=-(rho*I_el(k)./(4*pi*dist))';
dist=[];
% generate adjacency matrix
adj_mat=create_adj_matrix(Axon,Adjacent);
% calculate MU response
activity(i,k) = neuron_response(Voltage,adj_mat,2*Radius,t_pulse);
Voltage=[];
end
toc
end
toc
twitch=sum(force'.*activity);
