clc
clear
close all
warning off all

a= imread("imagenes\juego2.jpg");

% PRIMERA PARTE
% SEPARAR EN ESCALA DE GRISES CADA CAPA DE COLOR RGB
figure(1)

subplot(2,4,1)
imshow(a)
title("Imagen original")

subplot(2,4,2)
grisRojo= a(:,:,1);
imshow(grisRojo)
title("Gris rojo")

subplot(2,4,3)
grisVerde= a(:,:,2);
imshow(grisVerde)
title("Gris verde")

subplot(2,4,4)
grisAzul= a(:,:,3);
imshow(grisAzul)
title("Gris azul")

subplot(2,4,5)
histogram(a)

subplot(2,4,6)
histogram(grisRojo)
title("Histograma gris rojo")

subplot(2,4,7)
histogram(grisVerde)
title("Histograma gris verde")

subplot(2,4,8)
histogram(grisAzul)
title("Histograma gris azul")

b= a;
[l, m, n]= size(b);

% Encontremos el valor maximo y minimo de la matriz
minimoImg= min(min(min(b)));
maximoImg= max(max(max(b)));

% Parte practica 3
[counts, binLocations]= imhist(b);
pixelesTotal= sum(counts);

for i= 1:1
   for j= 1:256
      probabilidad(i, j)= counts(j, i)/(pixelesTotal);
   end
end

probabilidadAcumulada(1, 1)=  probabilidad(1, 1);

for i= 1:1
   for j= 2:256
      probabilidadAcumulada(i, j)=  probabilidad(i, j) + probabilidadAcumulada(i, j-1);
   end 
end

for i= 1:1
   for j= 1:256
      nivelEcualizado(i, j)= ((maximoImg-minimoImg)*probabilidadAcumulada(i, j)) + minimoImg;
   end
end

valor= 0;

while valor ~= 256
     for i= 1:l
        for j= 1:m
           for k= 1:n
              if b(i, j, k) == valor
                imEcualizada(i, j, k)= nivelEcualizado(1, valor+1);
              end
           end
        end
     end
     valor= valor +1;
end

figure(2)
    
subplot(2,4,1)
imshow(imEcualizada)
title("Imagen Ecualizada")
    
subplot(2,4,2)
grisRojo= imEcualizada(:,:,1);
imshow(grisRojo)
title("Gris rojo ecualizado")
    
subplot(2,4,3)
grisVerde= imEcualizada(:,:,2);
imshow(grisVerde)
title("Gris verde ecualizado")
    
subplot(2,4,4)
grisAzul= imEcualizada(:,:,3);
imshow(grisAzul)
title("Gris azul ecualizado")
    
subplot(2,4,5)
histogram(imEcualizada)
title("Histograma imagen Ecualizada")
    
subplot(2,4,6)
histogram(grisRojo)
title("Histograma gris rojo ecualizado")
    
subplot(2,4,7)
histogram(grisVerde)
title("Histograma gris verde ecualizado")
    
subplot(2,4,8)
histogram(grisAzul)
title("Histograma gris azul ecualizado")
