
figure,
plot(1e3*I_el,twitch,'b','LineWidth',2)
box off
xlabel('I(mA)')
% xlabel('Pulse length (\mus)')
ylabel('Normalized Twitch Force')
ylim([0 1])

pMu=sum(activity,1)/nMu*100;
figure,
plot(1e3*I_el,pMu,'k','LineWidth',1.5)
xlabel('I(mA)')
% xlabel('Pulse length (\mus)')
ylabel('Motor Units Recruited (%)')
ylim([0 100])
box off