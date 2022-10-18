clc
clear
close all
warning off all

% Parte huffman
% a= imread("imagenes/kimetsu.jpg");
% b=  rgb2gray(a);

% a= [139 113 118; 113 108 107; 108 139 113; 113 115 122];
a= [20 1 10 1 8 9];
b= a;
b= uint8(b);

% % COMPRIMIR O EXPANDIR IMAGEN
% [m, n]= size(b);
% 
% % Encontremos el valor maximo y minimo de la matriz
% minimoImg= min(min(b));
% maximoImg= max(max(b));
% 
% valorMinimo= input('Dame el valor minimo que deseas (de 0 a 255)= ');
% valorMaximo= input('Dame el valor maximo que deseas (de 0 a 255)= ');
%     
% dato1= valorMaximo - valorMinimo;
% dato2= maximoImg - minimoImg;
% dato3= double(dato1) / double(dato2);
%     
% for i= 1:m
%    for j= 1:n
%       imProcesada(i, j)= ((dato3) * (b(i, j) - minimoImg)) + (valorMinimo);
%    end
% end
% 
% figure(1)
% subplot(1, 2, 1);
% histogram(b)
% subplot(1, 2, 2);
% histogram(imProcesada)
% 
% b= imProcesada;

[counts, binLocations]= imhist(b);
pixelesTotal= sum(counts);

% Obtenemos los datos que tengan una frecuencia diferente de cero
j= 1;
for i= 1:256
   if counts(i, 1) ~= 0
     datos(1, j)= binLocations(i, 1);
     frecuencia(1, j)= counts(i, 1); 
     j= j + 1;
   end
end
[~, poscicionDato]= sort(frecuencia, 'descend'); % Arreglo para la decodificacion

% Calculamos la probabilidad de cada pixel
[~, n]= size(datos);
for i= 1:n
   probabilidad(1, i)= frecuencia(1, i)/(pixelesTotal);
end
probabilidad= sort(probabilidad, 'descend');


matrizAux= probabilidad;
% Creamos una matriz llena de ceros para los pasos
[~, n]= size(datos);
pasos= zeros(n, n-1);

% Sumamos los ultimos dos valores y los volvemos a ordenar
i= 1;
while n ~= 0
    [~, n]= size(matrizAux);
    % Matriz con los pasos
    for j= 1:n
       pasos(j, i)= matrizAux(1, j);
    end

    suma= matrizAux(1, n) + matrizAux(1, n-1);

    % Nodo padre
    arregloNodos(i, 1)= suma;
    % Nodos hijos
    arregloNodos(i, 2)= matrizAux(1, n-1); % Izquierda 
    arregloNodos(i, 3)= matrizAux(1, n); % Derecha

    matrizAux(:, n)= [];
    matrizAux(:, n-1)= [];
    [~, n]= size(matrizAux);
    matrizAux(1, n+1)= suma;
    matrizAux= sort(matrizAux, 'descend');

    i= i + 1;
end

% Trasformamos la matriz con los pasos en una tabla y la mandamos al txt
tablaPasos= array2table(pasos);
writetable(tablaPasos, "pasos.txt", 'Delimiter', '\t');

% Empezamos codificacion
[numeroNodos, ~]= size(arregloNodos);
codificacion(1, 1)= "1";
codificacion(2, 1)= "0";
codificacion(1, 2)= arregloNodos(numeroNodos, 2);
codificacion(2, 2)= arregloNodos(numeroNodos, 3);
arregloNodos(numeroNodos, :)= [];

[numeroNodos, ~]= size(arregloNodos);
while numeroNodos ~= 0
    nodoPadre= arregloNodos(numeroNodos, 1);
    [m, ~]= find(codificacion==string(nodoPadre));
    poscicion= max(m);
    codigoPadre= codificacion(poscicion, 1);
    codificacion(poscicion, :)= [];
    [m, ~]= size(codificacion);

    codificacion(m+1, 1)= codigoPadre + "1";
    codificacion(m+2, 1)= codigoPadre + "0";
    codificacion(m+1, 2)= arregloNodos(numeroNodos, 2);
    codificacion(m+2, 2)= arregloNodos(numeroNodos, 3);
    arregloNodos(numeroNodos, :)= [];
    [numeroNodos, ~]= size(arregloNodos);
end

