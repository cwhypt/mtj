T_x=linspace(0,5,51)';
T_sc=zeros(51,2);
count=1;
global flag0
flag0=flag;
h=figure;
h.Position=[50 50 1200 700];
for j=0:pi/9:pi
    count=1;
    for k=0:0.1:5
        [T_sc(count,1),T_sc(count,2)]=T(k,j);
        count=count+1;

    end
    flag0.plotsev(h,T_x,T_sc(:,1),T_sc(:,2), 'Xlabel','E_{inc} (eV)','Ylabel','|t^L_{u-u}|^2 and |t^L_{d-d}|^2','title',sprintf('Prob vs. E_{inc}'),'Y1legend',sprintf('UU-¦È_2=%0.1f',j/pi),'Y2legend',sprintf('DD-¦È_2=%0.1f',j/pi),'save','true','clear','false');
    
end

figure(h)
legend(flag0.plotsev_leg)