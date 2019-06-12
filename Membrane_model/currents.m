% Written By Borja Mercadal in cunjunction with the following publication:
% Mercadal, B., Arena, C. B., Davalos, R. V. & Ivorra, A. Avoiding nerve stimu-
% lation in irreversible electroporation: A numerical modeling study. Physics in
% Medicine and Biology 62(2017).
function [INaf,IKs,INap,Ilk]=currents(v,Vr,m,h,n,s)

E=v+Vr;



gNaf=3e4;
gNap=100;
gK=800;
glk=70;



ENa = 0.05;
EK  = -0.090;
Elk=-0.090;


INaf=gNaf.*m.^3.*h.*(E-ENa);
IKs=gK.*s.*(E-EK);
INap=gNap.*n.^3.*(E-ENa);
Ilk=glk.*(E-Elk);

end

