T_x=linspace(0,1,500)';
T_sc=zeros(51,2);
Q_sc=zeros(51,3);
T_sumE=[];T_sumP=[];
M=zeros(4);

global flag0
flag0=flag;
h=figure(1);
h.Position=[50 0 1000 600];
h1=figure(2);
h1.Position=[50 0 1000 600];
for j=0:pi/50:pi  %Energy
    count=1;            
    for  k=0.002:0.002:1 %Angle
        [T_sc(count,1),T_sc(count,2),M,kx,Psi]=T(k,j);      
        %[Q_sc(count,1),Q_sc(count,2),Q_sc(count,3),Q_sc(count,4),Q_sc(count,5),Q_sc(count,6)]=N(M,j,kx,Psi);
        count=count+1;
    end
    
     [T_sort,T_index]=sort(T_sc,1,'descend');T_index=sort(T_index(1:2,:),1,'ascend');
     T_sort=[T_sc(T_index(1,1),1),T_sc(T_index(2,1),1),T_sc(T_index(1,2),2),T_sc(T_index(2,2),2)]; %描述上1上2，下1下2幅度
     T_ener=[T_index(1,1),T_index(2,1),T_index(1,2),T_index(2,2)]*0.002;
     T_sumE=[T_sumE; T_ener];T_sumP=[T_sumP;T_sort];
    
flag0.plot2(h,T_x, T_sc(:,1), T_sc(:,2),'Xlabel','Energy (eV)','Ylabel','Tunneling prob','title',sprintf('Layer 2 angle =%0.2f pi',j/pi),'Y1legend',sprintf('up'),'Y2legend',sprintf('down'),'save','true','clear','true');
%flag0.plot2(h,T_x, T_sc(:,1), T_sc(:,2),'Xlabel','Energy (eV)','Ylabel','Tunneling prob','title',sprintf('Layer 2 angle =%0.2f pi',j/pi),'Y1legend',sprintf('up'),'Y2legend',sprintf('down'),'save','true','clear','true');

end
flag0=flag;
h1=figure(2);
h1.Position=[50 0 1000 600];
sz=size(T_sumE);
flag0.plot2(h1,linspace(0,1,sz(1)), T_sumE(:,1), T_sumE(:,2),'Xlabel',sprintf('Layer angle'),'Ylabel','State energy','title',sprintf('Layer 1 angle =%0.2f pi',j/pi),'Y1legend',sprintf('up-sym'),'Y2legend',sprintf('up-asy'),'save','true','clear','false');
hold on
flag0.plot2(h1,linspace(0,1,sz(1)), T_sumE(:,3), T_sumE(:,4),'Xlabel',sprintf('Layer angle'),'Ylabel','State energy','title',sprintf('Layer 1 angle =%0.2f pi',j/pi),'Y1legend',sprintf('down-sym'),'Y2legend',sprintf('down-asy'),'save','true','clear','false');
hold on

%% Plot wavefunctions of the special energies
flag0=flag;
h2=figure(3);
h2.Position=[50 0 1000 600];
E=0.328;j=0;
[T_sc(count,1),T_sc(count,2),M,kx,Psi]=T(E,j); 
%Psi=conj(Psi).*Psi;
sz_Psi=size(Psi);
flag0.plot2(h2,linspace(0,1932,sz_Psi(1)), Psi(:,1),Psi(:,2),'Xlabel','Location (nm)','Ylabel','Prob','title',sprintf('Eigenfunction at E=%0.2f',E),'Y1legend',sprintf('up'),'Y2legend',sprintf('down'),'save','true','clear','false');



