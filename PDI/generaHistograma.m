clc
clear all
close all
warning off all

% Programa que grafica el histograma de una imagen 
% Expansion/Compresion

a= imread('peppers.png');
figure(1)
[m, n]= size(a);
imshow(a)

b= [0 0 2 2 9; 2 5 5 2 5; 3 3 6 5 5; 2 6 8 5 5; 2 8 8 6 6];
[m1, n1]= size(b);

b= uint8(b);

% Encontremos el valor maximo y minimo de la mmatriz b
minimoImg= min(min(b));
maximoImg= max(max(b));

valorMinimo= input('Dame el valor minimo que deseas (de 0 a 255)= ');
valorMaximo= input('Dame el valor maximo que deseas (de 0 a 255)= ');

dato1= valorMaximo-valorMinimo;
dato2= maximoImg-minimoImg;
dato3= dato1/dato2;

for i= 1:m1
   for j= 1:n1
      imProcesada(i, j)= ((dato3)*(b(i, j) - minimoImg)) + (valorMinimo);
   end
end

figure(2)
histogram(imProcesada)

figure(3)
histogram(b)

disp('fIN DE PROCESO')

