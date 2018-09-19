T_x=linspace(0,1,51)';
T_sc=zeros(51,2);
count=1;
global flag0
flag0=flag;
h=figure;
h.Position=[50 50 1200 700];
for k=0.5:0.5:5  
    count=1;
    for j=0:pi/50:pi
        [T_sc(count,1),T_sc(count,2)]=T(k,j);
        count=count+1;
        
    end
    T_sc_order=10.^floor( log10(max(T_sc))); %¼ÆËãÖ¸Êý  %max(T_sc);
    T_sc_order_matrix=repmat(T_sc_order,51,1);
    T_sc=T_sc./T_sc_order_matrix;
    flag0.plotsev(h,T_x,T_sc(:,1),T_sc(:,2), 'Xlabel','¦È_2 (pi)','Ylabel','|t^L_{u-u}|^2 and |t^L_{d-d}|^2','title',sprintf('Prob vs. ¦È_2'),'Y1legend',sprintf('Uu-E_{inc}=%0.1feV-%0.0e',k,T_sc_order(1)),'Y2legend',sprintf('Dd-E_{inc}=%0.1feV-%0.0e',k,T_sc_order(2)),'save','true','clear','false');
    
end

figure(h)
legend(flag0.plotsev_leg)