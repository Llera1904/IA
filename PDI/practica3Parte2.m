clc
clear
close all
warning off all

a= imread("imagenes/perro.jpg");
b= imread("imagenes/juego3.jpg");

figure(1)
subplot(2,3,1)
imshow(a)
subplot(2,3,2)
imshow(b)

subplot(2,3,4)
histogram(a)
subplot(2,3,5)
histogram(b)

[l, m, n]= size(a);
[l1, m1, n1]= size(b);

%a= [1 1 0 1 9; 2 2 2 3 5; 2 2 3 2 5; 4 4 1 2 5; 3 4 1 2 7];
%b= [4 3 2 5 7; 7 8 4 4 7; 6 5 4 9 3; 9 6 5 2 8; 8 8 7 7 6];

%[m, n]= size(a);
%[m1, n1]= size(b);

%a= uint8(a);
%b= uint8(b);

% Encontremos el valor maximo y minimo de la matriz
minimoImgA= min(min(min(a)));
maximoImgA= max(max(max(a)));

minimoImgB= min(min(min(b)));
maximoImgB= max(max(max(b)));

% Parte practica 3 (segunda parte)
[countsA, binLocationsA]= imhist(a);
[countsB, binLocationsB]= imhist(b);

pixelesTotalA= sum(countsA);
pixelesTotalB= sum(countsB);

% Calculamos la probabiliad y la probabilidad acumulada de A Y B
for i= 1:1
   for j= 1:256
      probabilidadA(i, j)= countsA(j, i)/(pixelesTotalA);
      probabilidadB(i, j)= countsB(j, i)/(pixelesTotalB);
   end
end

probabilidadAcumuladaA(1, 1)=  probabilidadA(1, 1);
probabilidadAcumuladaB(1, 1)=  probabilidadB(1, 1);

for i= 1:1
   for j= 2:256
      probabilidadAcumuladaA(i, j)=  probabilidadA(i, j) + probabilidadAcumuladaA(i, j-1);
      probabilidadAcumuladaB(i, j)=  probabilidadB(i, j) + probabilidadAcumuladaB(i, j-1);
   end 
end

% Calculamos los nuevo valores de nivel de b
for i= 1:1
   for j= 1:256
      valorProbAcumulada= probabilidadAcumuladaB(i, j);
      [minimo, posicion]= min(abs(probabilidadAcumuladaA-valorProbAcumulada));
      nuevoNivelB(i, j)= posicion-1;
   end
end

% Remplazamos valores
valor= 0;

while valor ~= 256
     for i= 1:l1
        for j= 1:m1
           for k= 1:n1
              if b(i, j, k) == valor
                bTrasformada(i, j, k)= nuevoNivelB(1, valor+1);
              end
           end
        end
     end
     valor= valor +1;
end

bTrasformada= uint8(bTrasformada)

subplot(2,3,3)
imshow(bTrasformada)

subplot(2,3,6)
histogram(bTrasformada)