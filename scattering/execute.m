T_x=linspace(0,pi,11)';
T_sc=zeros(11,2);
count=1;
global flag0
flag0=flag;
for j=0:pi/10:pi
    [T_sc(count,1),T_sc(count,2)]=T(4.875,j);
        count=count+1;
end

flag0.plot2(3,T_x,T_sc(:,1),T_sc(:,2), 'Xlabel','¦È_2 (0-pi)','Ylabel','Probability','title','Tunneling Probability vs. angle','save','true');

