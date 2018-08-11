function Tt_deb=T(T_x)

%global T_x
%global Tt_deb

%T_deb=interp1(EN,dNdE,E);  %Dos of graphene

f1 = Lorentzian(T_x,0.0265,0.007,8000);  %Experimental fit:  T_x,0.0265,0.01,5176

f2 = Lorentzian(T_x,-0.0342,0.0163,614);  %     T_x,-0.0342,0.0163,614

Tt_deb=f1+f2;

plot(T_x,f1,T_x,f2,T_x,Tt_deb);




end
