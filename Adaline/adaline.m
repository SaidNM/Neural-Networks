function adaline()
    fprintf('1. Adaline 2 dimensiones 2. Adaline mas de 2 dimensiones\n');
    opcion = input ('Elige la opcion adecuada:');
    eit = input('Introduce el error minimo: ');
    prototipos = dlmread('prototipos.txt');
    targets = dlmread('targets.txt');
    tam = size(prototipos);
    if(opcion == 1)
        %adaline de dos dimensiones
        [w,b,alpha]=learning(prototipos,targets,eit);
        %Graficamos los puntos y las fronteras de decision
        hold on
        for i = 1:tam(1)
            plot(prototipos(i,1),prototipos(i,2),'ro');
        end
        tamb = size(b);
        display(tamb);
        if(tamb(1)==1)
            plot([0 -b/w(1)],[-b/w(2) 0],'g');
        else
            x = -1:1;
            y=(0-(-b(1,1)/w(1,2))/(-b(1,1)/w(1,1))-0)*(x)+(-b(1,1)/w(1,2));
            plot(x,y,'b');
            y1 = (0-(-b(2,1)/w(2,2))/(-b(2,1)/w(2,1))-0)*(x)+(-b(2,1)/w(2,2));
            plot(x,y1,'g');
        end
        grid on
        hold off
    else
        %adaline de mas de dos dimensiones
        [w,b,alpha,it]=learning(prototipos,targets,eit);
        %Obtenemos los datos para la grafica
        grafica = dlmread('iteracionAdaline.txt');
        datosError = dlmread('errorAdaline.txt');
        %Graficamos los datos
        hold on
        plot(0:it,grafica(:,1:tam(2)),'g');
        plot(0:it,grafica(:,tam(2)+1),'b');
        plot(0:it-1,datosError,'r');
        %Añadimos las etiquetas correspondientes
        xlabel('epoch');
        ylabel('valor');
        tam = size(grafica);
        etiquetas=cell(1,tam(2));
        for z = 1:tam(2)-1
           etiquetas{z}=['W'  num2str(z)];
        end
            etiquetas{tam(2)}='bias';
            etiquetas{tam(2)+1}='error';
        legend(etiquetas);
        hold off
    end
        fprintf('Pesos W\n');
        disp(w);
        fprintf('bias b\n');
        disp(b);
        fprintf('alpha \n');
        disp(alpha);
end

function [w,b,alpha,it] = learning(prototipos,targets,eit)
    res = fopen('iteracionAdaline.txt','w');
    arche = fopen('errorAdaline.txt','w');
    paro =0;
    tamW = size(prototipos);
    noVectores = tamW(1);
    R = tamW(2);
    tamB = size(targets);
    if(tamB(2)==1)
        S = 1;
    else
        S = 2;
    end
    w = rand(S,R);
    b = rand(S,1);
    fprintf(res,'%0.4f %0.4f ',w,b);
    fprintf(res,'\n');
    alpha = input('Introduce alpha: ');
    e = ones(1,noVectores);
    for epoch = 1: 10000
       for i = 1:noVectores
           a = purelin (w * prototipos(i,:)' + b);
           error = targets(i,:)' - a;
           errorAbs = abs(error);
           e(1,i) = sum(errorAbs);
           w = w + 2 * alpha * error * prototipos(i,:);
           b = b + 2 * alpha * error;
       end
       fprintf(res,'%0.4f %0.4f ',w,b);
       fprintf(res,'\n');
       fprintf('epoca %0.1f\n',epoch);
       errorProm = (1/noVectores)* sum(e);
       fprintf(arche,'%0.4f\n',errorProm);
        if(errorProm == 0)
            paro=1;
            it=epoch;
            break;
        end
        if(errorProm <= eit)
            paro = 1;
            it= epoch;
            display(errorProm);
            break
        end
    end
    if(paro ~= 1)
        fprintf('\nLas epocas acabaron los ultimos resultados son: \n');
        it=10000;
        fprintf('error %0.6f\n',errorProm);
    end
    fclose(res);
    fclose(arche);
end