% tree parameters
n_major_branches=4; %number of major branches
n_minor_branches=10; % number of minor branches (per major branch)
nMu=120;           % number of motor units
nNMJ=100;          % number of neuromuscular juntions (per MU)
% MU pool properties
forceRange=100; % force difference between largest and smallest MU
% muscle dimensions
muscle_length = 0.05; % total muscle length
muscle_radius=0.005; % radius at the center of the muscle
motor_endplate=[0.45 0.50]; % in % relative to the total muscle length 
%the values indicate the position at the muscle edges and the position at
%the center. Equal values would create a horizontal end-plate

% motor neuron properties
min_rad=5e-7; % minimum radius of the axons
internodal_dist=115; % factor multiplying the diameter 