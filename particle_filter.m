% This code implements tracking of a single object using PF

dt = 1; % time step;
r = rateControl(1/dt);

reset(r);
simulationTime = 0;


%xInitial = 1; %in metres
%yInitial = 3; %in metres
%thetaInitial = -pi/2; %in radians
%v = 0.3 %metres/s

set(0,'defaulttextInterpreter','latex');
set(gca,'fontsize',12);
h = animatedline('Color','b','LineWidth',2,'Marker','s');


rx1 = animatedline('Color','r','MarkerSize',10,'Marker','o');
rx2 = animatedline('Color','r','MarkerSize',10,'Marker','o');
rx3 = animatedline('Color','r','MarkerSize',10,'Marker','o');

tx = animatedline('Color','r','MarkerSize',10,'Marker','x');
addpoints(rx1,5,5);
drawnow
addpoints(rx2,5,0);
drawnow
addpoints(rx3,0,0);
drawnow
addpoints(tx,0,5);
drawnow


% load data-files
load('./x_t.mat');
load('./y_t.mat');
load('./theta_t.mat');



axis([-1 6 -3 8]);

%thetaCurrent = thetaInitial;

addpoints(h,x_t(1,1),y_t(1,1));
drawnow




xo = zeros(10,2);
xo(1,1) = 1;
xo(1,2) = 3;

counter = 2;
while simulationTime < 10
   time = r.TotalElapsedTime; 
   disp(simulationTime);
   disp(time);
   simulationTime = simulationTime + dt;
   
   addpoints(h,x_t(counter,1),y_t(counter,1));
   drawnow
   
   
   xo(simulationTime+1,1) = x_t(counter,1);
   xo(simulationTime+1,2) = y_t(counter,1);
   grid on;
   box on;
   ax = gca;
   ax.Title.String = strcat('Simulation Time: ',num2str(simulationTime),' s');
   ax.XLabel.String = 'x(m)';
   ax.YLabel.String = 'y(m)';
   legend([h rx1 tx],'Actual position','Rx','Tx_{fix}');
   set(tx,'linestyle','none')
   set(rx1,'linestyle','none');
   %startValue = startValue + dt;
   counter = counter + 1000;
   waitfor(r);
    
end

%% Particle Filter Approach

I = 8000; %no.of particles
particle_state = zeros(I,3); %state of all particles
for i=1:I
    particle_state(i,1) = 0.5 + rand()*0.5;
    particle_state(i,2) = 2.5 + rand()*0.5;
    particle_state(i,3) = rand()*(2*pi);
end

% coordinates of Tx and Rx
TxPos = [0 5];
RxPos = [0 0;5 0;5 5];

est_state = zeros(1,3);  

trackOP = animatedline('Color',[0.8500 0.3250 0.0980],'MarkerSize',10,'Marker','s','LineWidth',2);




reset(r);
% Loop for each tracking instant
for j = 1:10
    probRx1 = calcProb(particle_state,TxPos,RxPos,1,j);
    probRx2 = calcProb(particle_state,TxPos,RxPos,2,j);
    probRx3 = calcProb(particle_state,TxPos,RxPos,3,j);
    probMat = probRx1 .* probRx2 .* probRx3;
    probMat = probMat/sum(probMat);
    
    est_state = 0 .* est_state;
    for i=1:I
        est_state = est_state + probMat(i,1) .* particle_state(i,:);
    end
    
    addpoints(trackOP,est_state(1,1),est_state(1,2));
    drawnow
    
    waitfor(r);
end



legend([h rx1 tx trackOP],'Actual position','Rx','Tx_{fix}','Estimated position');




