T_x=linspace(0,pi,11)';
T_sc=zeros(11,2);
count=1;
global flag0
flag0=flag;
h=figure;
for k=0:0.5:5
    count=1;
    for j=0:pi/10:pi
        [T_sc(count,1),T_sc(count,2)]=T(k,j);
        count=count+1;

    end
    flag0.plotsub(h,2,5,3,T_x,T_sc(:,1),T_sc(:,2), 'Xlabel','¦È_2 (0-pi)','Ylabel','Probability','title',sprintf('P(E=%0.1feV)',k),'Y1legend',sprintf('Up'),'Y2legend',sprintf('Down'),'save','true','clear','false');
    pause(2) 
end

