% This program estimate AOA for a given T_win
clear;

load('./x_t.mat');
load('./y_t.mat');
load('./theta_t.mat');  % not required here
load('./t_res.mat');
load('./RxSignalMag3.mat');

%% Generation of mean subtracted data = magS
% S = Mean subtracted signal magnitude data
% f_op = Operating frequency = 5.745 GHz
f_op = 5.745e9;
lambda = 3e8/f_op;
ttime = 10; %seconds
w_start = ttime - 0.2; %seconds
w_end = ttime + 0.2; %seconds

startPos = w_start/t_res + 1;
endPos = w_end/t_res + 1;

S = RxSignalMag(startPos:endPos,1);
magS = S - mean(S);  %mean subtracted data
L = length(magS);
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
f = (0:1/length(A_f):1-1/length(A_f)) * 1/t_res;
plot(f(1:100)*lambda,magAf(1:100)/max(magAf),'LineWidth',1.5,'color','black');


set(gca,'fontsize',12);
ylabel('$|A(f)|$');
xlabel('Normalized Frequency');


grid on;
box on;
axis tight;