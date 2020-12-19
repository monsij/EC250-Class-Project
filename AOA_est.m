%% AOA Estimation Main Implementation
clear all;
clc;
%data_path = 'E:\Documents\GradSchools\UCSB\F20\Courses\EC250 Project\AoA_data\chemLawn_3tx_equalpower_0deg.mat';
%load(data_path);

[filename, path] = uigetfile('*.mat','Enter file name',' ');
load(strcat(path, filename));

%% Data Description ( & expected results)
% No.of sources(incl. ref) = 3
% Dominant reference = NO
% Orientation (\Omega) = 0 degrees
% S = Mean subtracted signal magnitude data
% f_op = Operating frequency = 5.745 GHz
L = size(S,2); %length of the signal
magS = S;
f_op = 5.745e9;
lambda = 3e8/f_op;

%% Autocorrelation of signal magnitude

A_corr = xcorr(magS);
% plot(A_corr(L:end));
% set(0,'defaulttextInterpreter','latex');
% set(gca,'fontsize',12);
% ylabel('$A_{corr}(\Delta)$');
% xlabel('$\Delta$');
% grid on;
% box on;
% axis tight;

%% FFT
A_f = fft(A_corr(L:end));
magAf = abs(A_f);
f = (0:1/length(A_f):1-1/length(A_f)) * 1/v * 1/ts * 100;
%plot(f(1:120)*lambda,magAf(1:120)/max(magAf),'LineWidth',1.5,'color',[0 0.4470 0.7410]);
%hold on;

%{
plot(0.6532,1,'Marker','o','MarkerSize',5,'MarkerFaceColor','r');
hold on;
plot(0.8710,0.7595,'Marker','o','MarkerSize',5,'MarkerFaceColor','r');
hold on;
plot(1.481,0.3275,'Marker','o','MarkerSize',5,'MarkerFaceColor','r');
%}

% for passive objects
plot(acos(1-(f(1:120)*lambda))*180/pi,magAf(1:120)/max(magAf),'LineWidth',1.5,'color',[0 0.4470 0.7410]);
hold on;

set(gca,'fontsize',12);
%ylabel('$|A(f)|$');
%xlabel('Normalized Frequency');

% for passive objects
xlabel('Angle (in degrees) $cos^{-1}(1-f)$');
ylabel('$|A(f)|$');
%47.25,66.2,85.27  %estimated values
%45,69.5,90        %ground-truth
grid on;
box on;
axis tight;
hold on;
xline(45,'LineStyle','--','Color','r','LineWidth',2);
hold on;
xline(69.5,'LineStyle','--','Color','r','LineWidth',2);
hold on;
xline(90,'LineStyle','--','Color','r','LineWidth',2);



%% Find all possible set of AOAs using two orientations of the receiver array
fprintf('AOA from 1st set of measurements\n');
psi_1 = findAllPossibleAngles([1.481,0.871,0.61],1,3);
for i=1:size(psi_1,1)
    fprintf(' %.3f ',acos(psi_1{i,1})*180/pi);
    fprintf('\n');
end

fprintf('\nAOA from 2nd set of measurements\n');
psi_2 = findAllPossibleAngles([1.741,1.088,0.653],0.8660,3);
for i=1:size(psi_2,1)
    fprintf(' %.3f ',acos(psi_2{i,1})*180/pi-30);
    fprintf('\n');
end










