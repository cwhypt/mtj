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