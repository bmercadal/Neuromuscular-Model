% Written By Borja Mercadal in cunjunction with the following publication:
% Mercadal, B., Arena, C. B., Davalos, R. V. & Ivorra, A. Avoiding nerve stimu-
% lation in irreversible electroporation: A numerical modeling study. Physics in
% Medicine and Biology 62(2017).
function [m,h,n,s]=activation(m_old,h_old,n_old,s_old,v,Vr,dt)

u=1000.*(v+Vr);
dt=1000*dt;
[am,bm,ah,bh,an,bn,as,bs]=rateconstant(u,Vr);
m=m_old+dt.*(am.*(1-m_old)-bm.*m_old);
h=h_old+dt.*(ah.*(1-h_old)-bh.*h_old);
n=n_old+dt.*(an.*(1-n_old)-bn.*n_old);
s=s_old+dt.*(as.*(1-s_old)-bs.*s_old);
% u=1000.*(v+Vr);
% dt=1000*dt;
% [am,bm,ah,bh,an,bn,as,bs]=rateconstant(u,Vr);
% m=difer(am,bm,m_old,dt);
% h=difer(ah,bh,h_old,dt);
% n=difer(an,bn,n_old,dt);
% s=difer(as,bs,s_old,dt);
% function new=difer(a,b,old,dt)
% new=old+dt.*(a.*(1-old)-b.*old);
% end
end