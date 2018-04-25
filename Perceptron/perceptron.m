function perceptron()
    opcion = input('1.- Solo dos dimensiones  2.-Mas de dos dimensiones\nElija la opcion deseada: ');
    if opcion == 1
        [p,t]= getPT('vector.txt');
        [w,b]= training(p,t);
        display(w);
        display(b);
        plot(p(:,1),p(:,2),'r.',[0 -b/w(1)],[-b/w(2) 0],'g',[0 w(1)],[0 w(2)],'b','MarkerSize',30);
        xlabel('P1');
        ylabel('P2');
        etiquetas=cell(1,3);
        etiquetas{1}= 'Data Set';
        etiquetas{2}= 'Decision Boundery';
        etiquetas{3}= 'Vector W';
        legend(etiquetas);
    else
        [p,t]= getPT('vectorD.txt');
        [w,b]= training(p,t);
        display(w);
        display(b);
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
function [w,b]=training(p,t)
    %Archivo en el cual se escriben los resultados.
    res = fopen('iteracionPerceptron.txt','w');
    w=rand(1,length(p(1,:)));
    b=rand(1,1);
    tam = size(p);
    np = tam(1);
    v = 1;
    correcto=0;
    for i = 1:100
       if(v==np+1)
        v=1;
       end
       pe=p(v,:);
       a = hardlim(w*pe'+b);
       error = t(v)-a;
       w=w+error*pe;
       b=b+error;
       v=v+1;
       if(error==0)
           correcto=correcto+1;
       else
           correcto=0;
       end
       display(pe);
       display(error);
       display (correcto);
       if(correcto==np)
           fprintf('\n El resultado convergio');
           break;
       end
    end
    if(correcto~=np)
       fprintf('\nEl resultado no convergio, se muestran los valores de W y b finales:');
    end
    fclose(res);
end

