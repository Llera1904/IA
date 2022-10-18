clc
clear
close all
warning off all

a= imread("cameraman.tif");

% Valor de la matriz a codificar
matriz8x8= 160;
matrizAux= zeros(32, 32);
% Llenamos la matriz Aux del 1 al 1024
suma= 0;
for i=1:32
   for j=1:32
      suma= suma + 1;
      matrizAux(i, j)= suma;
   end   
end

% Obtenemos la matriz a codificar 8x8
[fila, columna]= find(matrizAux==matriz8x8);
b= a((fila*8)-7:fila*8, (columna*8)-7:columna*8);

% b= [52 55 61 66 70 61 64 73;
%     63 59 66 90 109 85 69 72;
%     62 59 68 113 144 104 66 73;
%     63 58 71 122 154 106 70 69;
%     67 61 68 105 126 88 68 70;
%     79 65 60 70 77 68 58  75;
%     85 71 64 59 55 61 65 83;
%     87 79 69 68 65 76 78 94];

[n, m]= size(b);

c= double(b);
c= c - 128;
c= round(dct2(c));

% Constantes
% Tabla de codificacion de JPEG
tablaJPEG= [16 11 10 16 24 40 51 61;
            12 12 14 19 26 58 60 55;
            14 13 16 24 40 57 69 56;
            14 17 22 29 51 87 80 62;
            18 22 37 56 68 109 103 77;
            24 35 55 64 81 104 113 92;
            49 64 78 87 103 121 120 101;
            72 92 95 98 112 100 103 99];

categoriaDC= ["0" "010" "3";

              "1" "011" "4";
              "2" "100" "5";
              "3" "00" "5";
              "4" "101" "7";
              "5" "110" "8";
              "6" "1110" "10";
              "7" "11110" "12";
              "8" "111110" "14";
              "9" "1111110" "16";
              "A" "11111110" "18";
              "B" "111111110" "20"];

