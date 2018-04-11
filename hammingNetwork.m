%Nombre del archivo a leer
nombre= input('Ingresa el nombre del archivo: ','s');
%leer el archivo y guardarlo en una matriz
archivo = dlmread(nombre);
%Obtener las dimensiones de la matriz R y S
tam = size(archivo);
%Tamaño de los vectores prototipo R
R = tam(2);
%Numero de neuronas, corresponde a cada vector prototipo
%El ultimo vector prototipo del archivo es el que sera evaluado
S = tam(1) - 1;

%---------------Capa de propagacion hacia adelante------------
%vector a clasificar
p=archivo(S+1,:);
%Matriz de pesos
w1=archivo(1:S,:);
%Obtenemos el bias
bias=ones(S,1) * R;
%Resulado de a1
a1 = purelin ( (w1 * p' )+ bias);
%--------------Capa Recurrente----------------
a2 = a1;
%Creamos la matriz de epsilon
epsilon = round(rand(1)*1/(S-1), 5);
w2 = ones(S,S)*-epsilon;
for i = 1:S
    for j = 1:S
        if i==j
            w2(i, j) = 1;
        end
    end;
end;
%Guardamos los resultados en un archivo para posteriormente utilizarlo para
%grafica
res = fopen('iteracionHamming.txt','w');
%Escribimos en el archivo el primer resultado obtenido
fprintf(res,'%.10f ',a2');
fprintf(res,'\n');
correcto=0;
%Realizamos las iteraciones pertinentes de la capa recurrente
for iteracion = 1:100000
   atsig = poslin(w2*a2);
   fprintf(res,'%.10f ',atsig');
   fprintf(res,'\n');
   if atsig == a2
       for dato = atsig'
           if(dato~=0)
               correcto=correcto+1;
           end
       end
       fclose(res);
       break;       
   else
       a2 = atsig;
   end
end

%imprimimos el resultado
if(correcto==1)
    for pos = 1:length(atsig');
       if(atsig(pos)~=0)
           clase = pos;
           break;
       end
    end
    fprintf('El vector pertenece a la clase %d \n',clase);
else
    fprintf('No se encontro la clase en las iteraciones realizadas \n'); 
end

%Se lee el archivo iteracionHamming y graficamos los valores
datosGrafica = dlmread('iteracionHamming.txt');
display(datosGrafica);
tamanio = size(datosGrafica);
noIteraciones = tamanio(1);
figure('Name', 'Hamming Network');
plot(0:noIteraciones-1, datosGrafica);
xlabel('t');
ylabel('a^2(t)');
etiquetas = cell(1, S);
for i = 1:S
    etiquetas{i} = ['P' num2str(i)];
end;
legend(etiquetas);