% Pasamos solo el codigo de Huffman
[m, ~]= size(codificacion);
for i= 1:m
   codigoHuffman(i, 1)= codificacion(i, 1);
end

% Arreglo para trasmitir 
for i= 1:m
   codigoH(1, i)= codigoHuffman(i, 1);
end
codigoH= join(codigoH);
codigoH= erase(codigoH, " ");
codigoH= char(codigoH);

% Arreglo para saber a que valor le corresponde el codigo
arregloCodigo= zeros(length(datos), 2);
for i= 1:length(datos)
   arregloCodigo(i, 1)= datos(1, poscicionDato(1, i));
   arregloCodigo(i, 2)= codigoHuffman(i, 1);
end

% Trasformamos la matriz en una tabla y la mandamos al txt
tablaCodigo= array2table(arregloCodigo);
writetable(tablaCodigo, "codigo.txt", 'Delimiter', '\t');

% Calculos
for i= 1:length(codigoHuffman)
   datoCodigo= codigoHuffman(i, 1);
   auxLm(1, i)=  strlength(datoCodigo)*probabilidad(1, i);
   auxH(1, i)= probabilidad(1, i)*log2(1/probabilidad(1, i));
end

auxLm= double(auxLm);
auxH= double(auxH);
Lm= sum(auxLm);
H= sum(auxH);
n= (H/Lm)*100;

fprintf('Longitud media (Lm)= %f\n', Lm)
fprintf('Entropía (H)= %f\n', H)
fprintf('Eficiencia (N)= %d\n', n)

% ----------------------------------------
% Inicia trasmision
% informacion= '101010110';
informacion= codigoH;
tamInfo= length(informacion);

% Calculamos R
R= 1;
while (2^R) < (R + tamInfo + 1)
    R= R + 1;
end

numeroBits= R + tamInfo;
bits= zeros(1, numeroBits);
bits= char(bits);

% Pasamos la informacion a su correspondiente lugar
potencia2= 0;
j= 1;
for i= 1:numeroBits
   if i == 2^potencia2
     potencia2= potencia2 + 1;
   else
     bits(1, i)= informacion(1, j);
     j= j + 1;
   end
end

% Crear tabla de combinaciones binarias
tablaBinaria= zeros(numeroBits+1, R);
tablaBinaria= char(tablaBinaria);
tablaBinaria(1, :)= dec2bin(0, R);
for i= 1:numeroBits
   tablaBinaria(i+1, :)=  dec2bin(i, R);
end

% Calculamos los bits R
for i= 1:R
   arregloBistUno= (find(tablaBinaria(:, i)== '1'))-1;
   valorCalcular= arregloBistUno(1, 1);

   if length(arregloBistUno) == 2
     resultadoAux= bits(1, arregloBistUno(2, 1));
   end

   if length(arregloBistUno) > 2
     if length(arregloBistUno) == 3
       resultadoAux= xor(str2double(bits(1, arregloBistUno(2, 1))), str2double(bits(1, arregloBistUno(3, 1))));
     end

     if length(arregloBistUno) >= 4
       resultadoAux= xor(str2double(bits(1, arregloBistUno(2, 1))), str2double(bits(1, arregloBistUno(3, 1))));
       for j= 4:length(arregloBistUno)
          resultadoAux= xor(resultadoAux, str2double(bits(1, arregloBistUno(j, 1))));
       end
     end

     resultadoAux= double(resultadoAux);
     resultadoAux= string(resultadoAux);
     resultadoAux= char(resultadoAux);  
   end

   bits(1, valorCalcular)= resultadoAux;
end

% Preguntamos si dañamos algunos bits
trasmitir= bits;
opTrasmitir= "N";
while (opTrasmitir ~= "S")
    opcion= input("¿Desea dañar la imagen?: S/N ", 's');
    if opcion == "S"
      bitDa= input('¿Que bit desea dañar? ');
      resultadoAux= not(str2double(bits(1, bitDa)));
      resultadoAux= double(resultadoAux);
      resultadoAux= string(resultadoAux);
      resultadoAux= char(resultadoAux); 

      trasmitir(1, bitDa)= resultadoAux;
    end

    opTrasmitir= input("¿Desea trasmitir la informacion?: S/N ", 's');
end

% Lo mandamos a un txt
fileID = fopen('trasmitir.txt','w');
fprintf(fileID, '%c', trasmitir);
fclose(fileID);