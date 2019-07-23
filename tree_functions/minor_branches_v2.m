function neuropoints=minor_branches_v2(neuropoints,n_minor_branches,muscle_radius,muscle_length,motor_endplate,step)
% major branches atract minor branches from points equally distributed. A
% wheight is assigned to each point of the branch using a normal
% probability distribution centered in a point of the branch randomly
% assigned
step=step/sqrt(n_minor_branches);
overlap=0;
% create equally distributed points for each minor branch
nmajor=max(neuropoints(:,7));
points=n_minor_branches*nmajor;
[r,theta]=sunflower(points,0);
r=r*muscle_radius*0.8;
nmajor=max(neuropoints(:,7));
ini_minor=max(neuropoints(:,8));
% divide the area in equal portions for each branch
r_c=muscle_radius/sqrt(nmajor);
rb1=r_c+(muscle_radius-r_c)*overlap;
rb2=r_c*(1-overlap);
dir=zeros(1,nmajor-1);
for i=1:nmajor-1
    branch_nodes=find(neuropoints(:,7)==i+1);
    xn=neuropoints(branch_nodes,1);
    yn=neuropoints(branch_nodes,2);
    dir(i)=mean(atan2(yn,xn));
end
dir=rem(dir+2*pi,2*pi);
delta=pi/4*overlap;
vecdir=[cos(dir);sin(dir)]';
thetab(1,:)=[atan2(vecdir(1,2)+vecdir(nmajor-1,2),vecdir(1,1)+vecdir(nmajor-1,1)) atan2(vecdir(1,2)+vecdir(2,2),vecdir(1,1)+vecdir(2,1)) ];
for i=2:nmajor-2
thetab(i,:)=[atan2(vecdir(i,2)+vecdir(i-1,2),vecdir(i,1)+vecdir(i-1,1)) atan2(vecdir(i,2)+vecdir(i+1,2),vecdir(i,1)+vecdir(i+1,1)) ];
end
thetab(nmajor-1,:)=[atan2(vecdir(nmajor-2,2)+vecdir(nmajor-1,2),vecdir(nmajor-2,1)+vecdir(nmajor-1,1)) atan2(vecdir(1,2)+vecdir(nmajor-1,2),vecdir(1,1)+vecdir(nmajor-1,1)) ];


thetab(:,1)=thetab(:,1)-delta;
thetab(:,2)=thetab(:,2)+delta;

xb=muscle_radius*cos(thetab);
yb=muscle_radius*sin(thetab);


% find the sectors in which each point is contained
sectors=zeros(length(r),nmajor);

% central branch
for i=1:length(r)
sectors(i,1)=r(i)<=rb1;
end
% lateral branches
for k=2:nmajor
    v1=[xb(k-1,1) yb(k-1,1)];
    v2=[xb(k-1,2) yb(k-1,2)];
    for i=1:length(r)
        if r(i)>rb2
            x=r(i)*cos(theta(i));
            y=r(i)*sin(theta(i));
            cross1=v1(1)*y-v1(2)*x;
            cross2=v2(1)*y-v2(2)*x;
            if cross1>0 && cross2<0
                sectors(i,k)=1;
            end
        end
    end
end


% assign randomly each point to a branch
wheigts=sectors./sum(sectors,2);
minor=zeros(1,points);
for i=1:points
    dummy=rand(1);
    if dummy<=wheigts(i,1)
        minor(i)=1;
    else
        a=wheigts(i,1);
        for k=2:nmajor
            if dummy<=a+wheigts(i,k) && dummy>a
                minor(i)=k;
            end
            a=a+wheigts(i,k);
        end
    end
end
for i=1:length(minor)
    branch_nodes=find(neuropoints(:,7)==minor(i)& neuropoints(:,4)==2);
    r_branch=neuropoints(branch_nodes,1:3);
    dummy=ceil(rand(1)*(length(branch_nodes)-0.5));
    weight=zeros(length(branch_nodes),1);
    weight(1:dummy)=1;
    z=muscle_length*motor_endplate(1)*0.66;
    r_0=[r(i)*cos(theta(i)) r(i)*sin(theta(i)) z];
    dist=zeros(length(branch_nodes),3);
    for k=1:3
        for j=1:length(branch_nodes)
    dist(j,k)=r_branch(j,k)-r_0(k);
        end
    end
    modulus=sqrt(dist(:,1).^2+dist(:,2).^2+dist(:,3).^2);
    unit=dist./modulus;
    level=1;
    new(level,1:3)=r_0;
    new(level,4:8)=[3 0 0 minor(i) i+ini_minor];
    while min(modulus)>step
        level=level+1;
    force=sum(weight.*unit./modulus.^2);
    force_mod=norm(force);
    x=r_0(1)+force(1)*step/force_mod;
    y=r_0(2)+force(2)*step/force_mod;
    z=r_0(3)+force(3)*step/force_mod;
    new(level,1:3)=[x y z];
    new(level,4:8)=[3 0 0 minor(i) i+ini_minor];
    r_0=[x y z];
    for k=1:3
        for j=1:length(branch_nodes)
    pos=r_0(k);
    dist(j,k)=[r_branch(j,k)-r_0(k);];
        end
    end
    modulus=sqrt(dist(:,1).^2+dist(:,2).^2+dist(:,3).^2);
    unit=dist./modulus;
    end
    new=flip(new,1);
    [A,I]=min(modulus);
    parent=branch_nodes(I);
    new(1,5)=parent;
    new(1,6)=neuropoints(parent,6)+1;
    last=size(neuropoints,1);
    for k=2:size(new,1)
        new(k,5)=last+k-1;
        new(k,6)=new(k-1,6)+1;
    end
    neuropoints=vertcat(neuropoints,new);
    % expand branch vertically
    new=[];
    x=neuropoints(end,1);
    y=neuropoints(end,2);
    z=neuropoints(end,3);
    k=1;
    level=neuropoints(end,6);
    parent=size(neuropoints,1);
    while z<muscle_length*motor_endplate(1)*0.85
    z=z+step;
    new(k,1:3)=[x y z];
    new(k,4:8)=[3 parent level minor(i) i+ini_minor];
    level=level+1;
    k=k+1;
    parent=parent+1;
    end
    neuropoints=vertcat(neuropoints,new);
    new=[];
    r_branch=[];
    branch_nodes=[];
    dist=[];
    modulus=[];
    unit=[];
        
end   
end   