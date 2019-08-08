clear; %Limpa todas as variáveis salvas no workspace
close all; %Fecha todos os gráficos abertos
clc; %Limpa o Command Window

%(J)     moment of inertia of the rotor     0.01 kg.m^2
%(b)     motor viscous friction constant    0.1 N.m.s
%(Ke)    electromotive force constant       0.01 V/rad/sec
%(Kt)    motor torque constant              0.01 N.m/Amp
%(R)     electric resistance                1 Ohm
%(L)     electric inductance                0.5 H


J = 0.01;
b = 0.1;
K = 0.01;
R = 1;
L = 0.5;
s = tf('s');


%%
%Sem atraso de transporte
motor_Tf = K/((J*s+b)*(L*s+R)+K^2);

motor_Tf
poles = pole(motor_Tf);
disp(poles)
linearSystemAnalyzer('step', motor_Tf, 0:0.1:5);
stepinfo(motor_Tf)
%%
%Com atraso de transporte de 1 segundo
motor_delay_Tf = K*exp(-1*s)/((J*s+b)*(L*s+R)+K^2)
motor_delay_Tf
poles = pole(motor_delay_Tf);
disp(poles)
linearSystemAnalyzer('step', motor_delay_Tf, 0:0.1:5);
stepinfo(motor_delay_Tf)
[y,t]= step(motor_delay_Tf); %get the response of the system to a step with amplitude SP
sserror=abs(1-y(end))
%%
%Com atraso de transporte de 1 segundousando a aproximação de Padé de
%1ºgrau(e^x = 2+x / 2-x).
motor_Pade_Tf = K*(2 - s)/(((J*s+b)*(L*s+R)+K^2)*(2 + s));

motor_Pade_Tf
poles = pole(motor_Pade_Tf);
disp(poles)
linearSystemAnalyzer('step', motor_Pade_Tf, 0:0.1:5);
[y,t]= step(motor_delay_Tf); %get the response of the system to a step with amplitude SP
sserror=abs(1-y(end))
%%
%saida como a posição
%motor_pos_Tf = K/(((J*s+b)*(L*s+R)+K^2)*s)
%motor_pos_Tf
%poles = pole(motor_pos_Tf);
%disp(poles)
%linearSystemAnalyzer('step', motor_pos_Tf, 0:0.1:5);

