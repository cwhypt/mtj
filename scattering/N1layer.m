function [n11,n12,n13,cl11,cl12,cl13,cr11,cr12,cr13,Cur]=N1layer(M,theta1,kx,Psi)
Psil1=Psi(1,:);   Psir1=Psi(276,:);

Cur=imag([conj(Psi(:,1)).*Psi(:,4)+conj(Psi(:,2)).*Psi(:,3),...
            -1i.*conj(Psi(:,1)).*Psi(:,4)+1i.*conj(Psi(:,2)).*Psi(:,3), ...  %hbar^2/2m
              conj(Psi(:,1)).*Psi(:,3)-conj(Psi(:,2)).*Psi(:,4)]);
theta1=0;
tuu=M(3,1);tdu=M(3,2);tud=M(4,1);tdd=M(4,2);
ruu=M(1,1);rdu=M(1,2);rud=M(2,1);rdd=M(2,2);
cs=cos(theta1/2); ss=sin(theta1/2);
Qin=-kx.*[sin(theta1),0,cos(theta1)];
Qtrans=-kx.*[2*real((tuu*cs+tdu*ss)*(tud'*cs+tdd'*ss)),2*imag((tuu*cs+tdu*ss)*(tud'*cs+tdd'*ss)),modulus(tuu*cs+tdu*ss)-modulus(tud*cs+tdd*ss)];
Qrefl=kx.*[2*real((ruu*cs+rdu*ss)*(rud'*cs+rdd'*ss)),2*imag((ruu*cs+rdu*ss)*(rud'*cs+rdd'*ss)),modulus(ruu*cs+rdu*ss)-modulus(rud*cs+rdd*ss)];

n11=Qin(1)+Qrefl(1)-Qtrans(1);
n12=Qin(2)+Qrefl(2)-Qtrans(2);
n13=Qin(3)+Qrefl(3)-Qtrans(3);

cl11=Qin(1)+Qrefl(1);
cr11=Qtrans(1);
cl12=Qin(2)+Qrefl(2);
cr12=Qtrans(2);
cl13=Qin(3)+Qrefl(3);
cr13=Qtrans(3);





%% For debug use


end
%{
Qleft1=imag([conj(Psil1(1))*Psil1(4)+conj(Psil1(2))*Psil1(3); ...
            -1i*conj(Psil1(1))*Psil1(4)+1i*conj(Psil1(2))*Psil1(3); ...  %hbar^2/2m
              conj(Psil1(1))*Psil1(3)-conj(Psil1(2))*Psil1(4)]);
Qright1=imag([conj(Psir1(1))*Psir1(4)+conj(Psir1(2))*Psir1(3); ...
            -1i*conj(Psir1(1))*Psir1(4)+1i*conj(Psir1(2))*Psir1(3); ...  %hbar^2/2m
              conj(Psir1(1))*Psir1(3)-conj(Psir1(2))*Psir1(4)]);

n11=Qleft1(1)-Qright1(1);n12=Qleft1(2)-Qright1(2);n13=Qleft1(3)-Qright1(3);


sigma=[[0 1;1 0],[0,-1i;1i,0],[1 0;0,-1]];
cl11=Qleft1(1);
cr11=Qright1(1); 
cl12=Qleft1(2);
cr12=Qright1(2);   
cl13=Qleft1(3);
cr13=Qright1(3); 

%}



function mod=modulus(inc)
mod=inc.*conj(inc);
end