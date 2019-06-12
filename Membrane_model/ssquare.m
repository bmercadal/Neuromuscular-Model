% Written By Borja Mercadal in cunjunction with the following publication:
% Mercadal, B., Arena, C. B., Davalos, R. V. & Ivorra, A. Avoiding nerve stimu-
% lation in irreversible electroporation: A numerical modeling study. Physics in
% Medicine and Biology 62(2017).
function s=ssquare(length,dt,tsq,t_rise)
t=dt:dt:length;

f=1/(2*tsq);
delta=t_rise/(tsq);

ref1=(1+sawtooth(2*pi*f*t+pi*delta/2))/2;
a = (ref1 < delta/2);
b = (ref1 >= delta/2 & ref1 < 0.5);
c = (ref1 >= 0.5 & ref1 < 0.5+delta/2);

rise = 2*ref1/delta;
fall = -2*(ref1-0.5)/delta+1;

nodd = a.*rise + b + c.*fall;
s = 2*nodd-1;

end