T_x=linspace(0,1,51)';
T_sc=zeros(51,4);
R_sc=zeros(51,4);
Q_sc=zeros(51,3);
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
    for j=0:pi/50:pi  %Angle
        [T_sc(count,1),T_sc(count,4),T_sc(count,2),T_sc(count,3),R_sc(count,1),R_sc(count,4),R_sc(count,2),R_sc(count,3),M,kx,Psi]=T1layer(k,j);
         [Q_sc(count,1),Q_sc(count,2),Q_sc(count,3),C_sc1(count,1),C_sc1(count,2),C_sc1(count,3),C_sc1(count,4),C_sc1(count,5),C_sc1(count,6)]=N1layer(M,j,kx,Psi);
        count=count+1;
        
    end
    
flag0.plotsub(h,2,2,T_x, T_sc(:,1),T_sc(:,4), 'Xlabel','theta_1 (\pi)','Ylabel','tuu and tdd','title',sprintf('Incident E=%0.2feV',k),'Y1legend',sprintf('tuu'),'Y2legend',sprintf('tdd'),'save','false','clear','false');
flag0.plotsub(h,2,2,T_x, T_sc(:,2),T_sc(:,3), 'Xlabel','theta_1 (\pi)','Ylabel','tdu and tud','title',sprintf('Incident E=%0.2feV',k),'Y1legend',sprintf('tdu'),'Y2legend',sprintf('tud'),'save','false','clear','false');

    
flag0.plotsub(h,2,2,T_x, R_sc(:,1),R_sc(:,4), 'Xlabel','theta_1 (\pi)','Ylabel','ruu and rdd','title',sprintf('Incident E=%0.2feV',k),'Y1legend',sprintf('ruu'),'Y2legend',sprintf('rdd'),'save','false','clear','false');
flag0.plotsub(h,2,2,T_x, R_sc(:,2),R_sc(:,3), 'Xlabel','theta_1 (\pi)','Ylabel','rdu and rud','title',sprintf('Incident E=%0.2feV',k),'Y1legend',sprintf('rdu'),'Y2legend',sprintf('rud'),'save','false','clear','false');
