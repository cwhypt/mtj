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
 k=0.806  %Energy: 0.29,0.324,0.766
    count=1;
    for j=pi/500:pi/500:pi  %Angle
        [T_sc(count,1),T_sc(count,4),T_sc(count,2),T_sc(count,3),R_sc(count,1),R_sc(count,4),R_sc(count,2),R_sc(count,3),M,kx,Psi]=T(k,j);
         [Q_sc(count,1),Q_sc(count,2),Q_sc(count,3),Q_sc(count,4),Q_sc(count,5),Q_sc(count,6),C_sc1(count,1),C_sc1(count,2),C_sc1(count,3),C_sc1(count,4),C_sc1(count,5),C_sc1(count,6)]=N1layer(M,j,kx,Psi);
        count=count+1;
    end
    
flag0.plot3(h1,linspace(0,1,length(Q_sc))', Q_sc(:,1), Q_sc(:,2),Q_sc(:,3), 'Xlabel','theta_1 (\pi)','Ylabel','N_{st} for layer 1','title',sprintf('Incident E=%0.2feV',k),'Y1legend',sprintf('x'),'Y2legend',sprintf('y'),'Y3legend',sprintf('z'),'save','true','clear','false');
hold off
flag0.plot3(h2,linspace(0,1,length(Q_sc))',Q_sc(:,4), Q_sc(:,5),Q_sc(:,6), 'Xlabel','theta_1 (\pi)','Ylabel','N_{st} for layer 2','title',sprintf('Incident E=%0.2feV',k),'Y1legend',sprintf('x'),'Y2legend',sprintf('y'),'Y3legend',sprintf('z'),'save','true','clear','false');
hold off
