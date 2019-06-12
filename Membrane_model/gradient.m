% Written By Borja Mercadal in cunjunction with the following publication:
% Mercadal, B., Arena, C. B., Davalos, R. V. & Ivorra, A. Avoiding nerve stimu-
% lation in irreversible electroporation: A numerical modeling study. Physics in
% Medicine and Biology 62(2017).
model_data
load('voltage_parallel_2cm.mat')
a=17.16;

nodes = length(V_ext);
dx = L;
for i=1:nodes-2;
    activation(i)=a*(V_ext(i)-2*V_ext(i+1)+V_ext(i+2))/dx^2;
end
