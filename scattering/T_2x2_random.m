function [P_up,P_down]=T_2x2_random(a3_E_1)
%% 定义基本量
% Assume the width is 3 nm
global flag0

global z_spacing

me=9.11e-31;e=1.6e-19;hbar=1.054e-34;
sigma_x=[0 1;1 0]; sigma_y=[0 -1i;1i 0]; sigma_z=[1 0;0 -1];
%global a0_Vc
a0_Vc=zeros(2000,1);

a0_Vc(1:500,1)=0;
a0_Vc(501:1500,1)=-0.3;
a0_Vc(1501:2000,1)=0;


%plot(a0_Vc)

% 定义每一步长度  Defines the number of steps(in 1/2 step)
z_length=2000;
z_spacing=2;    %69
global a1_M
a1_M=floor(z_length/z_spacing);

global a2_loc
global a2_Vd
a2_loc=linspace(0,a1_M,a1_M+1)'.*z_spacing;
a2_Vd=interp1(linspace(1,2000,2000)',a0_Vc,a2_loc);
a2_Vd(1,1)=a2_Vd(6,1);
a2_Vd(2,1)=a2_Vd(6,1);


a2_Vd=a2_Vd*e;

flag0.update('Update potential');
%% 可调参数
% 定义scattering 能量

global a3_E
%a3_E_1=0.31158
a3_E=a3_E_1*e; %实际能量？

%% 定义B matrix
% 定义 B
b0_Ul=0;
b0_Ur=0;


b1_kl=sqrt(2*me*(a3_E-b0_Ul)/hbar^2);
b1_kr=sqrt(2*me*(a3_E-b0_Ur)/hbar^2);

%定义B matrix

b1_Bl_11=1;
b1_Bl_12=1;
b1_Bl_21=1i*b1_kl;
b1_Bl_22=-1i*b1_kl;

b1_Bl=[b1_Bl_11 b1_Bl_12;b1_Bl_21 b1_Bl_22];

b0_x_R=z_length*1e-12;
b1_Br_11=exp(-1i*b1_kr*b0_x_R);
b1_Br_12=exp(1i*b1_kr*b0_x_R);
b1_Br_21=-1i*exp(-1i*b1_kr*b0_x_R)*b1_kr;
b1_Br_22=1i*exp(1i*b1_kr*b0_x_R)*b1_kr;

b1_Br=[b1_Br_11 b1_Br_12;b1_Br_21 b1_Br_22];

flag0.update('Construct B');
clear -regexp ^b1_Bl_
clear -regexp ^b1_Br_
%% 定义D(x)

D0=[0 1;0 0];
D1_D=zeros(a1_M*2+2,2);
D1_E=zeros(a1_M+1,1);
for j=1:1:a1_M+1
D0_it=D0;

D0_tmp=-2.*me./hbar^2.*(a3_E-a2_Vd(j,1));
D0_it(2,1)=D0_it(2,1)+D0_tmp;
D1_D((2*j-1):2*j,1:2)=D0_it;
D1_E(j,1)=D0_it(2,1);
end

flag0.update('Form each D');

flag0.plot2(1,(0:z_spacing:z_length)',D1_E ,D1_E,'Xlabel','X (0-1992pm)','Ylabel','Energy','title','Potential at 0.5eV spin splitting','save','false' );

%-------------------------------------检查


D2_T=zeros(a1_M,2);
for j=0:1:a1_M/2-1
    deltax=z_spacing.*2.*1e-12;
    D2_D1=D1_D(2*(2*j)+1:2*(2*j)+2,:);
    D2_D2t=D1_D(2*(2*j)+3:2*(2*j)+4,:);
    D2_D4t=D1_D(2*(2*j)+5:2*(2*j)+6,:);
    D2_D2=D2_D2t*(eye(2)+deltax./2.*D2_D1);
    D2_D3=D2_D2t*(eye(2)+deltax./2.*D2_D2);
    D2_D4=D2_D4t*(eye(2)+deltax.*D2_D3);
    
D2_T((2*j+1):2*j+2,1:2)=eye(2)+deltax/6.*(D2_D1+2*D2_D2+2*D2_D3+D2_D4);
end
clear -regexp ^D2_D
 flag0.update('Transform T');
 
Tm=eye(2);

A_in=[1;0];   %Calculate the probabilities

for j=1:1:a1_M/2
Tm=D2_T(2*j-1:2*j,:)*Tm;
end
Tau=Tm*b1_Bl;
M_1=[Tau(1,2) -b1_Br(1,2); -Tau(2,2) b1_Br(2,2)];
M_2=[-Tau(1,1) b1_Br(1,1); Tau(2,1) -b1_Br(2,1)];
M=M_1\M_2;
A_out=M*A_in;

A_l=[1;A_out(1,1)];      % Compute wavefunctions
Psi=zeros(a1_M/2+1,2);
Psi_0=(b1_Bl*A_l)';
Psi(1,:)=Psi_0;
for j=1:1:a1_M/2
Psi(j+1,:)=(D2_T(2*j-1:2*j,:)*Psi(j,:)')';
end

Prob=conj(A_out).*A_out
P_up=Prob(2);P_down=Prob(2);

Psi_x=0:z_spacing*2:z_length;
Psi_real=conj(Psi).*Psi;

 flag0.update('Data manipulation');

str = sprintf('T-up: %0.1e,T-down: %0.1e',Prob(1,1),Prob(2,1));
flag0.plot2(2,Psi_x',Psi_real(:,1) ,Psi_real(:,2),'Xlabel','X (0-1992pm)','Ylabel','Wavefunction','title',sprintf('Wavefunction at incident energy E=%d',a3_E_1),'save','true','annotation',str);


%clear me e hbar
clear -regexp ^sigma_

 flag0.update('End');
end
