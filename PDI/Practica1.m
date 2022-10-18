clc
clear all 
close all 
warning off all 

a= imread('imagenBosque.jpg'); % imread es para leer una imagen

figure(1)

% Verde
verde= a;
verde(:,:,1)= 0;
verde(:,:,2);
verde(:,:,3)= 0;

% Amarillo= Rojo + Verde
amarillo= a;
amarillo(:,:,1);
amarillo(:,:,2);
amarillo(:,:,3)= 0;

% Cyan= Verde + Azul
cyan= a;
cyan(:,:,1)= 0;
cyan(:,:,2);
cyan(:,:,3);

% Magenta= Rojo + Azul
magenta= a;
magenta(:,:,1);
magenta(:,:,2)= 0;
magenta(:,:,3);

% Juntando las 4 imagenes
subplot(2,2,1)
arregloImagenes= [verde amarillo; magenta cyan];
imshow(arregloImagenes)

% Imagen partida1
subplot(2,2,2)
partida= a;

% Fila1
partida(1:223,:,1);
partida(1:223,:,2)= 0;
partida(1:223,:,3)= 0;

% Fila2
partida(224:447,:,1)= 0;
partida(224:447,:,2);
partida(224:447,:,3)= 0;

% Fila3
partida(448:670,:,1)= 0;
partida(448:670,:,2)= 0;
partida(448:670,:,3);

imshow(partida)

% Imagen partida2
subplot(2,2,3)
partida2= a;

% Columa1
partida2(:,1:397,1);
partida2(:,1:397,2)= 0;
partida2(:,1:397,3)= 0;

% Columna2
partida2(:,398:795,1)= 0;
partida2(:,398:795,2);
partida2(:,398:795,3)= 0;

% Columna3
partida2(:,796:1192,1)= 0;
partida2(:,796:1192,2)= 0;
partida2(:,796:1192,3);

imshow(partida2)

% Imagen partida3
subplot(2,2,4)
partida3= a;

%PARA EL COLOR ROJO (R)

% COLUMNA IZQUIERDA
partida3(:,1:238,1);
partida3(:,1:238,2) = 0;
partida3(:,1:238,3) = 0;

% LINEA SUPERIOR
partida3(1:95,1:596,1);
partida3(1:95,1:596,2) = 0;
partida3(1:95,1:596,3) = 0;

% LINEA DE EN MEDIO
partida3(381:475,1:596,1);
partida3(381:475,1:596,2) = 0;
partida3(381:475,1:596,3) = 0;

% LINEA INFERIOR
partida3(571:end,1:596,1);
partida3(571:end,1:596,2) = 0;
partida3(571:end,1:596,3) = 0;

% SECCION RESTANTE
partida3(191:285,477:596,1);
partida3(191:285,477:596,2) = 0;
partida3(191:285,477:596,3) = 0;

% PARA EL COLOR VERDE (G)

% LINEA SUPERIOR DE LA S
partida3(96:190,239:952,1) = 0;
partida3(96:190,239:952,2);
partida3(96:190,239:952,3) = 0;

% LINEA DE EN MEDIO DE LA S
partida3(286:380,239:952,1) = 0;
partida3(286:380,239:952,2);
partida3(286:380,239:952,3) = 0;

% LINEA INFERIOR DE LA S
partida3(476:570,239:952,1) = 0;
partida3(476:570,239:952,2);
partida3(476:570,239:952,3) = 0;

% PARA LAS SECCIONES RESTANTES
partida3(191:285,239:476,1) = 0;
partida3(191:285,239:476,2);
partida3(191:285,239:476,3) = 0;

partida3(381:475,715:952,1) = 0;
partida3(381:475,715:952,2);
partida3(381:475,715:952,3) = 0;

% PARA EL COLOR AZUL (B)

% COLUMNA DERECHA
partida3(:,953:end,1) = 0;
partida3(:,953:end,2) = 0;
partida3(:,953:end,3);

% LINEA SUPERIOR
partida3(1:95,597:952,1) = 0;
partida3(1:95,597:952,2) = 0;
partida3(1:95,597:952,3);

% LINEA DE EN MEDIO
partida3(191:285,597:952,1) = 0;
partida3(191:285,597:952,2) = 0;
partida3(191:285,597:952,3);

% LINEA INFERIOR
partida3(571:end,597:952,1) = 0;
partida3(571:end,597:952,2) = 0;
partida3(571:end,597:952,3);

% SECCION RESTANTE
partida3(381:475,597:714,1) = 0;
partida3(381:475,597:714,2) = 0;
partida3(381:475,597:714,3);

imshow(partida3)
