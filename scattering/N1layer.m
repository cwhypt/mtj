function [n11,n12,n13,n21,n22,n23,cl11,cl12,cl13,cr11,cr12,cr13]=N1layer(M,theta1,kx,Psi)
Psil1=Psi(69,:);   Psir1=Psi(208,:);
Psil2=Psi(276,:); Psir2=Psi(414,:);

Qleft1=imag([conj(Psil1(1))*Psil1(4)+conj(Psil1(2))*Psil1(3); ...
            -1i*conj(Psil1(1))*Psil1(4)+1i*conj(Psil1(2))*Psil1(3); ...  %hbar^2/2m
              conj(Psil1(1))*Psil1(3)-conj(Psil1(2))*Psil1(4)]);
Qright1=imag([conj(Psir1(1))*Psir1(4)+conj(Psir1(2))*Psir1(3); ...
            -1i*conj(Psir1(1))*Psir1(4)+1i*conj(Psir1(2))*Psir1(3); ...  %hbar^2/2m
              conj(Psir1(1))*Psir1(3)-conj(Psir1(2))*Psir1(4)]);

Qleft2=imag([conj(Psil2(1))*Psil2(4)+conj(Psil2(2))*Psil2(3); ...
            -1i*conj(Psil2(1))*Psil2(4)+1i*conj(Psil2(2))*Psil2(3); ...  %hbar^2/2m
              conj(Psil2(1))*Psil2(3)-conj(Psil2(2))*Psil2(4)]);
Qright2=imag([conj(Psir2(1))*Psir2(4)+conj(Psir2(2))*Psir2(3); ...
            -1i*conj(Psir2(1))*Psir2(4)+1i*conj(Psir2(2))*Psir2(3); ...  %hbar^2/2m
              conj(Psir2(1))*Psir2(3)-conj(Psir2(2))*Psir2(4)]);
          
n11=Qleft1(1)-Qright1(1);n12=Qleft1(2)-Qright1(2);n13=Qleft1(3)-Qright1(3);       
n21=Qleft2(1)-Qright2(1);n22=Qleft2(2)-Qright2(2);n23=Qleft2(3)-Qright2(3);


sigma=[[0 1;1 0],[0,-1i;1i,0],[1 0;0,-1]];
cl11=Qleft1(1);
cr11=Qright1(1); 
cl12=Qleft1(2);
cr12=Qright1(2);   
cl13=Qleft1(3);
cr13=Qright1(3); 



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