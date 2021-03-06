T_x=linspace(0,1,51)';
T_sc=zeros(51,4);
T_tot=zeros(51,2);
R_sc=zeros(51,4);
Q_sc=zeros(51,3);
Cur=zeros(484,3);
Cur_x=linspace(0,1932,484);
M=zeros(4);
global flag0
flag0=flag;
global flag1
flag1=flag;
h1=figure(1);
h1.Position=[50 0 1000 600];
h2=figure(2);
h2.Position=[50 0 1000 600];

C_sc1=zeros(51,6);
C_sc2=zeros(51,6);
T_sumE1=[];T_sumE2=[];T_sumP1=[];T_sumP2=[];
k=0.29 % k=0.05:0.05:1
    count=1;
   j=0.316*pi %for  j=pi*0.005:pi/200:pi  j=pi*0.3001:pi/10000:pi*0.40000 
        [T_tot(count,1),T_tot(count,2),T_sc(count,1),T_sc(count,4),T_sc(count,2),T_sc(count,3),R_sc(count,1),R_sc(count,4),R_sc(count,2),R_sc(count,3),M,kx,Psi]=T(k,j);
        [Q_sc(count,1),Q_sc(count,2),Q_sc(count,3),Q_sc(count,4),Q_sc(count,5),Q_sc(count,6),C_sc1(count,1),C_sc1(count,2),C_sc1(count,3),C_sc1(count,4),C_sc1(count,5),C_sc1(count,6),Cur]=N1layer(M,j,kx,Psi);
        count=count+1;
    %end

flag0.plot3(h1,Cur_x, Cur(:,1), Cur(:,2),Cur(:,3), 'Xlabel','Location (nm)','Ylabel','Spin currents','title',sprintf('Layer angle %0.3f pi',j/pi),'Y1legend',sprintf('x'),'Y2legend',sprintf('y'),'Y3legend',sprintf('z'),'save','true','clear','true');
flag0.plot2(h2,linspace(0,1932,length(Psi))',Psi(:,1), Psi(:,2),  'Xlabel','Location (nm)','Ylabel','Wavefunction', ...
       'title',sprintf('Wavefunction at E=%0.2f eV, T=%0.3f pi',k,j/pi),'Y1legend',sprintf('up'),'Y2legend',sprintf('down'),'save','true','clear','true');

%{
h3=figure(3);
h3.Position=[50 0 1000 600];
h4=figure(4);
h4.Position=[50 0 1000 600];

%}


%%  图像区
%{
% 画eigenenergy
%1. 换回来j和k  k取最大0.002
%2. j循环内加
     [T_sort,T_index]=sort(T_tot,1,'descend');T_index=sort(T_index(1:2,:),1,'ascend');
     T_sort=[T_tot(T_index(1,1),1),T_tot(T_index(2,1),1),T_tot(T_index(1,2),2),T_tot(T_index(2,2),2)]; %描述上1上2，下1下2幅度
     T_ener=[T_index(1,1),T_index(2,1),T_index(1,2),T_index(2,2)]*0.002;
     T_sumE=[T_sumE; T_ener];T_sumP=[T_sumP;T_sort];  
     sz=size(T_tot);flag0.plot2(h1,linspace(0,1,sz(1)), T_tot(:,1), T_tot(:,2),'Xlabel','Energy (eV)','Ylabel','Tunneling prob','title',sprintf('Layer 2 angle =%0.2f pi',j/pi),'Y1legend',sprintf('up'),'Y2legend',sprintf('down'),'save','true','clear','true');
end
%3. 外部加
sz=size(T_sumE);
flag0.plot2(h1,linspace(0,1,sz(1)), T_sumE(:,1), T_sumE(:,2),'Xlabel',sprintf('Layer angle'),'Ylabel','State energy','title',sprintf('Layer 1 angle =%0.2f pi',j/pi),'Y1legend',sprintf('up-sym'),'Y2legend',sprintf('up-asy'),'save','true','clear','false');
hold on
flag0.plot2(h1,linspace(0,1,sz(1)), T_sumE(:,3), T_sumE(:,4),'Xlabel',sprintf('Layer angle'),'Ylabel','State energy','title',sprintf('Layer 1 angle =%0.2f pi',j/pi),'Y1legend',sprintf('down-sym'),'Y2legend',sprintf('down-asy'),'save','true','clear','false');
hold on
%}

