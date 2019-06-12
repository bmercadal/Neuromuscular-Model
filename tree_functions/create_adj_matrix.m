function adj_mat=create_adj_matrix(Axon,Adjacent)
% This function creates the matrix of adjacent nodes used to solve the
% voltage equations
adj_mat=sparse(size(Axon,1),size(Axon,1));
adj_mat(1,1:2)=[-1 1];
adj_mat(end,end-1)=1;
for j=2:size(Axon,1)-1;
    adj_mat(j,j-1)=1;
    adj_mat(j,j+1)=1;
end
    connected_nodes=find(Adjacent>0);
    % delete ones of consecutive unconnected nodes
    for j=1:length(connected_nodes);
        index=connected_nodes(j)-1;
        adj_mat(index,index+1)=0;
        adj_mat(index+1,index)=0;
    end   
    % add ones in connected nodes
    for j=1:length(connected_nodes);
    index=Adjacent(connected_nodes(j));
    adj_mat(connected_nodes(j),index)=1;
    adj_mat(index,connected_nodes(j))=1;
    end   
    % diagonal
    for j=2:size(Axon,1)
        adj_mat(j,j)=-sum(adj_mat(j,:));
    end
%     adj_mat=sparse(adj_mat);
end