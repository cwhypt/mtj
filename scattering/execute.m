T_x=linspace(0,1,51)';
T_sc=zeros(51,2);
Q_sc=zeros(51,3);
count=1;
M=zeros(4);
global flag0
flag0=flag;
h=figure;
h.Position=[50 50 1200 700];
for k=0.01:0.01:1  %Energy
    count=1;
    for j=0:pi/50:pi  %Angle
        [T_sc(count,1),T_sc(count,2),M,kx]=T(k,j);
        [Q_sc(count,1),Q_sc(count,2),Q_sc(count,3)]=N(M,j,kx);
        count=count+1;
        
    end
    
flag0.plot3(3, T_x, Q_sc(:,1), Q_sc(:,2),Q_sc(:,3), 'Xlabel','theta_1 (\pi)','Ylabel','N_{st}','title',sprintf('Incident E=%0.2feV',k),'Y1legend',sprintf('x'),'Y2legend',sprintf('y'),'Y3legend',sprintf('z'),'save','true','clear','false');
   hold off
end
