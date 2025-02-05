function pdemodel
[pde_fig,ax]=pdeinit;
pdetool('appl_cb',5);
set(ax,'DataAspectRatio',[1 1 1]);
set(ax,'PlotBoxAspectRatio',[1.5 1 1]);
set(ax,'XLim',[-1.5 1.5]);
set(ax,'YLim',[-1 1]);
set(ax,'XTickMode','auto');
set(ax,'YTickMode','auto');

% Geometry description:
pdecirc(0,0,0.20000000000000001,'C1');
pdecirc(0,0,0.59999999999999998,'C2');
set(findobj(get(pde_fig,'Children'),'Tag','PDEEval'),'String','C2-C1')

% Boundary conditions:
pdetool('changemode',0)
pdesetbd(8,'dir',1,'1','400')
pdesetbd(7,'dir',1,'1','400')
pdesetbd(6,'dir',1,'1','400')
pdesetbd(5,'dir',1,'1','400')
pdesetbd(4,'dir',1,'1','200')
pdesetbd(3,'dir',1,'1','200')
pdesetbd(2,'dir',1,'1','200')
pdesetbd(1,'dir',1,'1','200')
% Mesh generation:
setappdata(pde_fig,'Hgrad',1.3);
setappdata(pde_fig,'refinemethod','regular');
setappdata(pde_fig,'jiggle',char('on','mean',''));
setappdata(pde_fig,'MesherVersion','preR2013a');
pdetool('initmesh')
pdetool('refine')
pdetool('refine')
pdetool('refine')
pdetool('refine')
pdetool('refine')
pdetool('refine')
pdetool('refine')
pdetool('refine')

% PDE coefficients:
pdeseteq(1,'1.0','0.0','0','1.0','0:10','0.0','0.0','[0 100]')
setappdata(pde_fig,'currparam',['1.0';'0  '])

% Solve parameters:
setappdata(pde_fig,'solveparam',char('0','5520','10','pdeadworst','0.5','longest','0','1E-4','','fixed','Inf'))

% Plotflags and user data strings:
setappdata(pde_fig,'plotflags',[1 1 1 1 1 1 1 1 0 0 0 1 1 1 0 1 0 1]);
setappdata(pde_fig,'colstring','');
setappdata(pde_fig,'arrowstring','');
setappdata(pde_fig,'deformstring','');
setappdata(pde_fig,'heightstring','');

% Solve PDE:
pdetool('solve')
