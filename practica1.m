x = input('Introduce el vector 1 ');
y = input('Introduce el vector 2 ');
for c = 1:(length(x)-1)
    rs = strcat('a',int2str(c), ' =');
    if y(c) == 1
        rs=strcat(rs,' purelin(');
    elseif y(c) == 2
        rs=strcat(rs,' logsig(');
    else
        rs=strcat(rs,' tansig(');
    end
    if c==1
        fprintf(strcat(rs,'W',int2str(c),'*p',int2str(c),' +',' b',int2str(c),')'));
    else
        fprintf(strcat(rs,'W',int2str(c),'*a',int2str(c-1),' +',' b',int2str(c),')'));
    end
    fprintf('\n');
    fprintf(strcat(int2str(x(c+1)),'x1','\t\t\t',int2str(x(c+1)),'x',int2str(x(c)),'\t',int2str(x(c)),'x1','\t',int2str(x(c+1)),'x1'));
    fprintf('\n');
end
