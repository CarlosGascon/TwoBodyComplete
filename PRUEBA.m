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
GeneratePlot(Stab, a, e)