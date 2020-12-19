% Generation of dataset for received signal in the presence of moving
% passive objects with single Tx, single Rx

gamma =0.6;  %reflection coefficient of target
lambda = 3e8/(5.745e9);
Tx_fix = [0 5];
%Rx = [0 0];
%Rx = [5 0];
Rx = [5 5];
t = 0:0.001:15;
dt = 0.001; %time-step

% initial position of target at (1,3)
target(1,1) = 1;
target(1,2) = 3;

% velocity = 1m/s (constant)
v = 1;

% initial bearing 21 degrees.
theta = 21 * (pi/180);  
% Maintains previous time instant bearing with prob. P_c
P_c = 0.9;

%variables to save
x_t = zeros(length(t)+1,1);
y_t = zeros(length(t)+1,1);
theta_t = zeros(length(t)+1,1); %in radians

%set initial value 
theta_t(1,1)= theta;



% set target to pre-saved values
 load('./x_t.mat');
 load('./y_t.mat');
 target = zeros(length(x_t),2);
 target(:,1) = x_t;
 target(:,2) = y_t;

%{
for i=2:length(t)
    target(i,1) = target(i-1,1) + v*cos(theta)*dt;
    target(i,2) = target(i-1,2) + v*sin(theta)*dt;
    
    %theta_update
    if(rand()<0.9)
        theta = rand()*(pi);
    end
    theta_t(i,1) = theta;
end
%}


RxSignalMag = zeros(length(t),1);
for i=1:length(t)
    RxSignal = rGreen(Tx_fix,Rx,lambda) + rGreen(Tx_fix,target(i,:),lambda) * gamma * rGreen(target(i,:),Rx,lambda);
    RxSignalMag(i,1) = abs(RxSignal);
end

%x_t = target(:,1);
%y_t = target(:,2);

% saving data files
% save x_t_test.mat x_t
% save y_t_test.mat y_t 
% save theta_t.mat theta_t
save RxSignalMag3.mat RxSignalMag
function r = rGreen(sPos,dPos,wavelength)
    d = sqrt((sPos(1)-dPos(1))^2 + (sPos(2)-dPos(2))^2);
    r = (1/(4*pi*d)) * exp(1j*2*pi*d/wavelength);
end