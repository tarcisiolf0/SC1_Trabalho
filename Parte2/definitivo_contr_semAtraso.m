clear; %Limpa todas as variáveis salvas no workspace
close all; %Fecha todos os gráficos abertos
clc; %Limpa o Command Window

Gs_ori = zpk([],[-9.975 -2.025],[2])
Gs_pade = zpk([20],[-9.975 -2.025 -20],[-2])
Gs_ori_atraso = zpk([],[-9.975 -2.025],[2], 'OutputDelay', 0.1)

Cs = zpk([-1.9],[0],[23.8])

step(feedback(Gs_ori*Cs,1))
hold on
step(feedback(Gs_pade*Cs,1))
step(feedback(Gs_ori_atraso*Cs,1))
