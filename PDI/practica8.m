clc
clear
close all
warning off all

% Leemos la informacion
% fileID = fopen('trasmitir.txt','r');
% formatSpec = '%c';
% informacion= fscanf(fileID,formatSpec);
% fclose(fileID);
informacion= '1001010101101010100000000000110';
% informacion= '100101011';
bits= informacion;
numeroBits= length(informacion);

% Buscamos R
R= 1;
while (2^R) < (numeroBits + 1)
    R= R + 1;
end

% Crear tabla de combinaciones binarias
tablaBinaria= zeros(numeroBits+1, R);
tablaBinaria= char(tablaBinaria);
tablaBinaria(1, :)= dec2bin(0, R);
for i= 1:numeroBits
   tablaBinaria(i+1, :)=  dec2bin(i, R);
end

bitDaAux= '1';
contador= 1;
% Buscamos los bits dañados
while bin2dec(bitDaAux) ~= 0 
    for i= 1:R
       arregloBistUno= (find(tablaBinaria(:, i)== '1'))-1;
       resultadoAux= xor(str2double(bits(1, arregloBistUno(1, 1))), str2double(bits(1, arregloBistUno(2, 1))));
       for j= 3:length(arregloBistUno)
          resultadoAux= xor(resultadoAux, str2double(bits(1, arregloBistUno(j, 1))));
       end
       resultadoAux= double(resultadoAux);
       resultadoAux= string(resultadoAux);
       resultadoAux= char(resultadoAux);  

       bitDaAux(1, i)= resultadoAux; 
    end

    % Cambiamos el bit dañado
    if bin2dec(bitDaAux) ~= 0 
      bitDa= bin2dec(bitDaAux);
      resultadoAux= not(str2double(bits(1, bitDa)));
      resultadoAux= double(resultadoAux);
      resultadoAux= string(resultadoAux);
      resultadoAux= char(resultadoAux); 

      bits(1, bitDa)= resultadoAux; 
      % Arreglo con los bits que han sido dañados
      % bitsDa(1, contador)= bitDa;
      % contador= contador + 1;
    else
      bitsDa(1, contador)= 0;
    end  
    
end
fprintf('Bit dañado= %d\n', bitDa)
% disp("Bits dañados: ")
% disp(bitsDa)

% Reconstruir informacion
potencia2= 0;
j= 1;
for i= 1:numeroBits
   if i == 2^potencia2
     potencia2= potencia2 + 1;
   else
     informacionRecuperada(1, j)= bits(1, i);
     j= j + 1;
   end
end

fprintf('Tamaño de la informacion recuperada= %d\n', length(informacionRecuperada))