categoriaRun= ["EOB" "1010" "4";

               "0/1" "00" "3";
               "0/2" "01" "4";
               "0/3" "100" "6";
               "0/4" "1011" "8";
               "0/5" "11010" "10";
               "0/6" "111000" "12";
               "0/7" "1111000" "14";
               "0/8" "1111110110" "18";
               "0/9" "11111111110000010" "25";
               "0/A" "11111111110000011" "26";

               "1/1" "1100" "5";
               "1/2" "111001" "8";
               "1/3" "1111001" "10";
               "1/4" "111110110" "13";
               "1/5" "11111110110" "16";
               "1/6" "1111111110000100" "22";
               "1/7" "1111111110000101" "23";
               "1/8" "1111111110000110" "24";
               "1/9" "1111111110000111" "25";
               "1/A" "1111111110001000" "26";

               "2/1" "11011" "6";
               "2/2" "11111000" "10";
               "2/3" "1111110111" "13";
               "2/4" "1111111110001001" "20";
               "2/5" "1111111110001010" "21";
               "2/6" "1111111110001011" "22";
               "2/7" "1111111110001100" "23";
               "2/8" "1111111110001101" "24";
               "2/9" "1111111110001110" "25";
               "2/A" "1111111110001111" "26";

               "3/1" "111010" "7";
               "3/2" "111110111" "11";
               "3/3" "11111110111" "14";
               "3/4" "1111111110010000" "20";
               "3/5" "1111111110010001" "21";
               "3/6" "1111111110010010" "22";
               "3/7" "1111111110010011" "23";
               "3/8" "1111111110010100" "24";
               "3/9" "1111111110010101" "25";
               "3/A" "1111111110010110" "26";

               "4/1" "111011" "7";
               "4/2" "1111111000" "12";
               "4/3" "1111111110010111" "19";
               "4/4" "1111111110011000" "20";
               "4/5" "1111111110011001" "21";
               "4/6" "1111111110011010" "22";
               "4/7" "1111111110011011" "23";
               "4/8" "1111111110011100" "24";
               "4/9" "1111111110011101" "25";
               "4/A" "1111111110011110" "26";

               "5/1" "1111010" "8";
               "5/2" "1111111001" "12";
               "5/3" "1111111110011111" "19";
               "5/4" "1111111110100000" "20";
               "5/5" "1111111110100001" "21";
               "5/6" "1111111110100010" "22";
               "5/7" "1111111110100011" "23";
               "5/8" "1111111110100100" "24";
               "5/9" "1111111110100101" "25";
               "5/A" "1111111110100110" "26";

               "6/1" "1111011" "8";
               "6/2" "11111111000" "13";
               "6/3" "1111111110100111" "19";
               "6/4" "1111111110101000" "20";
               "6/5" "1111111110101001" "21";
               "6/6" "1111111110101010" "22";
               "6/7" "1111111110101011" "23";
               "6/8" "1111111110101100" "24";
               "6/9" "1111111110101101" "25";
               "6/A" "1111111110101110" "26";

               "7/1" "11111001" "9";
               "7/2" "11111111001" "13";
               "7/3" "1111111110101111" "19";
               "7/4" "1111111110110000" "20";
               "7/5" "1111111110110001" "21";
               "7/6" "1111111110110010" "22";
               "7/7" "1111111110110011" "23";
               "7/8" "1111111110110100" "24";
               "7/9" "1111111110110101" "25";
               "7/A" "1111111110110110" "26";

               "8/1" "11111010" "9";
               "8/2" "111111111000000" "17";
               "8/3" "1111111110110111" "19";
               "8/4" "1111111110111000" "20";
               "8/5" "1111111110111001" "21";
               "8/6" "1111111110111010" "22";
               "8/7" "1111111110111011" "23";
               "8/8" "1111111110111100" "24";
               "8/9" "1111111110111101" "25";
               "8/A" "1111111110111110" "26";

               "9/1" "111111000" "10";
               "9/2" "1111111110111111" "18";
               "9/3" "1111111111000000" "19";
               "9/4" "1111111111000001" "20";
               "9/5" "1111111111000010" "21";
               "9/6" "1111111111000011" "22";
               "9/7" "1111111111000100" "23";
               "9/8" "1111111111000101" "24";
               "9/9" "1111111111000110" "25";
               "9/A" "1111111111000111" "26";

               "A/1" "111111001" "10";
               "A/2" "1111111111001000" "18";
               "A/3" "1111111111001001" "19";
               "A/4" "1111111111001010" "20";
               "A/5" "1111111111001011" "21";
               "A/6" "1111111111001100" "22";
               "A/7" "1111111111001101" "23";
               "A/8" "1111111111001110" "24";
               "A/9" "1111111111001111" "25";
               "A/A" "1111111111010000" "26";

               "B/1" "111111010" "10";
               "B/2" "1111111111010001" "18";
               "B/3" "1111111111010010" "19";
               "B/4" "1111111111010011" "20";
               "B/5" "1111111111010100" "21";
               "B/6" "1111111111010101" "22";
               "B/7" "1111111111010110" "23";
               "B/8" "1111111111010111" "24";
               "B/9" "1111111111011000" "25";
               "B/A" "1111111111011001" "26";

               "C/1" "1111111010" "11";
               "C/2" "1111111111011010" "18";
               "C/3" "1111111111011011" "19";
               "C/4" "1111111111011100" "20";
               "C/5" "1111111111011101" "21";
               "C/6" "1111111111011110" "22";
               "C/7" "1111111111011111" "23";
               "C/8" "1111111111100000" "24";
               "C/9" "1111111111100001" "25";
               "C/A" "1111111111100010" "26";

               "D/1" "11111111010" "12";
               "D/2" "1111111111100011" "18";
               "D/3" "1111111111100100" "19";
               "D/4" "1111111111100101" "20";
               "D/5" "1111111111100110" "21";
               "D/6" "1111111111100111" "22";
               "D/7" "1111111111101000" "23";
               "D/8" "1111111111101001" "25";
               "D/9" "1111111111101010" "25";
               "D/A" "1111111111101011" "26";

               "E/1" "111111110110" "13";
               "E/2" "1111111111101100" "18";
               "E/3" "1111111111101101" "19";
               "E/4" "1111111111101110" "20";
               "E/5" "1111111111101111" "21";
               "E/6" "1111111111110000" "22";
               "E/7" "1111111111110001" "23";
               "E/8" "1111111111110010" "24";
               "E/9" "1111111111110011" "25";
               "E/A" "1111111111110100" "26";

               "F/0" "111111110111" "12";
               "F/1" "1111111111110101" "17";
               "F/2" "1111111111110110" "18";
               "F/3" "1111111111110111" "19";
               "F/4" "1111111111111000" "20";
               "F/5" "1111111111111001" "21";
               "F/6" "1111111111111010" "22";
               "F/7" "1111111111111011" "23";
               "F/8" "1111111111111100" "24";
               "F/9" "1111111111111101" "25";
               "F/A" "1111111111111110" "26"];              

% Matriz a codificar         
d= round(c./tablaJPEG);

% Recorrido de la matriz
i= 2;
j= 1;
l= 4;
cambioDireccion= false;
arregloRecorrido(1, 1)= d(1, 1);
arregloRecorrido(1, 2)= d(1, 2);
arregloRecorrido(1, 3)= d(2, 1);
while l ~= 64
    % Fijamos los limites y los cambios de direccion
    if i - 1 == 0 && cambioDireccion == false
      j= j + 1;
      direccion= "baja";
      cambioDireccion= true;
      arregloRecorrido(1, l)= d(i, j);
      l= l + 1;
    end

    if i + 1 < n && j - 1 == 0 && cambioDireccion == false
      i= i + 1;
      direccion= "sube";
      cambioDireccion= true;
      arregloRecorrido(1, l)= d(i, j);
      l= l + 1;
    end

    if i + 1 > n && cambioDireccion == false
      j= j + 1;
      direccion= "sube";
      cambioDireccion= true;
      arregloRecorrido(1, l)= d(i, j);
      l= l + 1;
    end

    if j + 1 > m && cambioDireccion == false
      i= i + 1;
      direccion= "baja";
      cambioDireccion= true;
      arregloRecorrido(1, l)= d(i, j);
      l= l + 1;
    end

    % Recorre la matriz hacia abajo y hacia arriba
    if direccion == "baja"
      i= i + 1;
      j= j - 1;
      cambioDireccion= false;
      arregloRecorrido(1, l)= d(i, j);
      l= l + 1;
    end

    if direccion == "sube"
      i= i - 1;
      j= j + 1;
      arregloRecorrido(1, l)= d(i, j);
      cambioDireccion= false;
      l= l + 1;
    end
