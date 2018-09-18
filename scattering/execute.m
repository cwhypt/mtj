T_x=linspace(0,1,21)';
T_sc=zeros(21,2);
count=1;
global flag0
flag0=flag;
h=figure;
for k=0.5:0.5:5
    count=1;
    for j=0:pi/20:pi
        [T_sc(count,1),T_sc(count,2)]=T(k,j);
        count=count+1;

    end
    flag0.plotsub(h,2,5,3,T_x,T_sc(:,1),T_sc(:,2), 'Xlabel','¦È_2 (pi)','Ylabel','|t^L_{u-u}|^2 and |t^L_{d-d}|^2','title',sprintf('Incident E=%0.1feV',k),'Y1legend',sprintf('U->U'),'Y2legend',sprintf('D->D'),'save','true','clear','false');
    
end

