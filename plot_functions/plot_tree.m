close all
load('nervetree.mat')
model_data_tree
clf
Colors = {'k','k','b','r','g',[.5 .6 .7],'y',[.5 .6 .7],[.8 .2 .6]}; % Cell array of colors.
tree=neuropoints;
points=find(tree(:,4)<6);
neuropoints=[];
neuropoints=tree(points,:);
% figure,
% % % % % %  Plot with colors
for i=2:size(neuropoints,1)
    parent_node=neuropoints(i,5);
    line([neuropoints(i,1) neuropoints(parent_node,1)],[neuropoints(i,2) neuropoints(parent_node,2)],[neuropoints(i,3) neuropoints(parent_node,3)],'LineWidth',(6-neuropoints(i,4))/1.5,'Color',Colors{neuropoints(i,7)+1})
end
% for i=2:size(neuropoints,1)
%     parent_node=neuropoints(i,5);
%     line([neuropoints(i,1) neuropoints(parent_node,1)],[neuropoints(i,2) neuropoints(parent_node,2)],[neuropoints(i,3) neuropoints(parent_node,3)],'LineWidth',(6-neuropoints(i,4))/1.5,'Color',[0.65 0.65 0.65])
% end

% % draw circles at the bottom
% C1 = [0,0, 0] ;   % center of circle 
% R = muscle_radius ;    % Radius of circle 
% teta=0:0.01:2*pi ;
% x=C1(1)+R*cos(teta);
% y=C1(2)+R*sin(teta) ;
% z = C1(3)+zeros(size(x)) ;
% hold on
% plot3(x,y,z,'r')

% viscircles([0 0],muscle_radius)
% draw circles for the motor endplate
% C1 = [0,0, motor_endplate(1)*muscle_length] ;   % center of circle 
% R = muscle_radius ;    % Radius of circle 
% teta=0:0.01:2*pi ;
% x=C1(1)+R*cos(teta);
% y=C1(2)+R*sin(teta) ;
% z = C1(3)+zeros(size(x)) ;
% hold on
% plot3(x,y,z,'r')
% 
hold on
% nmj=find(neuropoints(:,4)==5);
% % plot3(neuropoints(nmj,1),neuropoints(nmj,2),neuropoints(nmj,3),'.r','Color',Colors{neuropoints(nmj,7)+1})
% scatter3(neuropoints(nmj,1),neuropoints(nmj,2),neuropoints(nmj,3),'MarkerType','.','Color',Colors{neuropoints(nmj,7)+1})
% 
% for i=1:length(nmj)
%   plot3(neuropoints(nmj(i),1),neuropoints(nmj(i),2),neuropoints(nmj(i),3),'.r','Color',Colors{neuropoints(nmj(i),7)+1}) 
%   hold on
% end
% plot3(0.015,0,0.041,'.r','MarkerSize',20)
% plot3(0.015,0,0.039,'.r','MarkerSize',20)

% C2 = [0,0, motor_endplate(2)*muscle_length] ;   % center of circle 
% R = muscle_radius ;    % Radius of circle 
% teta=0:0.01:2*pi ;
% x=C2(1)+R*cos(teta);
% y=C2(2)+R*sin(teta) ;
% z = C2(3)+zeros(size(x)) ;
% hold on
% plot3(x,y,z,'r')
axis equal
xlim([-0.025 0.025])
ylim([-0.025 0.025])
zlim([0 0.11])

grid on
view(0,90)
% view(0,90)