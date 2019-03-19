function [] = GeneratePlot(Stab, a, e)

Minval = min(Stab(Stab > 0));
Stab(Stab == 0) = Minval - 0.5;

figure
colormap hot;
surf(a, e, Stab' ,'EdgeColor','None', 'facecolor', 'interp');
view(2);
xlim([a(1), a(end)]);
ylim([e(1), e(end)]);
view(2); 
%cbar = colorbar;
liminf = Minval - 1;
limsup = 7;
caxis([liminf limsup])

ticks = round(Minval, 1) : 0.5 : limsup;
cbar = colorbar('Ticks',[liminf, Minval - 0.5, ticks],...
         'TickLabels',{'NI', 'HU', ticks})

set(cbar, 'TickLabelInterpreter', 'latex', 'FontSize', 10);
set(gca,'TickLabelInterpreter','latex');
xlabel('a [AU]','Interpreter','latex', 'FontSize', 10);
ylabel('e','Interpreter','latex', 'FontSize', 10);
y = ylabel(cbar, '$log_{10}(t)$','Interpreter','latex');
set(y, 'position', get(y,'position')-[0,0,0], 'FontSize', 10);

end

