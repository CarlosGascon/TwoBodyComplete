%% Script

TargetList = {'7 CMa', ['b']};
Targets = ImportData(TargetList);
Mexo = 1;

[Stab, a, e, PerStab] = SystemStab(Targets{1}, Mexo);

GeneratePlot(Stab, a, e)