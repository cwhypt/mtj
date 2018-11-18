T_x=linspace(0,1,51)';
T_sc=zeros(51,2);
Q_sc=zeros(51,3);
count=1;
M=zeros(4);
global flag0
flag0=flag;
h=figure(1);
h.Position=[50 0 1000 600];
h1=figure(2);
h1.Position=[50 0 1000 600];
for k=0.01:0.01:1  %Energy
    count=1;
    for j=0:pi/50:pi  %Angle
        [T_sc(count,1),T_sc(count,2),M,kx,Psi]=T(k,j);
        [Q_sc(count,1),Q_sc(count,2),Q_sc(count,3),Q_sc(count,4),Q_sc(count,5),Q_sc(count,6)]=N(M,j,kx,Psi);
        count=count+1;
        
    end
    
flag0.plotsub3(h,5,3,T_x, Q_sc(:,1), Q_sc(:,2),Q_sc(:,3), 'Xlabel','theta_1 (\pi)','Ylabel','N_{st} for layer 1','title',sprintf('Incident E=%0.2feV',k),'Y1legend',sprintf('x'),'Y2legend',sprintf('y'),'Y3legend',sprintf('z'),'save','true','clear','false');
hold off
flag0.plotsub3(h1,5,3, T_x, Q_sc(:,4), Q_sc(:,5),Q_sc(:,6), 'Xlabel','theta_1 (\pi)','Ylabel','N_{st} for layer 2','title',sprintf('Incident E=%0.2feV',k),'Y1legend',sprintf('x'),'Y2legend',sprintf('y'),'Y3legend',sprintf('z'),'save','true','clear','false');
hold off
end
