%import

global flag0
flag0=flag;

h1=figure(1);
h1.Position=[50 0 1000 600];

T_sc=linspace(0,1,100)';
sz=size(T_sumE1);
for i=1:1:8
     flag0.plotscatter(h1,linspace(0,1,sz(1))', T_sumE1(:,2*i-1),T_sumP1(:,2*i-1).*4,'Xlabel',sprintf('Layer angle (pi)'),'Ylabel','State energy','save','true','clear','false');
    hold on
   flag0.plotscatter(h1,linspace(0,1,sz(1))', T_sumE1(:,2*i),T_sumP1(:,2*i).*4,'Xlabel',sprintf('Layer angle'),'Ylabel','State energy','save','true','clear','false');
    hold on
end

%{
hold on
  flag0.plot2(h1,linspace(0,1,sz(1)), T_sumE1(:,2*i-1), T_sumE1(:,2*i),'Xlabel',sprintf('Layer angle'),'Ylabel','State energy','title',sprintf('Layer 1 angle =%0.2f pi',j/pi),'Y1legend',sprintf('up-sym'),'Y2legend',sprintf('up-asy'),'save','true','clear','false');

flag0.plot2(h1,linspace(0,1,sz(1)), T_sumE2(:,1), T_sumE2(:,2),'Xlabel',sprintf('Layer angle'),'Ylabel','State energy','title',sprintf('Layer 1 angle =%0.2f pi',j/pi),'Y1legend',sprintf('down-sym'),'Y2legend',sprintf('down-asy'),'save','true','clear','false');
hold on
%}
