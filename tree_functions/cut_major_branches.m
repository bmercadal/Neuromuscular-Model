function neuropoints=cut_major_branches(neuropoints)
% This function cuts the major branches at the last minor branch to remove
% the portion of the branch where no axon will pass through
nmajor=max(neuropoints(:,7));
major_nodes=find(neuropoints(:,4)==2);
max_major=major_nodes(end);
% find position of the last branching node
for i=1:nmajor
    intersections=find(neuropoints(:,7)==i & neuropoints(:,4)==3 & neuropoints(:,5)<(max_major+1));
    parents=neuropoints(intersections,5);    
    cut(i)=max(parents);
    last=max(find(neuropoints(:,7)==i & neuropoints(:,4)==2));
    if cut(i)==last
        cut(i)=0;
    end
end
% delete all nodes above last branching node
for i=1:nmajor
    if cut(i)>0
    branch_nodes=find(neuropoints(:,7)==i & neuropoints(:,4)==2);
    neuropoints(cut(i)+1:branch_nodes(end),:)=[];
    % adjust the parent column after deletion
    nodes_to_adjust=find(neuropoints(:,5)>branch_nodes(end));
    neuropoints(nodes_to_adjust,5)=neuropoints(nodes_to_adjust,5)-branch_nodes(end)+cut(i);
    cut=cut-branch_nodes(end)+cut(i);
    end
end