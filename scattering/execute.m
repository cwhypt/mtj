T_x=linspace(0,1,51)';
T_sc=zeros(51,2);
count=1;
global flag0
flag0=flag;
for j=0:0.02:1
    [T_sc(count,1),T_sc(count,2)]=T(j);
        count=count+1;
end

flag0.plot2(3,T_x,T_sc(:,1),T_sc(:,2), 'Xlabel','E(0-1eV)','Ylabel','Probability','title','Tunneling Probability','Y1legend','|t_{uu}|^2+t_{du}|^2','Y2legend','|t_{ud}|^2+t_{dd}|^2', 'save','true');

