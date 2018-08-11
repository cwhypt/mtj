


%{
%% 在用DOS生成对应B的n(E)曲线之后, 生成拟合
global E_s0 
global NE_s0


global NE_sfit
global NE_sres


E_s0=E_lo(1:1000,1);NE_s0=NE(1:1000,1);
E_s1=E_lo(900:2100,1);NE_s1=NE(900:2100,1);
E_s2=E_lo(1900:3100,1);NE_s2=NE(1900:3100,1);
E_s3=E_lo(2900:4100,1);NE_s3=NE(2900:4100,1);
E_s4=E_lo(3900:5100,1);NE_s4=NE(3900:5100,1);
E_s5=E_lo(4900:6000,1);NE_s5=NE(4900:6000,1);

plot(E_s1,NE_s1)


%}
%{
X=(0.001:0.001:1)'; Y=(0.001:0.001:0.1)';

    Y1=custom_fit(X);
    Y2=custom_fit2(X);
    
NE_v1=NE-Y1;
NE_v2=NE_v1-Y2;

plot(X,Y2)
hold on
plot(X,NE_v2)
%}
%{
%% 生成band structure
X=1:1:200;X=(X/100*3-3)';
for i=1:1:200
tmp=demo(4,(i-100)/100*3);
Y(i,1)=tmp(1);
end
plot(X,Y)
%}
%{
%%%%%%%% 生成Fermi level curve 
global fermi_x
global mb
global mt
fermi_x=1:1:200;fermi_x=(fermi_x/100*2-2)';
mt=zeros(200,1);mb=zeros(200,1);
for i=1:1:200
    fprintf('Line %d \n',i);
        [mb(i),mt(i)]=Fermi(6,X(i),80e-3);
end

plot(X,mb)  %'Color','blue'
hold on
plot(X,mt)   %'Color','yellow'

title('Fermi Level at Vb=-2eV')  % ,  B=6T
xlabel('Vt (eV)')
ylabel('Fermi level with Ef=0 (eV)')
legend('Eb','Et')
pause
%}
%{
%%%%%%%%% 生成Fermi level surface
X=1:1:20;X=(X/10*2-2)';
Y=1:1:20;Y=(Y/10*2-2)';
mt=zeros(20,20);mb=zeros(20,20);
for i=1:1:20
    fprintf('dd %d \n',i);
    for j=1:1:20
        [mb(i,j),mt(i,j)]=Fermi((i/10*2-2),j/10*2-2,80e-3);
    end
end
mesh(X,Y,mt)
hold on
mesh(X,Y,mb)
%}
%
%%%%%%%%%% 生成 tunneling current 曲线

%importdata('C:\Users\cwhypt\Google 云端硬盘\2D_Materials\Experiment_Xu Xiaodong\11. B-field\Pic\DOS\dNdE.mat');
%importdata('C:\Users\cwhypt\Google 云端硬盘\2D_Materials\Experiment_Xu Xiaodong\11. B-field\Pic\DOS\NE.mat');
%  X=-2000:200:2000;X=(X/1000)';
global EN
global dNdE
global fermi_x
global mb
global mt
% Generate global Tdos_deb

global T_x
global Tdos_deb
global Tdost_deb
%{
% 生成Tdos 态密度
m=(1:1:20000)';m=(m-10000)/10000;
Tdost_deb=Tdos(m);
for i=1:1:20000
    if isnan(Tdost_deb(i,1)) 
        Tdost_deb(i,1)=0;
    end
end
%
%
plot(Tdost_deb)
title('Density of states multiplied');
saveas(gcf,sprintf('C:\\Users\\cwhypt\\Documents\\MATLAB\\pic\\0.DOS_Vb_%0.2f.jpg',6));
pause(3)
%}
global T_deb
global Tt_deb
%{
% 生成T(E) 曲线(试运行)
m=(1:1:20000)';m=(m-10000)/10000;
T_deb=T(m);

s=plot(m,T_deb)
title('Tunneling probability');
saveas(s,sprintf('C:\\Users\\cwhypt\\Documents\\MATLAB\\pic\\0.T(E)_Vb_%0.2f.jpg',6));
pause(3)

%}



%
% 生成current
global X
global Y

%
X=-19980:20:20000;X=(X/10000)';
Y=[];

Tt_deb=T(T_x);

for i=1:1:2000
    tmp=X(i,1);
    fprintf('Cycle %d  Energy %d \n; ',i,tmp);
    current=demo_no_T(6,tmp);
    %pause(1);
Y(i,1)=-current/1e43;
end

figure(2)
s=plot(X,Y)
title('Tunneling current vs. Vt')
xlabel('Vt (eV)')
ylabel('Tunneling current')
legend('I')
saveas(s,sprintf('C:\\Users\\cwhypt\\Documents\\MATLAB\\pic\\0.current_Vb_%0.2f.jpg',6));

%}


global Xe
global Ye
%Xe=Vtg_1;
%Ye=Int_1;


%{
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
%{
figure(3)
s=plot(T_x,T_deb); 
title('Tunneling probability');
xlabel('Fermi Level (eV)');
ylabel('T(E)');
saveas(s,sprintf('C:\\Users\\cwhypt\\Documents\\MATLAB\\pic\\0.T(E)_Vb_%0.2f.jpg',6));
pause(3)

%}

%{
n = input('Enter the number of samples:');
for sentence = n:1
   n = fprintf('%d. Hello world!', n);
    disp(n:1)
end

t_start=tic;
X=1:1:2*n;Y=(1:1:2*n)';X=((X-n)/(n/4))'; %n samples per side; from [-4,4]
for i=1:1:2*n
   fprintf('Cycle %d \n',i); disp('Start counting...');
   Y(i,1)=demo(6,X(i));  %Vb,Vt
end
t_total=toc(t_start)
plot(X,Y)
%}
%{
X=1:1:200;X=(X/100*20-20)';
Y=1:1:200;Y=(Y/100*20-20)';
mt=zeros(200,200);mj=zeros(200,200);
for i=1:1:200
    for j=1:1:200
        [mt(i,j),mj(i,j)]=Fermi((i/100*20-20),j/100*20-20);
    end
end

mesh(X,Y,mt)
hold on
mesh(X,Y,mj)
%}
