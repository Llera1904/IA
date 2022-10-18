clc
clear 
close all 
warning off all 

a= imread("imagenes/kimetsu.jpg"); % imread es para leer una imagen

imagenGray= rgb2gray(a);

% Verde
verde= a;
verde(:,:,1)= 0;
verde(:,:,2);
verde(:,:,3)= 0;

% rojo
rojo= a;
rojo(:,:,1);
rojo(:,:,2)=0;
rojo(:,:,3)=0;

grisVerde= a(:,:,2);

arriba= imfuse(imagenGray, verde, "montage");
abajo= imfuse(rojo, grisVerde, "montage");

figure(1)
nueva= [arriba; abajo];
imshow(nueva)
%-------------------

for i=1:10
   for j= 1:10
      matriz10(i, j)= a(i, j);
   end
end
 
matrizH= zeros(1, 256);

valor= 0;
while valor ~= 256
     for i= 1:10
        for j= 1:10
           if matriz10(i, j) == valor
             matrizH(1, valor+1)= (matrizH(1, valor+1)) +  1;
           end
        end
     end
     valor= valor + 1;
end

minimoImg= min(min(matriz10));
maximoImg= max(max(matriz10));

valorMinimo= input('Dame el valor minimo que deseas (de 0 a 255)= ');
valorMaximo= input('Dame el valor maximo que deseas (de 0 a 255)= ');
    
dato1= valorMaximo - valorMinimo;
dato2= maximoImg - minimoImg;
dato3= double(dato1) / double(dato2);
    
for i= 1:10
   for j= 1:10
      histogramaExpandido(i, j)= ((dato3) * (matriz10(i, j) - minimoImg)) + (valorMinimo);
   end     
end

figure(2)
subplot(1,2,1)
histogram(matriz10)

subplot(1,2,2)
histogram(histogramaExpandido)
