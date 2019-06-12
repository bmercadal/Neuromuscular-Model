function newpoints=major_branches(node,neuropoints,n_major_branches,muscle_radius,muscle_length,motor_endplate,step)
% creates major branches (we assume that all of them branch at the same point)
max_r=muscle_radius/sqrt(n_major_branches);

% create the first point of all branches
prev_point=neuropoints(node,:);
l_branch= (0.2*randn(1)+1)*step;
new(1,:)=[0 0 l_branch 2 2 3 1 0];
delta_phi=2*pi/(n_major_branches-1);
for i=2:n_major_branches
l_branch= (0.2*randn(1)+1)*step;    
theeta= abs(-pi/2+pi*sum(rand(1,6),2)/6);
phi= delta_phi*(i-1);
xa = l_branch * sin(theeta) * cos(phi)+prev_point(1);
ya = l_branch * sin(theeta) * sin(phi)+prev_point(2);
za = l_branch * cos(theeta)+ prev_point(3);
new(i,:)=[xa ya za 2 2 3 i 0];
end
newpoints=vertcat(neuropoints,new);
new=[];
% expand central branch
major=1;
node=find(newpoints(:,7)==major);
prev_point=newpoints(node,:);
z_max=muscle_length*motor_endplate(1)*0.5;
za=0;
while za<z_max
l_branch=(0.2*randn(1)+1)*step;
theeta=abs(-pi/2+pi*sum(rand(1,6),2)/6)/10;
phi=2*pi*rand(1);
xa = l_branch * sin(theeta) * cos(phi)+prev_point(1);
ya = l_branch * sin(theeta) * sin(phi)+prev_point(2);
za = l_branch * cos(theeta)+ prev_point(3);
new(1:3)=[xa ya za];
new(4)=prev_point(4);
new(5)=node;
new(6)=prev_point(6)+1;
new(7)=major;
new(8)=0;
newpoints=vertcat(newpoints,new);
prev_point=new;
node=size(newpoints,1);
end

% expand lateral branches

for i=2:n_major_branches
major=i;
node=find(newpoints(:,7)==major);
prev_point=newpoints(node,:);
rad=sqrt((prev_point(1)^2+prev_point(2)^2));
za=0;    
while za<z_max
old=old_dir(newpoints,node);
l_branch=(0.2*randn(1)+1)*step;
theeta=(pi/2*sum(rand(1,6),2)/6)*(1-rad/max_r);
phi=old(3)+(-pi/2+pi*sum(rand(1,6),2)/6)/10;
xa = l_branch * sin(theeta) * cos(phi)+prev_point(1);
ya = l_branch * sin(theeta) * sin(phi)+prev_point(2);
za = l_branch * cos(theeta)+ prev_point(3);
rad=sqrt(xa^2+ya^2);
new(1:3)=[xa ya za];
new(4)=prev_point(4);
new(5)=node;
new(6)=prev_point(6)+1;
new(7)=major;
new(8)=0;
newpoints=vertcat(newpoints,new);
prev_point=new;
node=size(newpoints,1);
end
end

    
