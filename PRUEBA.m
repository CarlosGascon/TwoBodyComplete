%% Prueba 1

m = 1;
e =linspace(0, 0.5, 100);
d = 12.36;

for i = 1 : length(e)
   [a1(i), a2(i)] = ImageableBounds(e(i), m, d); 
end

plot(a1, e)
hold on
plot(a2, e)

%% Prueba 2

TargetList = {'7 CMa', ['b']};
Targets = ImportData(TargetList);
m = 1;
[Stab, a, e] = SystemStab(Targets{1}, m);

figure
colormap gray;
surf(a, e, Stab' ,'EdgeColor','None', 'facecolor', 'interp');
view(2);
xlim([a(1), a(end)]);
ylim([e(1), e(end)]);
view(2); 