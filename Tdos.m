function rat=Tdos(E)
tot=0;
Vi=8e-2;
global EN
global dNdE
%rat=integral2(@(x,y) Aspec1(x,y,E).*Aspec2(x,y,E),(-1/1.5)*10^10,(1/1.5)*10^10,(-1/1.5)*10^10,(1/1.5)*10^10);

        res1=interp1(EN,dNdE,E-Vi); res2=interp1(EN,dNdE,E);
        rat=res1.*res2;

end