end
arregloRecorrido(1, 64)= d(8, 8);

% Codificacion
% Codificacion del elemento DC
valorCodificar= arregloRecorrido(1, 1);
if matriz8x8 ~= 1
  [fila, columna]= find(matrizAux==matriz8x8-1);
  aux= double(a((fila*8)-7:fila*8,(columna*8)-7:columna*8));
  aux= aux - 128;
  aux= round(dct2(aux));
  aux= round(aux./tablaJPEG);
  valorCodificar= valorCodificar-(aux(1, 1));
end

categoria= categoryDC(valorCodificar);
[indice, ~]= find(categoriaDC==categoria);
longitudCodigo= strlength(categoriaDC(indice(1, 1), 2));

if valorCodificar >= 0
  numeroBinario= dec2bin(valorCodificar, double(categoriaDC(indice(1, 1), 3))-longitudCodigo);
  arregloCodificacion(1, 1)= categoriaDC(indice(1, 1), 2) + string(numeroBinario);
end
  
if valorCodificar < 0
  numeroBinario= dec2bin(-1*valorCodificar, double(categoriaDC(indice(1, 1), 3))-longitudCodigo);
  numeroBinario= invertirBinario(numeroBinario);
  numeroBinario= dec2bin((bin2dec(numeroBinario) + bin2dec('1')), double(categoriaDC(indice(1, 1), 3))-longitudCodigo);
end 

matrizCodificacion(1, 1)= string(valorCodificar);
matrizCodificacion(1, 2)= categoriaDC(indice(1, 1), 2) + string(numeroBinario);

% Codificacion de run/category
l= 2;
ceros= 0;
for i=2:length(arregloRecorrido)
   if arregloRecorrido(1, i) ~= 0
     valorCodificar= arregloRecorrido(1, i);

     categoria= ceros + "/" + categoryDC(valorCodificar);
     [indice, ~]= find(categoriaRun==categoria);
     longitudCodigo= strlength(categoriaRun(indice(1, 1), 2));
        
     if valorCodificar >= 0
       numeroBinario= dec2bin(valorCodificar, double(categoriaRun(indice(1, 1), 3))-longitudCodigo);
       arregloCodificacion(1, 1)= categoriaRun(indice(1, 1), 2) + string(numeroBinario);
     end
          
     if valorCodificar < 0
       numeroBinario= dec2bin(-1*valorCodificar, double(categoriaRun(indice(1, 1), 3))-longitudCodigo);
       numeroBinario= invertirBinario(numeroBinario);
       numeroBinario= dec2bin((bin2dec(numeroBinario) + bin2dec('1')), double(categoriaRun(indice(1, 1), 3))-longitudCodigo);
     end 
        
     matrizCodificacion(l, 1)= string(valorCodificar);
     matrizCodificacion(l, 2)= categoriaRun(indice(1, 1), 2) + string(numeroBinario);
     l= l + 1;
     ceros= 0;
   elseif arregloRecorrido(1, i) == 0
     ceros= ceros + 1;
   end
end
[l, ~]= size(matrizCodificacion);
matrizCodificacion(l+1, 1)= categoriaRun(1, 1);
matrizCodificacion(l+1, 2)= categoriaRun(1, 2);

function binarioInvertido= invertirBinario(numeroBinario)
binarioInvertido= numeroBinario;
for i=1:length(binarioInvertido)
   if binarioInvertido(1, i) == '1'
     binarioInvertido(1, i)= '0';
   elseif binarioInvertido(1, i) == '0'
     binarioInvertido(1, i)= '1';
   end    
end
end

function categoria= categoryDC(valorCodificar)
if valorCodificar == 0
  categoria= "0";
elseif valorCodificar <= 1 && valorCodificar >= -1
  categoria= "1";
elseif valorCodificar <= 3 && valorCodificar >= -3
  categoria= "2";
elseif valorCodificar <= 7 && valorCodificar >= -7
  categoria= "3";
elseif valorCodificar <= 15 && valorCodificar >= -15
  categoria= "4";
elseif valorCodificar <= 31 && valorCodificar >= -31
  categoria= "5";
elseif valorCodificar <= 63 && valorCodificar >= -63
  categoria= "6";
elseif valorCodificar <= 127 && valorCodificar >= -127
  categoria= "7";
elseif valorCodificar <= 255 && valorCodificar >= -255
  categoria= "8";
elseif valorCodificar <= 511 && valorCodificar >= -511
  categoria= "9";
elseif valorCodificar <= 1023 && valorCodificar >= -1023
  categoria= "A";
elseif valorCodificar <= 2047 && valorCodificar >= -2047
  categoria= "B";
end
end