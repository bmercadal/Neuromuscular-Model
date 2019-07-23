% This routine creates the intramuscular nerve spatial distribution
tic
close all
%load model data and add folders to the path
model_data_tree
addpath('plot_functions','tree_functions')
neuropoints=[];
order=1;
step = min_rad*internodal_dist*sqrt(1000);
neuropoints(1,:)=[0 0 0 1 0 1 0 0];
neuropoints(2,:)=[0 0 muscle_length/25 1 1 2 0 0];
%create major branches
neuropoints=major_branches(2,neuropoints,n_major_branches,muscle_radius,muscle_length,motor_endplate,step);
% expand minor branches
neuropoints=minor_branches_v2(neuropoints,n_minor_branches,muscle_radius,muscle_length,motor_endplate,step);
% cut the major branches at the last minor branch
neuropoints=cut_major_branches(neuropoints);
% create third level branches
neuropoints=third_level_branches_v4(neuropoints,muscle_radius,muscle_length,motor_endplate);
% create neuromuscular junctions
neuropoints=neuromuscular_junctions_v2(neuropoints,nMu,nNMJ,muscle_radius,muscle_length,motor_endplate);
toc
save('nervetree.mat','neuropoints')
clear all
%% Description of the vector neuropoints:
% index / meaning
% 1 / x positions
% 2 / y positions
% 3 / z positions
% 4 / branch level (major,minor...)
% 5 / parent node
% 6 / level 
% 7 / major branch index to which the point belongs
% 8 / minor branch index to which the point belongs
% 9 / third level branch index to which the point belongs
