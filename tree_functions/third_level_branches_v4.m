function newpoints=third_level_branches_v4(neuropoints,muscle_radius,muscle_length,motor_endplate)
% equally distributed points are defined for each muscle fiber
nmajor=max(neuropoints(:,7));
nminor=max(neuropoints(:,8));
nNMJ=nmajor*nminor*5;
slices=1;
points=round(nNMJ/slices);
[r,theta]=sunflower(points,2);
z_NMJ=muscle_length*(motor_endplate(1)+(motor_endplate(2)-motor_endplate(1))/2);
j=1;
r=r*muscle_radius*0.95;


r_NMJ=zeros(slices*length(r),3);
band_height=muscle_length*(motor_endplate(2)-motor_endplate(1))*0.1;
v_height=muscle_length*(motor_endplate(2)-motor_endplate(1))-band_height;
for i=1:slices
slice_height=band_height*(i-1);
    for k=1:length(r)
    z_NMJ=((muscle_radius-r(k))/(muscle_radius)*v_height+motor_endplate(1)*muscle_length+slice_height)*0.95;    
    r_NMJ(j,1:3)=[r(k)*cos(theta(k)) r(k)*sin(theta(k)) z_NMJ(i)];
    j=j+1;
    end
    theta=theta+0.1;
end
delta_z=muscle_length*motor_endplate(2)/2;
min_z=muscle_length*motor_endplate(2)/8;
%  This loop associates a point from the minor branches to each point
parent=zeros(size(r_NMJ,1),1);
for i=1:size(r_NMJ,1)
% calculate radial distances from the nmj to each branch;
minor_nodes=find(neuropoints(:,4)==3);
radial_dist=sqrt((r_NMJ(i,1)-neuropoints(minor_nodes,1)).^2+(r_NMJ(i,2)-neuropoints(minor_nodes,2)).^2);
z_dist=r_NMJ(i,3)-neuropoints(minor_nodes,3);
pos_nodes=find(radial_dist<muscle_radius/5 & z_dist>min_z & z_dist<delta_z);
if isempty(pos_nodes)
    pos_nodes=find(radial_dist<muscle_radius/4 & z_dist>min_z & z_dist<delta_z);
    %     [A,I]=min(radial_dist);
%     parent(i)=minor_nodes(I);
end
if isempty(pos_nodes)
    pos_nodes=find(radial_dist<muscle_radius/3 & z_dist>min_z & z_dist<delta_z);
%     [A,I]=min(radial_dist);
%     parent(i)=minor_nodes(I);
end
% randomly assign a branch between those that have a maximum distance to
% the nmj% randomly assign a point of the branch where the sub branch will originate
node=randsample(pos_nodes,1);
parent(i)=minor_nodes(node);
end
% end
% expand the branch from the minor branch to the point
neuropoints(:,9)=0;
for i=1:size(r_NMJ,1)
%calculate direction    
delta_x=r_NMJ(i,1)-neuropoints(parent(i),1);
delta_y=r_NMJ(i,2)-neuropoints(parent(i),2);
delta_z=r_NMJ(i,3)-neuropoints(parent(i),3);
dist=sqrt(delta_x^2+delta_y^2+delta_z^2);
dir=[delta_x/dist delta_y/dist delta_z/dist];
% divide the segment in 200 steps
n_segments=50;
delta=dist/n_segments;   
% create segment
parent_node=parent(i);
for k=1:n_segments
newpoints(1)=neuropoints(parent_node,1)+dir(1)*delta;
newpoints(2)=neuropoints(parent_node,2)+dir(2)*delta;
newpoints(3)=neuropoints(parent_node,3)+dir(3)*delta;
newpoints(4)=4;
newpoints(5)=parent_node;
newpoints(6)=neuropoints(parent_node,6)+1;
newpoints(7)=neuropoints(parent_node,7);
newpoints(8)=neuropoints(parent_node,8);
newpoints(9)=i;
neuropoints=vertcat(neuropoints,newpoints);
parent_node=size(neuropoints,1);
end 

end
    





newpoints=neuropoints;
end