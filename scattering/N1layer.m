function [n11,n12,n13,cl11,cl12,cl13,cr11,cr12,cr13]=N1layer(M,theta1,kx,Psi)
Psil1=Psi(69,:);   Psir2=Psi(207,:);


Qleft1=imag([conj(Psil1(1))*Psil1(4)+conj(Psil1(2))*Psil1(3); ...
            -1i*conj(Psil1(1))*Psil1(4)+1i*conj(Psil1(2))*Psil1(3); ...  %hbar^2/2m
              conj(Psil1(1))*Psil1(3)+conj(Psil1(2))*Psil1(4)]);
Qright1=imag([conj(Psir2(1))*Psir2(4)+conj(Psir2(2))*Psir2(3); ...
            -1i*conj(Psir2(1))*Psir2(4)+1i*conj(Psir2(2))*Psir2(3); ...  %hbar^2/2m
              conj(Psir2(1))*Psir2(3)+conj(Psir2(2))*Psir2(4)]);

n11=Qleft1(1)-Qright1(1);n12=Qleft1(2)-Qright1(2);n13=Qleft1(3)-Qright1(3);


%% For debug use
sigma=[[0 1;1 0],[0,-1i;1i,0],[1 0;0,-1]];
cl11=Qleft1(1);
cr11=Qright1(1); 
cl12=Qleft1(2);
cr12=Qright1(2);   
cl13=Qleft1(3);
cr13=Qright1(3); 

end
%{
tuu=M(3,1);tdu=M(3,2);tud=M(4,1);tdd=M(4,2);
ruu=M(1,1);rdu=M(1,2);rud=M(2,1);rdd=M(2,2);
cs=cos(theta1/2); ss=sin(theta1/2);
Qin=kx.*[sin(theta1),0,cos(theta1)];
Qtrans=kx.*[2*real((tuu*cs+tdu*ss)*(tud'*cs+tdd*ss)),2*imag((tuu*cs+tdu*ss)*(tud'*cs+tdd*ss)),modulus(tuu*cs+tdu*ss)-modulus(tud'*cs+tdd*ss)];
Qrefl=-kx.*[2*real((ruu*cs+rdu*ss)*(rud'*cs+rdd*ss)),2*imag((ruu*cs+rdu*ss)*(rud'*cs+rdd*ss)),modulus(ruu*cs+rdu*ss)-modulus(rud'*cs+rdd*ss)];

n1=Qin(1)+Qrefl(1)-Qtrans(1);
n2=Qin(2)+Qrefl(2)-Qtrans(2);
n3=Qin(3)+Qrefl(3)-Qtrans(3);

%}



function mod=modulus(inc)
mod=inc.*conj(inc);
end