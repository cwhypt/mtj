function output=demo_no_T(V_b,V_t)
%% Calculate Band Structure
%tic
Vi=80*10^(-3);%Vi=80*10^(-3);
Vb=V_b;Vt=V_t; %E must be in eV  %input the two voltages
%[miu_b,miu_t]=Fermi(Vb,Vt,Vi);   %Calculate the Fermi level.
global fermi_x
global mb  
global mt
miu_b=interp1(fermi_x,mb,Vt);
miu_t=interp1(fermi_x,mt,Vt);
%toc
global T_x
global Tdos_deb
global T_deb
global Tt_deb
global Tdost_deb
tic
stack=zeros(20000,1);occup_deb=zeros(20000,1);
%tic
%{
for i=1:1:20000
    m=(i-10000)*1/10000;     %Optimal solution: i=10000, m=(i-5000)*4/5000
    %{
    Tdos_deb(i,1)=T(m,Vi);
    if isnan(Tdos_deb(i,1)) 
        Tdos_deb(i,1)=0;
    end
    %}
    occup_deb(i,1)=occup(m,miu_t,miu_b,Vi); %sampled momentum(band structure) using integral.
end
%}

occup_deb=occup(T_x,miu_t,miu_b,Vi); %sampled momentum(band structure) using integral.
%if isnan(miu_b) || isnan(miu_t)
%    occup_deb=zeros

%Tdos_deb=Tdos_deb/1e56;
stack=Tdost_deb.*occup_deb;
stack(isnan(stack))=0;
output=sum(stack);output=output*1/10000;
E_series=(((1:1:20000)-10000)*1/10000)';
toc


%tic
%
flag_Vb='n';flag_Vt='n';
if V_b>=0
    flag_Vb='p';
end
if V_t>=0
    flag_Vt='p';
end
%s=plot(E_series,Tdos_deb,'x');
%title('Tunneling');
%saveas(s,sprintf('C:\\Users\\cwhypt\\Documents\\MATLAB\\pic\\tunneling_Vb_%s%0.2f_Vt_%s%0.2f.jpg',flag_Vb,abs(V_b),flag_Vt,abs(V_t)));
%s=plot(E_series,occup_deb,'x');
%title('Occup');
%saveas(s,sprintf('C:\\Users\\cwhypt\\Documents\\MATLAB\\pic\\occup_Vb_%s%0.2f_Vt_%s%0.2f.jpg',flag_Vb,abs(V_b),flag_Vt,abs(V_t)));
if mod((Vt*100),40)==0
    figure(1)
    s=plot(E_series,stack,'x');
    title('current density');
    saveas(s,sprintf('C:\\Users\\cwhypt\\Documents\\MATLAB\\pic\\Eseries_Vb_%s%0.2f_Vt_%s%0.2f.jpg',flag_Vb,abs(V_b),flag_Vt,abs(V_t)));
    
end
%}
%toc
end

%% Fermi level(in fact chemical potential)
function[miu_b,miu_t]=Fermi(V_b,V_t,Vi)
global EN
global dNdE
e=1.6e-19; r0=3.033*(e);a=1.42e-10;dt=6e-9;db=20e-9;di=3e-9;vf=1.07e6; hbar=1.054e-34;	
ebn=8*8.854e-12;ecr=9*8.854e-12;    Vb=V_b; Vt=V_t;

inte=di*ebn/(2*ecr);
p0=Vi+inte*Vb/db-inte*Vt/dt; p1=e*di/(2*ecr);p7=inte/db+1;p8=-inte/dt-1; %p1=e^3*di/(3*pi*ecr*a^2*r0^2);
p2=ebn*((Vb/db+Vt/dt));p3=e;p5=ebn/(db);p6=ebn/(dt);   %p3=2*e^3/(3*pi*a^2*r0^2);


syms ub ut
eqns = [p0==p1*(custom_fit(ub)-custom_fit(ut))+p7*ub+p8*ut,p2==p5*ub+p6*ut+p3*(custom_fit(ub)+custom_fit(ut))];
vars = [ub ut];
[m_b, m_t] = vpasolve(eqns, vars);
miu_b=double(m_b);
miu_t=double(m_t);
if isempty(miu_b) || isempty(miu_t)
    fprintf('The equation cannot be solved£¡at Vb= %d,  Vt=%d.', V_b, V_t);
end
%{
nb=custom_fit(miu_b)/1e16;
nt=custom_fit(miu_t)/1e16;
%}
if abs(miu_b)>0.55
    fprintf('Warning: Vb:%d  ',Vb); fprintf('Vt:%d  ',Vt);disp('miu_b >3');
elseif abs(miu_t)>0.55
    fprintf('Warning: Vb:%d  ',Vb); fprintf('Vt:%d  ',Vt);disp('miu_t >3');
end
%
end

%% Calculate T(E) tunneling probability
%{
function T_deb=T(E)
global EN
global dNdE
T_deb=interp1(EN,dNdE,E);
T_deb=T_deb+Lorentzian(E,1,0.3,1);
end
%}
%% FD distribution calculation
function occu=occup(E,miut,miub,Vi)
kB = 8.617e-5;  % in eV/K
E_top = miut-Vi;  E_bot = miub;     % Fermi level in eV
T=2;
f_top = 1 ./ (1 + exp( (E-E_top)./(kB.*T)));
f_bot = 1 ./ (1 + exp( (E-E_bot)./(kB.*T)));

occu=f_top-f_bot;
end

%{
%% Tunneling Rate
function rat=T(E,Vi)
tot=0;
global EN
global dNdE
%rat=integral2(@(x,y) Aspec1(x,y,E).*Aspec2(x,y,E),(-1/1.5)*10^10,(1/1.5)*10^10,(-1/1.5)*10^10,(1/1.5)*10^10);

        res1=interp1(EN,dNdE,E-Vi); res2=interp1(EN,dNdE,E);
        rat=res1.*res2;

end

%}
%% Spectral density function   (for tunneling rate)  top gate
function dens_t=Aspec1(k1,k2,E,Vi)
k=sqrt(k1.^2+k2.^2); 
gamma=0.005;r0=3.033;a=1.42e-10;
Ep=sqrt(3)*a*r0*k/2;Eb=-Ep;
Ep=Ep-Vi;Eb=Eb-Vi;  %Experimental step
if E>Vi  %remember to modify the criteria here
dens_t=(1./pi).*(gamma./((E-Ep).^2+gamma.^2)); %if we take bottom as grounded, then with V>0, E should be lower.
else
dens_t=(1./pi).*(gamma./((E-Eb).^2+gamma.^2));
end
end

% Bottom gate
function dens_b=Aspec2(k1,k2,E,Vi)
k=sqrt(k1.^2+k2.^2); 
gamma=0.005;r0=3.033;a=1.42e-10;
Ep=sqrt(3)*a*r0*k/2;Eb=-Ep;
if E>0
dens_b=(1./pi).*(gamma./((E-Ep).^2+gamma.^2));
else
dens_b=(1./pi).*(gamma./((E-Eb).^2+gamma.^2));
end
end


%{
%Generate band structure curve
X=1:1:200;X=(X/100*3-3)';
for i=1:1:200
tmp=demo(4,(i-100)/100*3);
Y(i,1)=tmp(1);
end
plot(X,Y)

%}

