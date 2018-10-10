function [n1,n2,n3]=N(M,theta1,kx)

tuu=M(3,1);tdu=M(3,2);tud=M(4,1);tdd=M(4,2);
ruu=M(1,1);rdu=M(1,2);rud=M(2,1);rdd=M(2,2);
cs=cos(theta1/2); ss=sin(theta1/2);
Qin=kx.*[sin(theta1),0,cos(theta1)];
Qtrans=kx.*[2*real((tuu*cs+tdu*ss)*(tud'*cs+tdd*ss)),2*imag((tuu*cs+tdu*ss)*(tud'*cs+tdd*ss)),modulus(tuu*cs+tdu*ss)-modulus(tud'*cs+tdd*ss)];
Qrefl=-kx.*[2*real((ruu*cs+rdu*ss)*(rud'*cs+rdd*ss)),2*imag((ruu*cs+rdu*ss)*(rud'*cs+rdd*ss)),modulus(ruu*cs+rdu*ss)-modulus(rud'*cs+rdd*ss)];

n1=Qin(1)+Qrefl(1)-Qtrans(1);
n2=Qin(2)+Qrefl(2)-Qtrans(2);
n3=Qin(3)+Qrefl(3)-Qtrans(3);
end


function mod=modulus(inc)
mod=inc.*conj(inc);
end