T_x=linspace(0,1,51)';
T_sc=zeros(51,4);
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
 k=0.29  %Energy: 0.29,0.324,0.766,806
    count=1;
    for j=pi/50:pi/50:pi  %Angle

        [T_sc(count,1),T_sc(count,4),T_sc(count,2),T_sc(count,3),R_sc(count,1),R_sc(count,4),R_sc(count,2),R_sc(count,3),M,kx,Psi]=T(k,j);
         [Q_sc(count,1),Q_sc(count,2),Q_sc(count,3),Q_sc(count,4),Q_sc(count,5),Q_sc(count,6),C_sc1(count,1),C_sc1(count,2),C_sc1(count,3),C_sc1(count,4),C_sc1(count,5),C_sc1(count,6),Cur]=N1layer(M,j,kx,Psi);
        count=count+1;
    end
  
%%  图像区
%{
% 画eigenenergy
%1. 换回来j和k
%2. j循环内加
     [T_sort,T_index]=sort(T_sc,1,'descend');T_index=sort(T_index(1:2,:),1,'ascend');
     T_sort=[T_sc(T_index(1,1),1),T_sc(T_index(2,1),1),T_sc(T_index(1,2),2),T_sc(T_index(2,2),2)]; %描述上1上2，下1下2幅度
     T_ener=[T_index(1,1),T_index(2,1),T_index(1,2),T_index(2,2)]*0.002;
     T_sumE=[T_sumE; T_ener];T_sumP=[T_sumP;T_sort];   
%flag0.plot2(h,T_x, T_sc(:,1), T_sc(:,2),'Xlabel','Energy (eV)','Ylabel','Tunneling prob','title',sprintf('Layer 2 angle =%0.2f pi',j/pi),'Y1legend',sprintf('up'),'Y2legend',sprintf('down'),'save','true','clear','true');
%flag0.plot2(h,T_x, T_sc(:,1), T_sc(:,2),'Xlabel','Energy (eV)','Ylabel','Tunneling prob','title',sprintf('Layer 2 angle =%0.2f pi',j/pi),'Y1legend',sprintf('up'),'Y2legend',sprintf('down'),'save','true','clear','true');
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
flag0.plot3(h1,linspace(0,1,length(Q_sc))', Q_sc(:,1), Q_sc(:,2),Q_sc(:,3), 'Xlabel','theta_1 (\pi)','Ylabel','N_{st} for layer 1','title',sprintf('Incident E=%0.2feV',k),'Y1legend',sprintf('x'),'Y2legend',sprintf('y'),'Y3legend',sprintf('z'),'save','true','clear','false');
hold off
flag0.plot3(h2,linspace(0,1,length(Q_sc))',Q_sc(:,4), Q_sc(:,5),Q_sc(:,6), 'Xlabel','theta_1 (\pi)','Ylabel','N_{st} for layer 2','title',sprintf('Incident E=%0.2feV',k),'Y1legend',sprintf('x'),'Y2legend',sprintf('y'),'Y3legend',sprintf('z'),'save','true','clear','false');
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
