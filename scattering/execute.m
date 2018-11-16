T_x=linspace(0,1,51)';
T_sc=zeros(10,2);
count=1;
global flag0
flag0=flag;
h=figure;
h.Position=[50 0 1200 700];  %50 50 
for k=0.025:0.025:0.25  
    count=1;
    for j=0:pi/50:pi
        [T_sc(count,1),T_sc(count,2)]=T(k,j);
        count=count+1;
        
    end
    %T_sc_order=10.^floor( log10(max(T_sc))); %����ָ��  %max(T_sc);
    %T_sc_order_matrix=repmat(T_sc_order,51,1);
    %T_sc=T_sc./T_sc_order_matrix;
    flag0.plotsub(h,2,5,1,T_x,T_sc(:,1),T_sc(:,2), 'Xlabel','��_2 (pi)','Ylabel','|t^L_{u-d}|^2 and |t^L_{d-u}|^2','title',sprintf('Prob vs. ��_2'),'Y1legend',sprintf('UD-E_{inc}=%0.3feV',k),'Y2legend',sprintf('DU-E_{inc}=%0.3feV',k),'save','true','clear','false');
    
end

figure(h)
legend(flag0.plotsev_leg)