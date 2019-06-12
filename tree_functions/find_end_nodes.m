function [xb yb]=end_nodes(neuropoints)
nmajor=max(neuropoints(:,7));
for i=1:nmajor
branch=find(neuropoints(:,7)==i);
nminor=max(neuropoints(branch,8));
for k=1:nminor;
branch_nodes=find(neuropoints(:,7)==i & neuropoints(:,8)==k);
end_node(k)=branch_nodes(end);
end
xb(i)=mean(neuropoints(end_node,1);
yb(i)=mean(neuropoints(end_node,2);
end