T_x=linspace(0,5,51);
T_sc=zeros(51,2);
count=1;
global flag0
flag0=flag;
for j=0:0.1:5
    [T_sc(count,1),T_sc(count,2)]=T_2x2_random(j);
        count=count+1;
end

flag0.plot2(3,T_x,T_sc(:,1),T_sc(:,2), 'Xlabel','E(0-5eV)','Ylabel','Probability','title','Tunneling Probability','save','true');

count=1;
for i=0:0.001:1
    T(count,1)=1/(1+(0.3)^2/(4*i*(0.3+i))*(sin(2*5e-10*sqrt(2*me*e*(0.3+i))/hbar))^2);
    count=count+1;
end
plot(T)