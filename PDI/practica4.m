clc
clear
close all
warning off all

% Matrices prueba 
% o= [1 1 0 1 9 2 3 4 5 6 7 8; 3 3 4 5 6 7 3 2 2 2 3 5; 5 5 10 11 12 13 4 2 2 3 2 5; 
%    11 13 20 1 2 3 4 4 4 1 2 5; 3 4 5 6 7 8 9 3 4 1 2 7];
% o= [120 119 115 300 113 200; 112 200 117 1 2 111; 100 120 119 2 3 210; 200 3 4 5 4 100; 121 100 150 200 4 115; 219 1 2 3 4 5];

% a= imread("imagenes/imagenBob.jpg");
a= imread("cameraman.tif");
o= a;
% o= rgb2gray(a);
figure(1)
subplot(1,4,1)
imshow(o)
title("Original")

% prengutamos las dimeciones de la matriz o y creamos la matriz p con ceros
% y las mismas dimensiones de o
o= double(o);
[m, n]= size(o);

p= zeros(m, n);
[m1, n1]= size(p);

% Preguntamos si las matrices tienen dimensiones pares o impares
moduloM= mod(m, 2);
moduloN= mod(n, 2);

% Pasamos una columan y una fila a la matriz p
for i=1:1
   for j=1:n
      p(i, j)= o(i, j);
   end
end

for i=2:m
   for j=1:1
      p(i, j)= o(i, j);
   end
end

% Matriz prediccion

% Si las dimensiones son impares
if moduloM == 1
  i= 2;
  while i <= m-1
    if moduloN == 1
      j= 2;
      while j <= n-1
          p(i, j)= round((p(i-1, j-1) + p(i-1, j) + p(i-1, j+1) + p(i, j-1) + p(i+1, j-1))/5);
          p(i, j+1)= round((p(i-1, j) + p(i-1, j+1) + p(i, j))/3);
          p(i+1, j)= round((p(i, j-1) + p(i, j) + p(i, j+1) + p(i+1, j-1))/4);
          p(i+1, j+1)= round((p(i, j) + p(i, j+1) + p(i+1, j))/3);
          j= j+2;
      end
    end

    if moduloN == 0
      j= 2;
      while j <= n-2
          p(i, j)= round((p(i-1, j-1) + p(i-1, j) + p(i-1, j+1) + p(i, j-1) + p(i+1, j-1))/5);
          p(i, j+1)= round((p(i-1, j) + p(i-1, j+1) + p(i, j))/3);
          p(i+1, j)= round((p(i, j-1) + p(i, j) + p(i, j+1) + p(i+1, j-1))/4);
          p(i+1, j+1)= round((p(i, j) + p(i, j+1) + p(i+1, j))/3);
          j= j+2;
      end
      j= j-1;
      p(i, j+1)= round((p(i-1, j) + p(i-1, j+1) + p(i, j))/3);
      p(i+1, j+1)= round((p(i, j) + p(i, j+1) + p(i+1, j))/3);
    end
    i= i+2;
  end
end

% Si las dimensiones son pares
if moduloM == 0
  i= 2;
  while i <= m-1
    if moduloN == 1
      j= 2;
      while j <= n-1
          p(i, j)= round((p(i-1, j-1) + p(i-1, j) + p(i-1, j+1) + p(i, j-1) + p(i+1, j-1))/5);
          p(i, j+1)= round((p(i-1, j) + p(i-1, j+1) + p(i, j))/3);
          p(i+1, j)= round((p(i, j-1) + p(i, j) + p(i, j+1) + p(i+1, j-1))/4);
          p(i+1, j+1)= round((p(i, j) + p(i, j+1) + p(i+1, j))/3);
          j= j+2;
      end
    end

    if moduloN == 0
      j= 2;
      while j <= n-2
          p(i, j)= round((p(i-1, j-1) + p(i-1, j) + p(i-1, j+1) + p(i, j-1) + p(i+1, j-1))/5);
          p(i, j+1)= round((p(i-1, j) + p(i-1, j+1) + p(i, j))/3);
          p(i+1, j)= round((p(i, j-1) + p(i, j) + p(i, j+1) + p(i+1, j-1))/4);
          p(i+1, j+1)= round((p(i, j) + p(i, j+1) + p(i+1, j))/3);
          j= j+2;
      end
      j= j-1;
      p(i, j+1)= round((p(i-1, j) + p(i-1, j+1) + p(i, j))/3);
      p(i+1, j+1)= round((p(i, j) + p(i, j+1) + p(i+1, j))/3);
    end
    i= i+2;
  end
  i= i-1;
 
  if moduloN == 1
    j= 2;
    while j <= n-1
        p(i+1, j)= round((p(i, j-1) + p(i, j) + p(i, j+1) + p(i+1, j-1))/4);
        p(i+1, j+1)= round((p(i, j) + p(i, j+1) + p(i+1, j))/3);
        j= j+2;
    end
  end

  if moduloN == 0
    j= 2;
    while j <= n-2
        p(i+1, j)= round((p(i, j-1) + p(i, j) + p(i, j+1) + p(i+1, j-1))/4);
        p(i+1, j+1)= round((p(i, j) + p(i, j+1) + p(i+1, j))/3);
        j= j+2;
    end
    j= j-1;
    p(i+1, j+1)= round((p(i, j) + p(i, j+1) + p(i+1, j))/3);
  end
end

p= uint8(p);
subplot(1,4,2)
imshow(p)
title("Prediccion")

p= double(p);

% Calculamos la matriz e
for i=1:m
   for j=1:n
      e(i, j)= o(i, j)- p(i,j);
   end
end

e= uint8(e);
subplot(1,4,3)
imshow(e)
title("Error")

e= double(e);

maximoE= max(max(e));
minimoE= min(min(e));

% Preguntamos a cuanto se quiere cuantificar 
bits= 8;
numeroDeMuestras= 2^bits;

% Calculamos el paso de cuantificacion
pasoCuantificacion= (maximoE-minimoE)/numeroDeMuestras;

valorAux= 0;
for i=1:1
   for j=1:numeroDeMuestras
      valorAux= valorAux + pasoCuantificacion;
      cuantificacion(i, j)= valorAux;
   end
end

% Calculamso la matriz de error cuantificada
for i=1:m
   for j=1:n
      for k=1: numeroDeMuestras
         if e(i, j) <= cuantificacion(1, k)
           meq(i, j)= k-1;
           break
         end
      end
   end
end

% Calculamos la matriz de error cuantificada inversa
for i=1:m
   for j=1:n
      if meq(i, j) == 0
        meqInversa(i, j)= cuantificacion(1, 1)/2;  
      end

      if meq(i, j) > 0
        meqInversa(i, j)= ((cuantificacion(1, meq(i, j)+1))+(cuantificacion(1, meq(i, j))))/2;
      end
   end
end
   
% Recuperamos la imagen
r= round(meqInversa + p);
r= uint8(r);

subplot(1,4,4)
imshow(r)
title("Imagen recuperada")

% calculos
o= double(o);
r= double(r);
db= 10*log(sum(o^2)/sum((o-r)^2));
fprintf('S/N= %.3f', db)
