function [P_up,P_down,M,kx,Psi]=T(a3_E_1,theta)
%% 定义基本量
% Assume the width is 3 nm
global flag1
flag1=flag;
global a5_alpha
a5_alpha=0.05;
global z_spacing

me=9.11e-31;e=1.6e-19;hbar=1.054e-34;
sigma_x=[0 1;1 0]; sigma_y=[0 -1i;1i 0]; sigma_z=[1 0;0 -1];
%global a0_Vc
a0_Vc=zeros(3000,1);

a0_Vc(1:276,1)=4;
a0_Vc(277:828,1)=-0.12;
a0_Vc(829:1104,1)=4;
a0_Vc(1105:1656,1)=-0.12;
a0_Vc(1657:1932,1)=4;
a0_Vc=a0_Vc+linspace(1,3000,3000)'./1932.*a5_alpha; %单位？
%plot(a0_Vc)

% 定义每一步长度  Defines the number of steps(in 1/2 step)
z_length=1932;
z_spacing=2;    %69
global a1_M
a1_M=floor(z_length/z_spacing);

global a2_loc
global a2_Vd
a2_loc=linspace(0,a1_M,a1_M+1)'.*z_spacing;
a2_Vd=interp1(linspace(1,3000,3000)',a0_Vc,a2_loc);
a2_Vd(1,1)=a2_Vd(6,1);
a2_Vd(2,1)=a2_Vd(6,1);


a2_Vd=a2_Vd*e;

flag1.update('Update potential');
%% 可调参数
% 定义scattering 能量
global a3_E
%a3_E_1=0.31158
a3_E=a3_E_1*e; %实际能量？
global a4_theta1
global a4_theta2
a4_theta1=theta;
a4_theta2=0;
%% 定义B matrix
% 定义 B
b0_Ul=0;
b0_Ur=a5_alpha.*0.3.*e;


b1_kl=sqrt(2*me*(a3_E-b0_Ul)/hbar^2);
b1_kr=sqrt(2*me*(a3_E-b0_Ur)/hbar^2);

kx=b1_kl;
%定义B matrix

b1_Bl_11=eye(2);
b1_Bl_12=eye(2);
b1_Bl_21=1i*b1_kl.*eye(2);
b1_Bl_22=-1i*b1_kl.*eye(2);

b1_Bl=[b1_Bl_11 b1_Bl_12;b1_Bl_21 b1_Bl_22];

b0_x_R=z_length*1e-12;
b1_Br_11=exp(-1i*b1_kr*b0_x_R)*eye(2);
b1_Br_12=exp(1i*b1_kr*b0_x_R)*eye(2);
b1_Br_21=-1i*exp(-1i*b1_kr*b0_x_R)*b1_kr.*eye(2);
b1_Br_22=1i*exp(1i*b1_kr*b0_x_R)*b1_kr.*eye(2);

b1_Br=[b1_Br_11 b1_Br_12;b1_Br_21 b1_Br_22];

flag1.update('Construct B');
clear -regexp ^b1_Bl_
clear -regexp ^b1_Br_
%% 定义D(x)
D0_21_first=me*0.5*e/(hbar)^2*(sin(a4_theta1).*sigma_x +cos(a4_theta1).*sigma_z);  %   0.5
D0_21_second=me*0.5*e/(hbar)^2*(sin(a4_theta2).*sigma_x +cos(a4_theta2).*sigma_z);

D0=[zeros(2) eye(2);zeros(2) zeros(2)];
D1_D=zeros(a1_M*4+4,4);
D1_D_up=zeros(a1_M+1,1);
D1_D_down=zeros(a1_M+1,1);
for j=1:1:a1_M+1
D0_it=D0;

if (j-1)*z_spacing>=277 && (j-1)*z_spacing<=828
    D0_it(3:4,1:2)=D0_21_first;
elseif (j-1)*z_spacing>=1105 && (j-1)*z_spacing<=1656
    D0_it(3:4,1:2)=D0_21_second;
end

D0_tmp=-2.*me./hbar^2.*(a3_E-a2_Vd(j,1)).*eye(2);
D0_it(3:4,1:2)=D0_it(3:4,1:2)+D0_tmp;
D1_D((4*j-3):4*j,1:4)=D0_it;
D1_D_up(j,1)=D0_it(3,1);
D1_D_down(j,1)=D0_it(4,2);
end

flag1.update('Form each D');

%flag1.plot2(1,(0:z_spacing:1932)',D1_D_up ,D1_D_down,'Xlabel','X (0-1992pm)','Ylabel','Energy','title','Potential at 0.5eV spin splitting','save','false' );

%-------------------------------------检查


D2_T=zeros(a1_M*2,4);
for j=0:1:a1_M/2-1
    deltax=z_spacing.*2.*1e-12;
    D2_D1=D1_D(4*(2*j)+1:4*(2*j)+4,:);
    D2_D2t=D1_D(4*(2*j)+5:4*(2*j)+8,:);
    D2_D4t=D1_D(4*(2*j)+9:4*(2*j)+12,:);
    D2_D2=D2_D2t*(eye(4)+deltax./2.*D2_D1);
    D2_D3=D2_D2t*(eye(4)+deltax./2.*D2_D2);
    D2_D4=D2_D4t*(eye(4)+deltax.*D2_D3);
    
D2_T((4*j+1):4*j+4,1:4)=eye(4)+deltax/6.*(D2_D1+2*D2_D2+2*D2_D3+D2_D4);
end
clear -regexp ^D2_D
 flag1.update('Transform T');
 
Tm=eye(4);


for j=1:1:a1_M/2
Tm=D2_T(4*j-3:4*j,:)*Tm;
end

Tau=Tm*b1_Bl;
M_1=[Tau(1:2,3:4) -b1_Br(1:2,3:4); -Tau(3:4,3:4) b1_Br(3:4,3:4)];
M_2=[-Tau(1:2,1:2) b1_Br(1:2,1:2); Tau(3:4,1:2) -b1_Br(3:4,1:2)];
M=M_1\M_2;


M_real=conj(M).*M; % important

P_up=M_real(4,1);
P_down=M_real(3,2);



A_in=[1/sqrt(2);1/sqrt(2);0;0];  %全部从左上进
A_out=M*A_in;
A_l=[1/sqrt(2);1/sqrt(2);A_out(1:2,1)];      % Compute wavefunctions
Psi=zeros(a1_M/2+1,4);
P1=(b1_Bl*A_l)';
Psi(1,:)=P1;
for j=1:1:a1_M/2
Psi(j+1,:)=(D2_T(4*j-3:4*j,:)*Psi(j,:)')';
end


 flag1.update('Data manipulation');

%str = sprintf('T-up: %0.1e,T-down: %0.1e',Prob(3,1),Prob(4,1));
%flag1.plot2(2,Psi_x',Psi_real(:,1) ,Psi_real(:,2),'Xlabel','X (0-1992pm)','Ylabel','Wavefunction','title',sprintf('Wavefunction at incident energy E=%d',a3_E_1),'save','true','annotation',str);


%clear me e hbar
clear -regexp ^sigma_

 flag1.update('End');
end
