clc % Limpia pantalla
clear all % Limpia todo
close all % Cierra todo
warning off all % Apaga las llamadas de atención
disp('Welcome to MATLAB') % Imprime mensaje en consola

%%%%%
% PROGRAMA QUE LEE  Y DESPLIEGA UNA IMAGEN EN PANTALLA

a= imread('peppers.png'); % imread es para leer una imagen
figure(1) 

subplot(2,2,1) 
imshow(a) % imshow es para desplegar el contenido de la variable
title('imagen a color')

subplot(2,2,2)
b= rgb2gray(a); % rgb2gray convierte la imagen a colores a 256 niveles de brillantez o de grises
imshow(b) % imshow es para desplegar el contenido de la variable
title('imagen grises')

subplot(2,2,3)
c= im2bw(b); % im2bw convierte la imagen a blanco y negro
imshow(c) % imshow es para desplegar el contenido de la variable
title('imagen binaria')

subplot(2,2,4)
d= not(c); 
imshow(d)
title('imagen negativo')

%
% figure(2)
% b=rgb2gray(a); %rgb2gray convierte la imagen a colores a 256 niveles de brillantez o de grises
% imshow(b)
% 
% figure(3)
% c=im2bw(b);
% imshow(c)
% 
% figure(4)
% d=not(c);
% imshow(d)

figure(2)

subplot(2,3,1)
rojo= a;
rojo(:,:,1);
rojo(:,:,2)= 0;
rojo(:,:,3)= 0;
imshow(rojo)
title('imagen roja')

subplot(2,3,2)
verde= a;
verde(:,:,1)= 0;
verde(:,:,2);
verde(:,:,3)= 0;
imshow(verde)
title('imagen verde')

subplot(2,3,3)
azul= a;
azul(:,:,1)= 0;
azul(:,:,2)= 0;
azul(:,:,3);
imshow(azul)
title('imagen azul')

% Amarillo= Rojo + Verde
subplot(2,3,4)
amarillo= a;
amarillo(:,:,1);
amarillo(:,:,2);
amarillo(:,:,3)= 0;
imshow(amarillo)
title('imagen amarilla')

% Cyan= Verde + Azul
subplot(2,3,5)
cyan= a;
cyan(:,:,1)= 0;
cyan(:,:,2);
cyan(:,:,3);
imshow(cyan)
title('imagen cyan')

% Magenta= Rojo + Azul
subplot(2,3,6)
magenta= a;
magenta(:,:,1);
magenta(:,:,2)= 0;
magenta(:,:,3);
imshow(magenta)
title('imagen magenta')

% MEZCLAS SUSTRACTIVAS: Filtran la luz blanca que incide en la superficie,
% substrayendo o absorbinedo todos los colores del espectro, exepto el tono
% mezclado que se desea reflejar.

%  De acuerdo al ITU: UNION INTERNACIONAL DE ESTANDARIZACION para efectos de
%las comunicaciones y trasmision de T,V. DE ALTA DEFINICION:

% rojo*0.299
% verde*0.5870
% azul*0.2240

% grises= (roja*0.299)+(verde*0.5870)+(azul*0.1140);

figure(3)

subplot(4,1,1)
blanco= rojo+verde+azul;
imshow(blanco)
title('imagen blanca')

subplot(4,1,2)
grises= (rojo*0.299)+(verde*0.5870)+(azul*0.1140);
imshow(grises)
title('grises')

subplot(4,1,3)
naranja= amarillo+rojo; 
imshow(naranja)
title('imagen naranja')

subplot(4,1,4)
desconocido= amarillo+magenta+cyan; 
imshow(desconocido)
title('imagen color desconocido')

% Mezclas sustractivas: 
% si Blanco-Azul = Rojo+Verde Amarillo
% si Blanco-Rojo= Verde+Azul Cyan
% si Blanco-Verde= Rojo+Azul Magenta

figure(4)

arreglo= [desconocido naranja; cyan magenta];
imshow(arreglo)

figure(5)

grises1= a;
subplot(1,2,1)
grisesNew= (grises1(:,:,1)+grises1(:,:,2)+grises1(:,:,3))/3;
imshow(grisesNew)
title('gris original')

subplot(1,2,2)
grisesNew2= (grises1(:,:,1)*0.299+grises1(:,:,2)*0.5870+grises1(:,:,3)*0.114); 
imshow(grisesNew2)
title('gris ajustado')

disp('Fin de proceso computacional')




