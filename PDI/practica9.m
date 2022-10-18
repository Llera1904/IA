clc
clear
close all
warning off all

a= imread("cameraman.tif");
o= a;

figure(1)
subplot(1,4,1)
imshow(o)
title("Original")

% o= double(o);
o= round(dct2(o));
[m, n]= size(o);
p= zeros(m, n);

% Primer predictor (DC)
i= 1;
k= 1;
while  i ~= m+1
    j= 1;
    l= 1;
    while j ~= n+1
        matrizDC(k, l)= o(i, j);
        j= j+8;
        l= l+1;
    end
    i= i+8;
    k= k+1;
end 
prediccionDC= matrizPrediccion(matrizDC);

% Segundo predictor (Altas frecuencias horizontales)
i= 1;
k= 1;
while  i ~= m+1
    j= 2;
    l= 1;
    while j ~= n+2
        matrizAFH(k, l:l+6)= o(i, j:j+6);
        j= j+8;
        l= l+7;
    end
    i= i+8;
    k= k+1;
end 
prediccionAFH= matrizPrediccion(matrizAFH);

% Tercer predictor (Altas frecuencias verticales)
i= 2;
k= 1;
while  i ~= m+2
    j= 1;
    l= 1;
    while j ~= n+1
        matrizAFV(k:k+6, l)= o(i:i+6, j);
        j= j+8;
        l= l+1;
    end
    i= i+8;
    k= k+7;
end 
prediccionAFV= matrizPrediccion(matrizAFV);

% Cuarto predictor (Bajas frecuencias)
i= 2;
k= 1;
while  i ~= m+2
    j= 2;
    l= 1;
    while j ~= n+2
        matrizBF(k:k+6, l:l+6)= o(i:i+6, j:j+6);
        j= j+8;
        l= l+7;
    end
    i= i+8;
    k= k+7;
end 
prediccionBF= matrizPrediccion(matrizBF);

% Empezamos a regresar los valores a la matriz original
% Primer predictor (DC)
i= 1;
k= 1;
while  i ~= m+1
    j= 1;
    l= 1;
    while j ~= n+1
        p(i, j)= prediccionDC(k, l);
        j= j+8;
        l= l+1;
    end
    i= i+8;
    k= k+1;
end 

% Segundo predictor (Altas frecuencias horizontales)
i= 1;
k= 1;
while  i ~= m+1
    j= 2;
    l= 1;
    while j ~= n+2
        p(i, j:j+6)= prediccionAFH(k, l:l+6);
        j= j+8;
        l= l+7;
    end
    i= i+8;
    k= k+1;
end 

% Tercer predictor (Altas frecuencias verticales)
i= 2;
k= 1;
while  i ~= m+2
    j= 1;
    l= 1;
    while j ~= n+1
        p(i:i+6, j)= prediccionAFV(k:k+6, l);
        j= j+8;
        l= l+1;
    end
    i= i+8;
    k= k+7;
end 

% Cuarto predictor (Bajas frecuencias)
i= 2;
k= 1;
while  i ~= m+2
    j= 2;
    l= 1;
    while j ~= n+2
        p(i:i+6, j:j+6)= prediccionBF(k:k+6, l:l+6);
        j= j+8;
        l= l+7;
    end
    i= i+8;
    k= k+7;
end 

p= round(idct2(p));
p= uint8(p);
subplot(1,4,2)
imshow(p)
title("Prediccion")

p= round(dct2(p));

% Calculamos la matriz e
for i=1:m
   for j=1:n
      e(i, j)= o(i, j)- p(i,j);
   end
end

e= round(idct2(e));
e= uint8(e);
subplot(1,4,3)
imshow(e)
title("Error")

e= round(dct2(e));

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

% Calculamos la matriz de error cuantificada
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
r= round(idct2(r));
r= uint8(r);

subplot(1,4,4)
imshow(r)
title("Imagen recuperada")

% calculos
o= round(idct2(o));
r= double(r);
db= 10*log(sum(o^2)/sum((o-r)^2));
fprintf('S/N= %.3f', db)

function p= matrizPrediccion(o)
      % prengutamos las dimeciones de la matriz o y creamos la matriz p con ceros
      % y las mismas dimensiones de o
      [m, n]= size(o);
      p= zeros(m, n);
        
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
      i= 2;
      while i <= m-1
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
          i= i+2;
      end

      i= i-1;
      j= 2;
      while j <= n-2
          p(i+1, j)= round((p(i, j-1) + p(i, j) + p(i, j+1) + p(i+1, j-1))/4);
          p(i+1, j+1)= round((p(i, j) + p(i, j+1) + p(i+1, j))/3);
          j= j+2;
      end  
      j= j-1;
      p(i+1, j+1)= round((p(i, j) + p(i, j+1) + p(i+1, j))/3);

end