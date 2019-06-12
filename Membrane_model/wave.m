% Written By Borja Mercadal in cunjunction with the following publication:
% Mercadal, B., Arena, C. B., Davalos, R. V. & Ivorra, A. Avoiding nerve stimu-
% lation in irreversible electroporation: A numerical modeling study. Physics in
% Medicine and Biology 62(2017).
function [step,dt,maxk]=wave(wtype,t_f,t_pulse,varargin)

    t1=1e-4;
    factor=200;
    s='monopolar';
if strcmp(wtype,s)==1
    dt=min(t_pulse/factor,0.5e-6);
    maxk=round(t_f/dt);
    t2=t1+t_pulse;
    burst=ssquare(t_pulse,dt,t_pulse,t_pulse/20); 
    step(1:round(t1/dt))=0;
    step(round(t1/dt)+1:round(t2/dt))=burst;
    step(round(t2/dt)+1:maxk)=0;
end
    s='bipolar';
if strcmp(wtype,s)==1
    tp=varargin{1};
    tdel=varargin{2};
    dt=tp/factor;
    maxk=round(t_f/dt);
    npulses=round(t_pulse/(2*tp));
    step(1:round(t1/dt))=0;
    if tdel>0
    t_pos=round(t1/dt)+1;
    for i=1:npulses
    t_of=t_pos+round(tp/dt);
    t_neg=t_of+round(tdel/dt);
    t_end=t_neg+round(tp/dt);
    step(t_pos:t_of-1)=ssquare(tp,dt,tp,tp/20);
    step(t_of:t_neg)=0;
    step(t_neg+1:t_end)=-ssquare(tp,dt,tp,tp/20);
    t_pos=t_end+round(tdel/dt);
    end
    step(t_end+1:maxk)=0;
    else
    t1=1e-4;
    t2=t1+t_pulse;
    burst=ssquare(t_pulse,dt,tp,tp/10); 
    step(1:round(t1/dt))=0;
    step(round(t1/dt)+1:round(t2/dt))=burst;
    step(round(t2/dt)+1:maxk)=0;    
    end
end

    s='assymetric';
if strcmp(wtype,s)==1
    tp=varargin{1};
    tdel=varargin{2};
    tn=varargin{3};
    dt=min(tp,tn)/factor;
    maxk=round(t_f/dt);
    t_pos=round(t1/dt)+1;
    step(1:round(t1/dt))=0;
    npulses=round(t_pulse/((tp+tn)));
    for i=1:npulses
    t_of=t_pos+round(tp/dt);
    t_neg=t_of+round(tdel/dt);
    t_end=t_neg+round(tn/dt);
    step(t_pos:t_of-1)=ssquare(tp,dt,tp,tp/20);
    step(t_of:t_neg)=0;
    step(t_neg+1:t_end)=-ssquare(tn,dt,tn,tn/20);
    t_pos=t_end+round(tdel/dt);
    end
    step(t_end+1:maxk)=0;
end

