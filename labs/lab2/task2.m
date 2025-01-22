function pdemodel
    [pde_fig, ax] = pdeinit;
    pdetool('appl_cb', 5);
    set(ax, 'DataAspectRatio', [1 1 1]);
    set(ax, 'PlotBoxAspectRatio', [1.5 1 2]);
    set(ax, 'XLim', [-0.75 0.75]);
    set(ax, 'YLim', [-0.5 0.5]);
    set(ax, 'XTickMode', 'auto');
    set(ax, 'YTickMode', 'auto');

    % Geometry description
    pderect([-0.55 0.55 0.25 -0.25], 'R1');
    pdecirc(-0.35, 0, 0.1, 'E1');
    pdecirc(0.35, 0, 0.1, 'E2');
    set(findobj(get(pde_fig, 'Children'), 'Tag', 'PDEEval'), 'String', 'R1-E1-E2')

    % Boundary conditions
    pdetool('changemode', 0)
    pdesetbd(12, 'dir', 1, '1', '-110')
    pdesetbd(11, 'dir', 1, '1', '-110')
    pdesetbd(10, 'dir', 1, '1', '-110')
    pdesetbd(9, 'dir', 1, '1', '-110')
    pdesetbd(8, 'dir', 1, '1', '110')
    pdesetbd(7, 'dir', 1, '1', '110')
    pdesetbd(6, 'dir', 1, '1', '110')
    pdesetbd(5, 'dir', 1, '1', '110')
    pdesetbd(4, 'dir', 1, '1', '0')
    pdesetbd(3, 'dir', 1, '1', '0')
    pdesetbd(2, 'dir', 1, '1', '0')
    pdesetbd(1, 'dir', 1, '1', '0')

    % Mesh generation
    setappdata(pde_fig, 'Hgrad', 1.3);
    setappdata(pde_fig, 'refinemethod', 'regular');
    setappdata(pde_fig, 'jiggle', char('on', 'mean', ''));
    setappdata(pde_fig, 'MesherVersion', 'preR2013a');
    pdetool('initmesh')
    pdetool('refine')
    pdetool('refine')
    pdetool('refine')

    % PDE coefficients
    pdeseteq(1, '1.0', '0.0', '0', '1.0', '0:10', '0.0', '0.0', '[0 100]')
    setappdata(pde_fig, 'currparam', ['1.0'; '0  '])

    % Solve parameters
    setappdata(pde_fig, 'solveparam', char('0', '15360', '10', 'pdeadworst', '0.5', 'longest', '0', '1E-4', '', 'fixed', 'Inf'))

    % Plotflags and user data strings
    setappdata(pde_fig, 'plotflags', [1 1 1 1 1 1 1 1 0 0 0 1 1 1 0 1 0 1]);
    setappdata(pde_fig, 'colstring', '');
    setappdata(pde_fig, 'arrowstring', '');
    setappdata(pde_fig, 'deformstring', '');
    setappdata(pde_fig, 'heightstring', '');

    % Solve PDE
    pdetool('solve')
end