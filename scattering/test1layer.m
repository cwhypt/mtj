T_x=linspace(0,1,51)';
T_sc=zeros(51,4);
R_sc=zeros(51,4);
Q_sc=zeros(51,3);
Cur=zeros(484,3);
Cur_x=linspace(0,1932,484);
count=1;
M=zeros(4);
global flag0
flag0=flag;
global flag1
flag1=flag;
h=figure(1);
h.Position=[50 0 1000 600];
C_sc1=zeros(51,6);
C_sc2=zeros(51,6);
 k=0.1  %Energy
    count=1;
    for j=0:pi/9:pi  %Angle
        [T_sc(count,1),T_sc(count,4),T_sc(count,2),T_sc(count,3),R_sc(count,1),R_sc(count,4),R_sc(count,2),R_sc(count,3),M,kx,Psi]=T1layer(k,j);
         [Q_sc(count,1),Q_sc(count,2),Q_sc(count,3),C_sc1(count,1),C_sc1(count,2),C_sc1(count,3),C_sc1(count,4),C_sc1(count,5),C_sc1(count,6),Cur]=N1layer(M,j,kx,Psi);
        count=count+1;
flag0.plotsub3(h,2,5,Cur_x, Cur(:,1), Cur(:,2),Cur(:,3), 'Xlabel','Location (nm)','Ylabel','Spin currents','title',sprintf('Layer angle %0.2f pi',j/pi),'Y1legend',sprintf('x'),'Y2legend',sprintf('y'),'Y3legend',sprintf('z'),'save','true','clear','true');

    end

