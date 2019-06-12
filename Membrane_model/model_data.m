% Written By Borja Mercadal in cunjunction with the following publication:
% Mercadal, B., Arena, C. B., Davalos, R. V. & Ivorra, A. Avoiding nerve stimu-
% lation in irreversible electroporation: A numerical modeling study. Physics in
% Medicine and Biology 62(2017).
D=1e-5;     % fiber diameter
d=3.3e-6;    % node diameter
G=1e-6;   % nodal gap
rho_i=0.7;    % axoplasmic resistivity
rho_e=5;    % extracellular medium resistivity
cm=0.02;    % membrane capacitance
gm=304;   % membrane conductivity
L=1.150e-3;    % internodal distance

V_rest=-0.089015;   % resting TMV
% 
% eNa = (R*(273.15+T)/F)*log(NAo/NAi);
% eK  = (R*(273.15+T)/F)*log(Ko/Ki);