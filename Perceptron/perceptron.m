function perceptron()
    opcion = input('1.- Solo dos dimensiones  2.-Mas de dos dimensiones\nElija la opcion deseada: ');
    if opcion == 1
        [p,t]= getPT('vector.txt');
        [w,b]= training(p,t);
        display(w);
        display(b);
        tam=size(p);
        %Aqui va el codigo para graficar cada uno de los puntos
        hold on
        for i = 1:tam(1)
           if(t(i)==0)
               plot(p(i,1),p(i,2),'ro');
           else
               plot(p(i,1),p(i,2),'r.','MarkerSize',25);
           end 
        end
        plot([0 -b/w(1)],[-b/w(2) 0],'g',[0 w(1)],[0 w(2)],'b','MarkerSize',30);
        %Añadimos las etiquetas correspondientes
        xlabel('P1');
        ylabel('P2');
        etiquetas=cell(1,tam(1)+2);
        for et = 1: tam(1)
            etiquetas{et}=['P'  num2str(et)];
        end
        etiquetas{tam(1)+1}= 'Decision Boundery';
        etiquetas{tam(1)+2}= 'Vector W';
        legend(etiquetas);
        hold off
    else
        [p,t]= getPT('vectorD.txt');
        [w,b,it]= training(p,t);
        display(w);
        display(b);
        %Obtenemos los datos para la grafica
        grafica = dlmread('iteracionPerceptron.txt');
        %Graficamos los datos
        plot(0:it,grafica);
        %Añadimos las etiquetas correspondientes
        xlabel('t');
        ylabel('valor');
        tam = size(grafica);
        etiquetas=cell(1,tam(2));
        for z = 1:tam(2)-1
           etiquetas{z}=['W'  num2str(z)];
        end
            etiquetas{tam(2)}='bias';
        legend(etiquetas);
    end
end

function[p,t]=getPT(archivo)
%Leemos el archivo que es para solo dos dimensiones
        archivo = dlmread(archivo); 
        tam = size(archivo);
%Obtenemos los vectores prototipo
        p=archivo(:,1:tam(2)-1);  
%Obtenemos el vector con los targets
        t=archivo(:,tam(2));
end

%Entrenamiento de para el perceptron de una neurona
function [w,b,it]=training(p,t)
    %Archivo en el cual se escriben los resultados.
    res = fopen('iteracionPerceptron.txt','w');
    w=rand(1,length(p(1,:)));
    b=rand(1,1);
    fprintf(res,'%0.4f %0.4f ',w,b);
    fprintf(res,'\n');
    tam = size(p);
    np = tam(1);
    v = 1;
    correcto=0;
    for i = 1:10000
       if(v==np+1)
        v=1;
       end
       pe=p(v,:);
       a = hardlim(w*pe'+b);
       error = t(v)-a;
       w = w +(error*pe);
       b=b+error;
       fprintf(res,'%0.7f %0.7f ',w,b);
       fprintf(res,'\n');
       v=v+1;
       if(error==0)
           correcto=correcto+1;
       else
           correcto=0;
       end
       if(correcto==np)
           fprintf('\n El resultado convergio');
           it=i;
           break;
       end
    end
    if(correcto~=np)
       fprintf('\nEl resultado no convergio, se muestran los valores de W y b finales:');
       it=10000;
    end
    fclose(res);
end

