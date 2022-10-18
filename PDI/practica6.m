clc
clear
close all
warning off all

a= imread("imagenes/kimetsu.jpg");
b= rgb2gray(a);
b= imnoise(b,'salt & pepper',0.05);

figure(1)
subplot(3,2,1)
imshow(rgb2gray(a))
title("Imagen original")

subplot(3,2,2)
imshow(b)
title("Imagen con ruido")

% a= [1 1 1 2 7; 8 3 2 1 1; 1 3 9 2 1; 1 2 2 3 1; 1 1 1 2 1];
% b= a;
[m, n]= size(b);

media= zeros(m ,n);
moda= zeros(m ,n);
maximos= zeros(m ,n);
minimos= zeros(m ,n);
aux= zeros(1, 9);

for i= 1:m
   for j= 1:n
      aux(1, 1)= b(i ,j);

      if i+1 > m || j-1 == 0
        aux(1, 2)= 0;
      else
        aux(1, 2)= b(i+1, j-1);
      end

      if j-1 == 0
        aux(1, 3)= 0;
      else
        aux(1, 3)= b(i, j-1);
      end

      if i-1 == 0 || j-1 == 0
        aux(1, 4)= 0;
      else
        aux(1, 4)= b(i-1, j-1);
      end

      if i-1 == 0 
        aux(1, 5)= 0;
      else
        aux(1, 5)= b(i-1, j);
      end

      if i-1 == 0 || j+1 > n
        aux(1, 6)= 0;
      else
        aux(1, 6)= b(i-1, j+1);
      end

      if j+1 > n
        aux(1, 7)= 0;
      else
        aux(1, 7)= b(i, j+1);
      end

      if i+1 > m || j+1 > n
        aux(1, 8)= 0;
      else
        aux(1, 8)= b(i+1, j+1);
      end

      if i+1 > m
        aux(1,9)= 0;
      else
        aux(1,9)= b(i+1, j);
      end
      aux= sort(aux, 'ascend');

      % Calculamos la moda 
      for k= 1:9
         suma= 0;
         dato= aux(1, k);
         for l= 1:9
            if dato == aux(1, l)
              suma= suma + 1;
            end
            auxModa(1, k)= suma;
         end
      end
      masRepetido= find(auxModa==max(auxModa));   
 
      % Matrices filtradas 
      media(i, j)= aux(1, 5);
      moda(i, j)= aux(1, masRepetido(1, 1));
      % moda(i, j)= mode(aux);
      maximos(i, j)= max(aux);
      minimos(i, j)= min(aux);
   end
end

media= uint8(media);
moda= uint8(moda);
maximos= uint8(maximos);
minimos= uint8(minimos);

subplot(3,2,3)
imshow(media)
title("media")

subplot(3,2,4)
imshow(moda)
title("moda")

subplot(3,2,5)
imshow(maximos)
title("maximos")

subplot(3,2,6)
imshow(minimos)
title("minimos")

% valores= [1 2 2 2 2 3 3 3 9];
% valoresRepetidos= mode(valores);
