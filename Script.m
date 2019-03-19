%% Script

TargetList = {'GJ 832', ['b']};
Targets = ImportData(TargetList);
Mexo = 1;

[Stab, a, e, PerStab] = SystemStab(Targets{1}, Mexo);

GeneratePlot(Stab, a, e)