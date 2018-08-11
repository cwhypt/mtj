

% 生成current
global X
global Y

%{

X=-19980:20:20000;X=(X/10000)';
Y=[];

Tt_deb=T(T_x);

for i=1:1:2000
    tmp=X(i,1);
    fprintf('Cycle %d  Energy %d \n; ',i,tmp);
    current=demo(6,tmp);
    %pause(1);
Y(i,1)=-current/1e44;
end

s=plot(X,Y)
title('Tunneling current vs. Vt')
xlabel('Vt (eV)')
ylabel('Tunneling current')
legend('I')
saveas(s,sprintf('C:\\Users\\cwhypt\\Documents\\MATLAB\\pic\\0.current_Vb_%0.2f.jpg',6));

%}




%{
%生成T(E) 从右边向左边
T_deb=zeros(20000,1);
tmp=X(2000);
I=Y(2000)*1e-44;
Ie=interp1(Xe,Ye,tmp);
miu_b=interp1(fermi_x,mb,X(2000));
miu_t=interp1(fermi_x,mt,X(2000));
Tmean=Ie/I;
T_l=interp1(m,(1:1:20000)',(miu_t));
T_l=floor(T_l);
T_r=interp1(m,(1:1:20000)',(miu_b));
T_r=ceil(T_r);
T_deb(T_l:T_r,1)=Tmean;
%}
for i=1999:-1:12
    tmp=X(i);tmp1=X(i+1);
    
    I=Y(i)*1e-44;
    Ie1=interp1(Xe,Ye,tmp);Ie2=interp1(Xe,Ye,tmp1);
    deltaI=Ie1-Ie2;
    miu_b1=interp1(fermi_x,mb,tmp,'spline');miu_b2=interp1(fermi_x,mb,tmp1,'spline');
    miu_t1=interp1(fermi_x,mt,tmp,'spline');miu_t2=interp1(fermi_x,mt,tmp1,'spline');
    T_l1=interp1(m,(1:1:20000)',(miu_t1));T_l2=interp1(m,(1:1:20000)',(miu_t2));
    T_l1=floor(T_l1);T_l2=floor(T_l2);
    T_r1=interp1(m,(1:1:20000)',(miu_b1));T_r2=interp1(m,(1:1:20000)',(miu_b2)');
    T_r1=ceil(T_r1);T_r2=ceil(T_r2);
    El_delta=miu_t2-miu_t1;Er_delta=miu_b2-miu_b1;
    
    T_num=deltaI+mean(T_deb(T_r1:T_r2,:))*Er_delta;  %Tdost_deb(T_r1:T_r2,:).*
    T_den=El_delta;   %mean(Tdost_deb(T_l1:T_l2,:))*
    Tmean=T_num/T_den;
    T_deb(T_l1:T_l2,1)=Tmean;
end
%}


%{
% 从左向右生成
for i=11:1:1990
    tmp=X(i);tmp1=X(i+1)
    
    I=Y(i)*1e-44;
    Ie1=interp1(Xe,Ye,tmp);Ie2=interp1(Xe,Ye,tmp1);
    deltaI=Ie2-Ie1;
    miu_b1=interp1(fermi_x,mb,tmp,'spline');miu_b2=interp1(fermi_x,mb,tmp1,'spline');
    miu_t1=interp1(fermi_x,mt,tmp,'spline');miu_t2=interp1(fermi_x,mt,tmp1,'spline');
    T_l1=interp1(m,(1:1:20000)',(miu_t1));T_l2=interp1(m,(1:1:20000)',(miu_t2));
    T_l1=floor(T_l1);T_l2=floor(T_l2);
    T_r1=interp1(m,(1:1:20000)',(miu_b1));T_r2=interp1(m,(1:1:20000)',(miu_b2)');
    T_r1=ceil(T_r1);T_r2=ceil(T_r2);
    El_delta=miu_t2-miu_t1;Er_delta=miu_b2-miu_b1;
    
    T_num=deltaI+sum(Tdos_deb(T_l1:T_l2,:).*T_deb(T_l1:T_l2,:))*El_delta;
    T_den=sum(Tdos_deb(T_r1:T_r2,:))*Er_delta;
    Tmean=T_num/T_den;
    T_deb(T_r1:T_r2,1)=Tmean;
end
%}
s=plot(m,T_deb);  m,Tdost_deb*1e10
title('Tunneling probability');
xlabel('Fermi Level (eV)');
ylabel('T(E)');
saveas(s,sprintf('C:\\Users\\cwhypt\\Documents\\MATLAB\\pic\\0.T(E)_Vb_%0.2f.jpg',6));
pause(3)

