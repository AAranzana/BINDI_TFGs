%% Script que te imprime ventana x ventana 
load('out.mat');


%% Ventana n a muestrear
n = 340;


%% Calculo de las caracter�sticas y almacenamiento en variables nuevas
[NN50, pNN50, HR_mean, HR_std, HRV_mean, HRV_std, HRV_rms] = calculo_caracteristicas_ventana(n, signal.wrist.BVP);


%% Ventanas temporales de nuestra se�al
ventanas = Ventanas_8s(signal.wrist.BVP);


%% Funci�n final de muestreo de la ventana
plot_ventana(ventanas, signal.wrist.BVP, n, HR_mean, HR_std, HRV_mean, HRV_std, HRV_rms);
