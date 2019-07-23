% This routine calculates the exact locations of the Nodes of Ranvier based
% on the paths of the axon and their diameters.
clear all
addpath('plot_functions','tree_functions')
load nervetree.mat
model_data_tree
load mu_tree.mat

for i=1:length(MU_tree)
    n_fibers(i)=length(find(neuropoints(MU_tree{i,1},4)==5));
end
radius_dist=sqrt(n_fibers)*min_rad;
force=n_fibers/max(n_fibers);
% calculate the radius at each region in the tree based on the number of
% daughter nmj that each point has
for k=1:nMu
MU=cell2mat(MU_tree(k,1));
NMJ=find(neuropoints(MU,4)==5);
n=zeros(length(MU),1);
n(NMJ)=1;
for i=1:length(MU)-1
    parent=neuropoints(MU(end+1-i),5);
    add=n(end+1-i);
    n=n+double(MU==parent)*add;
end
radius{k,1}=sqrt(n)*min_rad;
end
% create nodes of ranvier
for i=1:nMu
    i
MU=cell2mat(MU_tree(i));
rad=cell2mat(radius(i));
order=cell2mat(MU_tree(i,2));
%%%%%%%%%%%%%%%%%%%%%%% major branch
major=find(order<3);
points=neuropoints(MU(major),1:3);
% first segment
p1=points(1,:);
p2=points(2,:);
dist=distance3D(p1,p2);
dir=calculate_direction(p1,p2);
in_dist=internodal_dist*2*rad(1);
nodes=floor(dist/in_dist);
remaining=dist-nodes*in_dist;
Axon(1,:)=p1;
for j=1:nodes
Axon(j+1,:)=p1+j*dir*in_dist;
end
Axon_rad=ones(size(Axon,1),1)*rad(1);
% % other segments
for k=2:length(points)-1
    p1=points(k,1:3);
    p2=points(k+1,1:3);
    dist=distance3D(p1,p2)+remaining;
    dir=calculate_direction(p1,p2);
    in_dist=internodal_dist*2*rad(k);
    nodes=floor(dist/in_dist);
    new(1,:)=p1+(in_dist-remaining)*dir;
    remaining=dist-nodes*in_dist;
    for j=2:nodes
    new(j,1:3)=new(j-1,1:3)+in_dist*dir;
    end
    Axon=vertcat(Axon,new);
    Axon_rad=vertcat(Axon_rad,ones(size(new,1),1)*rad(k));
    new=[];
end
Adjacent=zeros(length(Axon),1);
% % %%%%%%%%%%%%%%%%%%%%%%%%%%% minor branches
minor=find(order==3);
points=neuropoints(MU(minor),:);
branch_n=unique(points(:,8));
rad_1=rad(minor);
for l=1:length(branch_n)
    branch_points=find(points(:,8)==branch_n(l));
    sub_points=points(branch_points,1:3);
    sub_rad=rad_1(branch_points);
%     connect first point to the nearest node of the major branch
    index=find_nearest(sub_points(1,1:3),Axon);
%     first segment
    p1=Axon(index,:);
    p2=sub_points(1,:);
dist=distance3D(p1,p2);
dir=calculate_direction(p1,p2);
in_dist=internodal_dist*2*sub_rad(1);
nodes=floor(dist/in_dist);
remaining=dist-nodes*in_dist;
for j=1:nodes
new(j,:)=p1+j*dir*in_dist;
end
Axon=vertcat(Axon,new);
Axon_rad=vertcat(Axon_rad,ones(size(new,1),1)*sub_rad(1));
new=[];
%  other segments
for k=1:size(sub_points,1)-1
    p1=sub_points(k,1:3);
    p2=sub_points(k+1,1:3);
    dist=distance3D(p1,p2)+remaining;
    dir=calculate_direction(p1,p2);
    in_dist=internodal_dist*2*sub_rad(k);
    nodes=floor(dist/in_dist);
    new(1,:)=p1+(in_dist-remaining)*dir;
    remaining=dist-nodes*in_dist;
    for j=2:nodes
    new(j,1:3)=new(j-1,1:3)+in_dist*dir;
    end
    Axon=vertcat(Axon,new);
    Axon_rad=vertcat(Axon_rad,ones(size(new,1),1)*sub_rad(k));
    new=[];
end
Adjacent(end+1)=index;
Adjacent(end+1:length(Axon))=0;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% third level branches
minor=find(order==4);
points=neuropoints(MU(minor),:);
branch_n=unique(points(:,9));
rad_1=rad(minor);
for l=1:length(branch_n)
    branch_points=find(points(:,9)==branch_n(l));
    sub_points=points(branch_points,1:3);
    sub_rad=rad_1(branch_points);
    % connect first point to the nearest node of the major branch
    index=find_nearest(sub_points(1,1:3),Axon);
    % first segment
    p1=Axon(index,:);
    p2=sub_points(1,:);
dist=distance3D(p1,p2);
dir=calculate_direction(p1,p2);
in_dist=internodal_dist*2*sub_rad(1);
nodes=floor(dist/in_dist);
remaining=dist-nodes*in_dist;
for j=1:nodes
new(j,:)=p1+j*dir*in_dist;
end
Axon=vertcat(Axon,new);
Axon_rad=vertcat(Axon_rad,ones(size(new,1),1)*sub_rad(1));
new=[];
%  other segments
for k=1:size(sub_points,1)-1
    p1=sub_points(k,1:3);
    p2=sub_points(k+1,1:3);
    dist=distance3D(p1,p2)+remaining;
    dir=calculate_direction(p1,p2);
    in_dist=internodal_dist*2*sub_rad(k);
    nodes=floor(dist/in_dist);
    new(1,:)=p1+(in_dist-remaining)*dir;
    remaining=dist-nodes*in_dist;
    for j=2:nodes
    new(j,1:3)=new(j-1,1:3)+in_dist*dir;
    end
    Axon=vertcat(Axon,new);
    Axon_rad=vertcat(Axon_rad,ones(size(new,1),1)*sub_rad(k));
    new=[];
end
Adjacent(end+1)=index;
Adjacent(end+1:length(Axon))=0;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Neuromuscular Junctions
minor=find(order==5);
points=neuropoints(MU(minor),:);
% find parents
parents=neuropoints(points(:,5),:);
rad_1=rad(minor);
for l=1:length(minor)
    % search the closest node to the parent node
    index=find_nearest(parents(l,1:3),Axon);
    % first segment
    p1=Axon(index,:);
    p2=points(l,1:3);
dist=distance3D(p1,p2);
dir=calculate_direction(p1,p2);
in_dist=internodal_dist*2*rad_1(l);
nodes=floor(dist/in_dist);
for j=1:nodes
new(j,:)=p1+j*dir*in_dist;
end
Axon=vertcat(Axon,new);
Axon_rad=vertcat(Axon_rad,ones(size(new,1),1)*rad_1(l));
new=[];
Adjacent(end+1)=index;
Adjacent(end+1:length(Axon))=0;
end

Ranvier{i,1}=Axon; % positions of the nodes
Ranvier{i,2}=Adjacent; % adjacent nodes (branching points)
Ranvier{i,3}=Axon_rad; % axonal radius
Axon=[];
Adjacent=[];
Axon_rad=[];
end
save('Ranvier.mat','Ranvier','n_fibers')
clear all