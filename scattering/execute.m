T_x=linspace(0,1,101);
T_sc=zeros(101,2);
count=1;
global flag0
flag0=flag;
for j=0:0.01:1
    [T_sc(count,1),T_sc(count,2)]=T_2x2(j);
        count=count+1;
end

flag0.plot2(3,T_x,T_sc(:,1),T_sc(:,2), 'Xlabel','E(0-5eV)','Ylabel','Probability','title','Tunneling Probability','save','true');

