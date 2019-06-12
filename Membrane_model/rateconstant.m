% Written By Borja Mercadal in cunjunction with the following publication:
% Mercadal, B., Arena, C. B., Davalos, R. V. & Ivorra, A. Avoiding nerve stimu-
% lation in irreversible electroporation: A numerical modeling study. Physics in
% Medicine and Biology 62(2017).
function [am,bm,ah,bh,an,bn,as,bs]=rateconstant(v,Vr)

%% rate constants
% alpha_m
Aam=6.57;
Bam=-20.4;
Cam=10.3;
am=Aam*(v-Bam)./(1-exp((Bam-v)./Cam));
% beta_m
Abm=0.304;
Bbm=-25.7;
Cbm=9.16;
bm=Abm*(Bbm-v)./(1-exp((v-Bbm)./Cbm));
% alpha_h
Aah=0.34;
Bah=-114;
Cah=11;
ah=Aah*(Bah-v)./(1-exp((v-Bah)./Cah));
% beta_h
Abh=12.6;
Bbh=-31.8;
Cbh=13.4;
bh=Abh./(1+exp((Bbh-v)./Cbh));
% alpha_n
Aan=0.0353;
Ban=-27;
Can=10.2;
an=Aan*(v-Ban)./(1-exp((Ban-v)./Can));
% beta_n
Abn=0.000883;
Bbn=-34;
Cbn=10;
bn=Abn*(Bbn-v)./(1-exp((v-Bbn)./Cbn));
% alpha_s
Aas=0.3;
Bas=-53;
Cas=5;
as=Aas./(1+exp((Bas-v)./Cas));
% beta_s
Abs=0.03;
Bbs=-90;
Cbs=1;
bs=Abs*(Bbs-v)./(1-exp((v-Bbs)./Cbs));
% function a=alpha(v,A,B,C)
% a=A*(v-B)./(1-exp((B-v)./C));
% end
% function b=beta(v,A,B,C)
% b=A*(B-v)./(1-exp((v-B)./C));
% end
% function bh=betah(v,A,B,C)
% bh=A./(1+exp((B-v)./C));
% end
% 
% %% rate constants
% % alpha_m
% Aam=6.57;
% Bam=-20.4;
% Cam=10.3;
% am=alpha(v,Aam,Bam,Cam);
% % beta_m
% Abm=0.304;
% Bbm=-25.7;
% Cbm=9.16;
% bm=beta(v,Abm,Bbm,Cbm);
% % alpha_h
% Aah=0.34;
% Bah=-114;
% Cah=11;
% ah=beta(v,Aah,Bah,Cah);
% % beta_h
% Abh=12.6;
% Bbh=-31.8;
% Cbh=13.4;
% bh=betah(v,Abh,Bbh,Cbh);
% % alpha_n
% Aan=0.0353;
% Ban=-27;
% Can=10.2;
% an=alpha(v,Aan,Ban,Can);
% % beta_n
% Abn=0.000883;
% Bbn=-34;
% Cbn=10;
% bn=beta(v,Abn,Bbn,Cbn);
% % alpha_s
% Aas=0.3;
% Bas=-53;
% Cas=5;
% as=betah(v,Aas,Bas,Cas);
% % beta_s
% Abs=0.03;
% Bbs=-90;
% Cbs=1;
% bs=beta(v,Abs,Bbs,Cbs);
end