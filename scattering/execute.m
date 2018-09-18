T_x=linspace(0,5,51)';
T_sc=zeros(51,2);
count=1;
global flag0
flag0=flag;
h=figure;
for j=0:pi/9:pi
    count=1;
    for k=0:0.1:5
        [T_sc(count,1),T_sc(count,2)]=T(k,j);
        count=count+1;

    end
    flag0.plotsub(h,2,5,3,T_x,T_sc(:,1),T_sc(:,2), 'Xlabel','E_{inc} (eV)','Ylabel','|t^L_{u-u}|^2 and |t^L_{d-d}|^2','title',sprintf('Angle ¦È_2=%0.1fpi',j/pi),'Y1legend',sprintf('U->U'),'Y2legend',sprintf('D->D'),'save','true','clear','false');
    
end

