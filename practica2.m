function practica2
    in=input('Numero de entradas: ');
    tfun = input('Tipo de funcion: 1.- And 2.- Or : ');
    cb = comb(in);
    if(tfun==1)
        [w,t,c]=McCulloch(1,cb,in);
    else
        [w,t,c]=McCulloch(2,cb,in);
    end
    if(c==1)
    fprintf('W= ');
    disp(w);
    fprintf('Teta= ');
    disp(t);
    else
        fprintf('No se encontraron los valores\n');
    end
end

function [mtt]=comb(entradas)
    mtt=zeros(2^entradas,entradas);
    for i=1:2^entradas
        mtt(i,1:entradas)=de2bi(i-1,entradas);
    end
end

function [w,teta,correcto]= McCulloch(tipo,comb,ins)
    correcto=0;
    for iteracion=1:20000
        w = round( -10 + (10-(-10)).*rand(1,ins));
        teta = round( -10 + (10-(-10)).*rand(1,1));
        isSolucion=0;
        for i=1:2^ins
           if(tipo==1)
            if(sum(comb(i,1:end))== ins)
                target = 1;
            else 
                target = 0;
            end   
           else
            if(sum(comb(i,1:end))> 0)
                target = 1;
            else 
                target = 0;
            end
          end
          if(Compara(comb,target,i,w,teta,ins)==1)
            isSolucion=isSolucion+1;
          else
             break;
          end
        end
        if(isSolucion==2^ins)
            correcto=1;
            break;
        end
    end
end

function [exito]= Compara(comb,target,fila,w,teta,ins)
    n=0;
    for pos=1:ins
       n = n + comb(fila,pos)* w(pos);
    end
    if(n>teta)
        a=1;
    else
        a=0;
    end
    disp([fila,n,teta,a,target]);
    if(a==target)
        exito=1;
    else
        exito=-1;
    end
end