%{
%  画出能量线上Cur vs. angle
% Tunneling prob
flag0.plot2(h3,linspace(0,1,length(T_tot)), T_tot(:,1), T_tot(:,2),'Xlabel','theta_1 (\pi)','Ylabel','Tunneling prob','Y1legend',sprintf('up'),'Y2legend',sprintf('down'),'save','true','clear','true');
% Current vs angle
flag0.plot3(h1,linspace(0,1,length(Q_sc))', Q_sc(:,1), Q_sc(:,2),Q_sc(:,3), 'Xlabel','theta_1 (\pi)','Ylabel','N_{st} for layer 1','title',sprintf('Incident E=%0.2feV',k),'Y1legend',sprintf('x'),'Y2legend',sprintf('y'),'Y3legend',sprintf('z'),'save','true','clear','false');
hold off
flag0.plot3(h2,linspace(0,1,length(Q_sc))',Q_sc(:,4), Q_sc(:,5),Q_sc(:,6), 'Xlabel','theta_1 (\pi)','Ylabel','N_{st} for layer 2','title',sprintf('Incident E=%0.2feV',k),'Y1legend',sprintf('x'),'Y2legend',sprintf('y'),'Y3legend',sprintf('z'),'save','true','clear','false');
hold off

% 画总spin current
flag0.plot3(h2,linspace(0,1,length(Q_sc))',Q_sc(:,1)+Q_sc(:,4), Q_sc(:,2)+Q_sc(:,5),Q_sc(:,3)+Q_sc(:,6), 'Xlabel','theta_1 (\pi)','Ylabel','N_{st} for two layers', ...
          'title',sprintf('Incident E=%0.2feV',k),'Y1legend',sprintf('x'),'Y2legend',sprintf('y'),'Y3legend',sprintf('z'),'save','true','clear','false');

hold off

%}

%{
% 画出两边分别能量
flag0.plotsub3(h1,1,2,linspace(0,1,length(Q_sc))', Q_sc(:,1), Q_sc(:,2),Q_sc(:,3), 'Xlabel','theta_1 (\pi)','Ylabel','N_{st} for layer 1','title',sprintf('Incident E=%0.2feV',k),'Y1legend',sprintf('x'),'Y2legend',sprintf('y'),'Y3legend',sprintf('z'),'save','false','clear','false');
flag0.plotsub3(h1,1,2, linspace(0,1,length(Q_sc))', Q_sc(:,4), Q_sc(:,5),Q_sc(:,6), 'Xlabel','theta_1 (\pi)','Ylabel','N_{st} for layer 2','title',sprintf('Incident E=%0.2feV',k),'Y1legend',sprintf('x'),'Y2legend',sprintf('y'),'Y3legend',sprintf('z'),'save','false','clear','false');
hold off
%}
    
%% 分析函数曲线
 %Peak: k=0.29, j=0.3287*pi
%flag0.plot3(h1,Cur_x, Cur(:,1), Cur(:,2),Cur(:,3), 'Xlabel','Location (nm)','Ylabel','Spin currents','title',sprintf('Layer angle %0.2f pi',j/pi),'Y1legend',sprintf('x'),'Y2legend',sprintf('y'),'Y3legend',sprintf('z'),'save','true','clear','true');
%flag0.plot2(h1,linspace(0,1932,length(Psi))',Psi(:,1), Psi(:,2),  'Xlabel','Location (nm)','Ylabel','Wavefunction', ...
%       'title',sprintf('Wavefunction at E=%0.2f eV, T=%0.3f pi',k,j/pi),'Y1legend',sprintf('up'),'Y2legend',sprintf('down'),'save','true','clear','true');
