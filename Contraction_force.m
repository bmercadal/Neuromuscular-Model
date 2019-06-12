clear all
tic
addpath('plot_functions','tree_functions','Membrane_model')
load Ranvier.mat
model_data_tree
rho=5;
el_pos=[0.05 0 0.01]
t_pulse=250e-6;
force=n_fibers/sum(n_fibers);
I_el=1e-3*(0:0.125:1.5);
activity=zeros(nMu,length(I_el));
for k=1:length(I_el)
k     
parfor i=1:nMu
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
