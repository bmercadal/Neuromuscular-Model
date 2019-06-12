
axon=cell2mat(Ranvier(55,1));
plot3(axon(:,1),axon(:,2),axon(:,3),'.','MarkerSize',4)
axis equal
xlim([-0.025 0.025])
ylim([-0.025 0.025])
zlim([0 0.11])