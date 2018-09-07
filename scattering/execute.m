T_sc=zeros(31,2);
count=1;
for j=0:0.1:3
    [T_sc(count,1),T_sc(count,2)]=T(j);
        count=count+1;
end
close(figure(1))
figure(1)
plot(T_sc(:,1))
hold on
s1=plot(T_sc(:,2))
legend('P-up','P-down')
title(sprintf('Tunneling probability'))
xlabel('E(0-3eV)')
ylabel('Probability')
%dim = [.2 .5 .3 .3];
%str = sprintf('T-up: %0.1e,T-down: %0.1e',Prob(3,1),Prob(4,1));
%t1=annotation('textbox',dim,'String',str,'FitBoxToText','on');
saveas(s2,sprintf('C:\\Users\\cwhypt\\Documents\\MATLAB\\pic\\Prob.jpg'));
