clc
clear
close all
warning off all

a= imread("imagenes/imagenBosque.jpg");

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

% SEGUNDA PARTE
% COMPRIMIR O EXPANDIR IMAGEN

b= a;
[l, m, n]= size(b);

% Encontremos el valor maximo y minimo de la matriz
minimoImg= min(min(min(b)));
maximoImg= max(max(max(b)));

opcion= "S";

while (opcion ~= "N")
     valorMinimo= input('Dame el valor minimo que deseas (de 0 a 255)= ');
     valorMaximo= input('Dame el valor maximo que deseas (de 0 a 255)= ');
    
     dato1= valorMaximo - valorMinimo;
     dato2= maximoImg - minimoImg;
     dato3= double(dato1) / double(dato2);
    
     for i= 1:l
        for j= 1:m
           for k= 1:n
              imProcesada(i, j, k)= ((dato3) * (b(i, j, k) - minimoImg)) + (valorMinimo);
           end
        end
     end
    
     % TERCERA PARTE
     % PREGUNTAR AL USUARIO SI QUIERE INTENTARLO DE NUEVO
     figure(2)
    
     subplot(2,4,1)
     imshow(imProcesada)
     title("Imagen procesada")
    
     subplot(2,4,2)
     grisRojo= imProcesada(:,:,1);
     imshow(grisRojo)
     title("Gris rojo procesado")
    
     subplot(2,4,3)
     grisVerde= imProcesada(:,:,2);
     imshow(grisVerde)
     title("Gris verde procesado")
    
     subplot(2,4,4)
     grisAzul= imProcesada(:,:,3);
     imshow(grisAzul)
     title("Gris azul procesado")
    
     subplot(2,4,5)
     histogram(imProcesada)
     title("Histograma imagen procesada")
    
     subplot(2,4,6)
     histogram(grisRojo)
     title("Histograma gris rojo procesado")
    
     subplot(2,4,7)
     histogram(grisVerde)
     title("Histograma gris verde procesado")
    
     subplot(2,4,8)
     histogram(grisAzul)
     title("Histograma gris azul procesado")

     opcion= input("Quieres hacerlo otra vez? S/N [S]: ", "S");
end

disp("Proceso terminado")