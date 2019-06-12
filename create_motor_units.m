% We assume compartimentalization at major branches
clear all
load nervetree.mat
model_data_tree
% define motor unit pool
n = 1:1:nMu;
P = exp( log(forceRange).* (n-1) / (nMu-1));
P2=round(P*nMu*nNMJ/sum(P));

iteration=1
mean_dev=1000;
dev=zeros(nMu,1);
while mean_dev>0.05
A=ones(n_major_branches,nMu).*P2;
% we will force the largest motor units to distribute within the major
% branches
distribute=randsample(1:1:n_major_branches,n_major_branches,false);
for i=1:n_major_branches
    A(setdiff(1:end,distribute(i)),end+1-i)=0;
    A(setdiff(1:end,distribute(i)),end+1-i-n_major_branches)=0;
    A(setdiff(1:end,distribute(i)),end+1-i-2*n_major_branches)=0;
    A(setdiff(1:end,distribute(i)),end+1-i-3*n_major_branches)=0;
    A(setdiff(1:end,distribute(i)),end+1-i-4*n_major_branches)=0;
end

% randomly assign nmj to motor units
NMJ_nodes=find(neuropoints(:,4)==5);
MU_assigned=zeros(length(NMJ_nodes),1);
% we randomize the order at which nmj are assgined
randomization=randsample(1:1:length(NMJ_nodes),length(NMJ_nodes),false);
for i=1:length(NMJ_nodes)
    index=randomization(i);
    node=NMJ_nodes(index);
    mb=neuropoints(node,7);
    odds=A(mb,:)/sum(A(mb,:));
    MU_assigned(index)=randsample(n,1,true,odds);
    A(mb,MU_assigned(index))=A(mb,MU_assigned(index))-1;
    if A(mb,MU_assigned(index))<1
        A(mb,MU_assigned(index))=1e-10;
    end
    A(setdiff(1:end,mb),MU_assigned(index))=0;
end
for i=1:nMu
n_fibers(i)=length(find(MU_assigned==i));
end
n_fibers=sort(n_fibers);
dev=(n_fibers-P2)./P2;
mean_dev=mean(abs(dev))
iteration=iteration+1
end

mean(abs(dev))
figure(1)
plot(n_fibers);
hold on
plot(P2,'r')
figure(2)
plot(dev)

for i=1:nMu
    nodes=find(MU_assigned==i);
MU_NMJ{i,1}=NMJ_nodes(nodes);
MU_NMJ{i,2}=length(find(MU_assigned==i));
end

for i=1:nMu
    mu_points=MU_NMJ{i,1};
    MU_tree{i,1}=mu_points;
    for k=1:length(mu_points)          
    parent=neuropoints(mu_points(k),5);
    while parent>0
        MU_tree{i,1}=vertcat(MU_tree{i,1},parent);
        parent=neuropoints(parent,5);
    end
    end
    MU_tree{i,1}=unique(MU_tree{i,1});
    MU_tree{i,2}=neuropoints(MU_tree{i,1},4);
end
save('mu_tree.mat','MU_tree')
clear all