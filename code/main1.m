% ===================================
% HOMEWORK 3B IN COMP.PHYS. - TASK 1
% ===================================
% By Victor Nilsson, Simon Nilsson
% 2016
%
% Length scale: 1 Å
% Time scale:   1 fs = 1e-15 s
% Energy scale: 1 eV

clear all, clc, close all

% ------ SIMULATION PARAMETERS ---------
hbar        = 1.054/1.602; % JS -> f eV s
d           = 0.5;
m           = 1.66/1.6*1e2;
p_0         = sqrt(0.1*2*m);
x_0         = 0;
dx          = 0.01;
n_points    = 1024;
dp          = 2*pi/(n_points*dx);


% ----------- VARIABLES ------------
% space samples
x = x_0 + dx*(0:n_points-1);
% and the corresponding samples in momentum space
p = dp*((0:n_points-1)-n_points/2);
% ---- Functions handles ----
Gaussian_Wave_Packet = @(x)1/(pi*d^2)^(1/4)*exp(-(x-x_0).^2/(2*d^2)).*exp(1i*p_0*(x-x_0)/hbar);
% Fourier transform obtained via Mathematica as the 'Inverse Fourier
% Transform', due to differences in FT defintion
Gaussian_Packet_Fourier = @(p)exp(-1i*p*x_0 - (d^2*(p*hbar - p_0).^2)./(2*hbar^2))*(pi*d^2)^(1/4);
% ---------------------------------

% Sample-discretize the wave packet function
wave_packet = Gaussian_Wave_Packet(x)*dx;
theoretic_prob = abs(Gaussian_Packet_Fourier(p)).^2;

prob = abs(wave_packet/dx).^2;
fft_prob_momentum = abs(fftshift(fft(wave_packet))).^2*dp;

% Plot prob.distr. in momentum space
figure(1); clf;
plot(p/p_0, fft_prob_momentum)
hold on
plot(p/p_0, theoretic_prob)
hold off
xlim([-5 5])
xlabel('Momentum / $p_0$', 'interpreter', 'latex', 'fontsize', 14)
ylabel('Probability distribution, $n_p(p)$','interpreter','latex', 'fontsize', 14)
title('Distribution of momentum for Hydrogen wave packet, $\psi(x;0)$','interpreter','latex','fontsize',14)
L = legend({'Numerically obtained via FFT', 'Analytically obtained via FT'},'interpreter','latex','fontsize',12);
set(L, 'location', 'northwest')

% Plot prob.distr. in normal space
figure(2); clf;
plot(x, prob)
xlim([0 4])
ylabel('Probability Distribution, $n_x(x-x_0)$','interpreter','latex', 'fontsize', 14)
xlabel('Position, $(x-x_0)$ / [\AA]', 'interpreter', 'latex', 'fontsize', 14)
title('Distribution of Hydrogen wave packet, $\psi(x;0)$','interpreter','latex','fontsize',14)