%% SCRIPT QUE RECOGE Y GUARDA EN UNA TABLA 3D LAS CARACTERISTICAS
%
% La primera dimensi�n son las filas: valor de las caracteristicas
% La segunda dimensi�n son las columnas: caracter�stica en cuesti�n
% La tercera dimensi�n es el n�mero de la tabla bidimensional: n� paciente
%
% Abrimos la direcci�n donde se encuentran nuestros archivos y guardamos en
% un vector todos los nombres de los archivos de esta carpeta
%

clear
clc

cd;
carpeta_archivos = cd('C:\Users\AAS\Documents\UC3M\4o Curso\TFG\2a tarea 07-02-2020\WESAD');

if strcmp(carpeta_archivos,cd)==1
else
    carpeta_archivos = cd('C:\Users\AAS\Documents\UC3M\4o Curso\TFG\2a tarea 07-02-2020\WESAD');
end

archivos = ls(carpeta_archivos); 


%% LEEMOS Y ALMACENAMOS PACIENTE A PACIENTE DEL EXPERIMENTO DE WESAD
%

data = struct([]);
sujeto = 0;
ventana = 1;

for i = 1:length(archivos) 
    
    %
    % Encontramos un archivo que empieza por S 
    %
    if(strcmp(archivos(i),'S') == 1)
       
        sujeto = sujeto + 1;
        
        cd('C:\Users\AAS\Documents\UC3M\4o Curso\TFG\2a tarea 07-02-2020\WESAD');
        archivo = cd(archivos(i,:));
            
        %
        % Se�al del paciente encontrado y self-reports (Valence - Arousal)
        %
        
        load('out.mat');
        load('valence_arousal');
        
        %
        % Volvemos a la carpeta de archivos inicial
        %
        
        cd('C:\Users\AAS\Documents\GitHub\BINDI_TFGs\TFG_Antonio\Funciones');
        
        %
        % N de ventanas temporales de la se�al escogida
        %
        
        ventanas = Ventanas_8s(signal.wrist.BVP);
        
        [VA, b, s, m1, a, m2] = valence_arousal(label, valence, arousal);
        
        %
        % Muestreamos ventana por ventana en una figura caracter�sticas
        %
        for j = 1:length(ventanas)-1
            
            [caracteristica_T, HRV] = calculo_caracteristicas_Tdomain(j, ventanas, signal.wrist.BVP);
            caracteristica_F = calculo_caracteristicas_Fdomain(HRV);
            [label_VA, label_estado] = get_label(j, ventanas, VA, b, s, m1, a, m2);
            rqa = no_lineales(j, ventanas, signal.wrist.BVP);
            
            %
            % No puedo hacer un plot con este m�todo de ejecuci�n, el
            % tiempo de ejecuci�n del programa es ~ 1h
            %
            
            if label_VA ~= 0 
                
                %
                %Caracter�sticas en Tdomain
                %
                
                data{sujeto}.features(ventana,1) = caracteristica_T(1);
                data{sujeto}.features(ventana,2) = caracteristica_T(2);
                data{sujeto}.features(ventana,3) = caracteristica_T(3);
                data{sujeto}.features(ventana,4) = caracteristica_T(4);
                data{sujeto}.features(ventana,5) = caracteristica_T(5);
                data{sujeto}.features(ventana,6) = caracteristica_T(6);
                data{sujeto}.features(ventana,7) = caracteristica_T(7);
                %data{sujeto}.features(ventana,8) = caracteristica_T(8);
                
                %
                % Caracter�sticas en Fdomain
                %
                
                data{sujeto}.features(ventana,8) = caracteristica_F(1);
                data{sujeto}.features(ventana,9) = caracteristica_F(2);
                data{sujeto}.features(ventana,10) = caracteristica_F(3);
                data{sujeto}.features(ventana,11) = caracteristica_F(4);
                data{sujeto}.features(ventana,12) = caracteristica_F(5);
                data{sujeto}.features(ventana,13) = caracteristica_F(6);
                data{sujeto}.features(ventana,14) = caracteristica_F(7);
                data{sujeto}.features(ventana,15) = caracteristica_F(8);
                data{sujeto}.features(ventana,16) = caracteristica_F(9);
                data{sujeto}.features(ventana,17) = caracteristica_F(10);
                data{sujeto}.features(ventana,18) = caracteristica_F(11);
                data{sujeto}.features(ventana,19) = caracteristica_F(12);
                
                %
                % Caracter�sticas no lineales RQA
                %
                
                data{sujeto}.features(ventana,20) = rqa(1);
                data{sujeto}.features(ventana,21) = rqa(2);
                data{sujeto}.features(ventana,22) = rqa(3);
                data{sujeto}.features(ventana,23) = rqa(4);
                data{sujeto}.features(ventana,24) = rqa(5);
                data{sujeto}.features(ventana,25) = rqa(6);
                
                %
                % Label de self-report asociado a dicha ventana 
                % Label del estado inducido
                %
                
                data{sujeto}.features(ventana,26) = label_VA;
                data{sujeto}.features(ventana,27) = label_estado;
                
                ventana = ventana + 1;
            end
        end
        ventana = 1;
    end 
end
