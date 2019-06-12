function newpoints=neuromuscular_junctions_v2(neuropoints,nMu,nNMJ,muscle_radius,muscle_length,motor_endplate)
% equally distributed points are defined for each muscle fiber
nNMJ=nNMJ*nMu;
endplate_volume=pi*muscle_radius^2*muscle_length*(motor_endplate(2)-motor_endplate(1));
% delta_z=4*(endplate_volume/nNMJ)^(1/3);
% slices=round(muscle_length/delta_z);
slices=2;
points=round(nNMJ/slices);
[r,theta]=sunflower(points,0);
% z_NMJ=linspace(muscle_length*motor_endplate(1),muscle_length*motor_endplate(2),slices);
j=1;
r=r*muscle_radius;
r_NMJ=zeros(slices*length(r),3);
band_height=muscle_length*(motor_endplate(2)-motor_endplate(1))*0.1;
v_height=muscle_length*(motor_endplate(2)-motor_endplate(1))-band_height;
for i=1:slices
slice_height=band_height*(i-1);
    for k=1:length(r)
    z_NMJ=(muscle_radius-r(k))/muscle_radius*v_height+motor_endplate(1)*muscle_length+slice_height;    
    r_NMJ(j,1:3)=[r(k)*cos(theta(k)) r(k)*sin(theta(k)) z_NMJ];
    j=j+1;
    end
    theta=theta+0.1;
end
%%
delta_z=muscle_length*motor_endplate(2)/8;
min_z=muscle_length*(motor_endplate(2)-motor_endplate(1));
%  This loop associates a point from the minor branches to each point
newpoints=zeros(slices*length(r),9);
for i=1:size(r_NMJ,1)
% calculate radial distances from the nmj to each branch;
minor_nodes=find(neuropoints(:,4)==4);
radial_dist=sqrt((r_NMJ(i,1)-neuropoints(minor_nodes,1)).^2+(r_NMJ(i,2)-neuropoints(minor_nodes,2)).^2);
z_dist=r_NMJ(i,3)-neuropoints(minor_nodes,3);
pos_nodes=find(radial_dist<muscle_radius/5 & z_dist>min_z & z_dist<delta_z);
% if isempty(pos_nodes)
%     pos_nodes=find(radial_dist<muscle_radius/4 & z_dist>muscle_radius/3 & z_dist<delta_z);
%     r_NMJ(i,:)
% %     [A,I]=min(radial_dist)
% %     parent(i)=minor_nodes(I)
% end
% if isempty(pos_nodes)
%     tot_dist=radial_dist.^2+z_dist.^2;
%     pos_nodes=find(z_dist>muscle_radius/3);
%     [A,I]=min(tot_dist(pos_nodes));
%     I=pos_nodes(I);
%     parent=minor_nodes(I);
% else
%     
    
% randomly assign a branch between those that have a maximum distance to
% the nmj% randomly assign a point of the branch where the sub branch will originate
node=randsample(pos_nodes,1);
parent=minor_nodes(node);
% end
% join the nmj to the assigned branch at a random point
newpoints(i,1)=r_NMJ(i,1);
newpoints(i,2)=r_NMJ(i,2);
newpoints(i,3)=r_NMJ(i,3);
newpoints(i,4)=5;
newpoints(i,5)=parent;
newpoints(i,6)=neuropoints(parent,6)+1;
newpoints(i,7)=neuropoints(parent,7);
newpoints(i,8)=neuropoints(parent,8);
newpoints(i,9)=neuropoints(parent,9);
end 
newpoints=vertcat(neuropoints,newpoints);
end