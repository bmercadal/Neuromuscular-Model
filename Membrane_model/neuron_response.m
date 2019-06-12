% Written By Borja Mercadal in cunjunction with the following publication:
% Mercadal, B., Arena, C. B., Davalos, R. V. & Ivorra, A. Avoiding nerve stimu-
% lation in irreversible electroporation: A numerical modeling study. Physics in
% Medicine and Biology 62(2017).
function activity= neuron_response(V_ext,adj_mat,D,t_pulse)
dn=0.33*D;    % node diameter
da=0.7*D;   % axon diameter
G=1e-6;   % nodal gap
rho_i=0.7;  % axoplasmic resistivity
cm=0.02;    % membrane capacitance
L=115*D;    % internodal distance
V_rest=-0.089015;   % resting TMV
Ga=pi*da.^2./(4*rho_i*L);
Cm=cm*pi*dn*G;
t_f=1.4e-3;   % final time
nodes = length(V_ext); % Number of space steps

wtype = 'monopolar';
[step,dt,maxk]=wave(wtype,t_f,t_pulse);

Vm=zeros(maxk,nodes);
Vm(1,:)=0;
Vm(:,1)=0;
Vm(:,nodes)=0;

alpha=Ga*dt./(2*Cm);
M=alpha.*adj_mat;



%initializing values
m=zeros(maxk,nodes);
h=zeros(maxk,nodes);
n=zeros(maxk,nodes);
s=zeros(maxk,nodes);
Itot=zeros(maxk,nodes);
INaf=zeros(maxk,nodes);
IKs=zeros(maxk,nodes);
INap=zeros(maxk,nodes);
Ilk=zeros(maxk,nodes);

m(1,:)=0.0005;
h(1,:)=0.8249;
n(1,:)=0.0268;
s(1,:)=0.0049;
activity=0;
k=2;
while (activity<0.5 & k<(maxk-1))>0.5
% for k=2:maxk
[m(k,:),h(k,:),n(k,:),s(k,:)]=activation(m(k-1,:),h(k-1,:),n(k-1,:),s(k-1,:),Vm(k-1,:),V_rest,dt);
[INaf(k,:),IKs(k,:),INap(k,:),Ilk(k,:)]=currents(Vm(k-1,:),V_rest,m(k,:),h(k,:),n(k,:),s(k,:));
Itot(k,:)=INaf(k,:)+IKs(k,:)+INap(k,:)+Ilk(k,:);
Vm(k,:)=Vm(k-1,:)+(M*Vm(k-1,:)')'+(M*V_ext')'*step(k)-(pi*dn*G*dt./Cm)'.*Itot(k,:);
% Vm(k,:)=Vm(k-1,:)+(M*Vm(k-1,:)')'+(M*V_ext)'*step(k)-pi*dn.*G*dt./Cm.*Itot(k,:);
activity=ceil(max(m(k,:))-0.8);
k=k+1;
end
% 
% % activity = Vm
% act_nodes=max(m);
% % 1 if an AP is generated at that node 0 if not
% activity=ceil(max(act_nodes)-0.8);
end
% 1 if an action potential is activated somewhere along the axon
% probe=max(act_nodes);
% if probe>0.8
%     activity=1;
% else
%     activity=0;
% end

