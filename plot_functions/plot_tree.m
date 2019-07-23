close all
load('nervetree.mat')
model_data_tree
clf
Colors = {'k','k','b','r','g',[.5 .6 .7],'y',[.5 .6 .7],[.8 .2 .6]}; % Cell array of colors.


for i=2:size(neuropoints,1)
    parent_node=neuropoints(i,5);
    line([neuropoints(i,1) neuropoints(parent_node,1)],[neuropoints(i,2) neuropoints(parent_node,2)],[neuropoints(i,3) neuropoints(parent_node,3)],'LineWidth',(6-neuropoints(i,4))/1.5,'Color',Colors{neuropoints(i,7)+1})
end
axis equal
grid on
view(30,25)
