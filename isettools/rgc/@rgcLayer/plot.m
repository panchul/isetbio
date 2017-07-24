function [hdl, uData] = plot(obj, pType, varargin)
% Plot function for rgcLayer
%
%    [hf, uData] = rgcLayer.plot(type, varargin)
%
% When the plots are directed to a single mosaic, this call forwards to
% @rgcMosaic.plot.
%
% Inputs:
%   type - string, type of plot
%
% Optional input (key-val pairs in varargin):
%   nMosaic - which mosaic to use
%   'hf' - figure handle or control structure, the meaning of value is
%             []            - create plot in new figure
%             figure handle - plot in figure specified by hf
%             'none'        - don't plot
%
% Outputs:
%   hf    - figure handle
%   uData - Computed data
%
% Examples:
%   rgcLayer.plot('mosaic','nMosaic',1);
%   rgcLayer.plot('psth','nMosaic',2);
%   rgcLayer.plot('psth','nMosaic',2,'cell',[1 1]);
%
% JRG/HJ/BW, ISETBIO TEAM, 2016

%%
p = inputParser;
p.KeepUnmatched = true;

% Set up vFunc for checking the pType
pType = ieParamFormat(pType);
p.addRequired('pType', @isstr);     % Type of plot
p.addParameter('hf', obj.figureHandle, @isgraphics);  % figure handle

p.addParameter('nMosaic',1,@isinteger);
p.parse(pType,varargin{:});

% Which mosaic.
nMosaic = p.Results.nMosaic;
if nMosaic > length(obj.mosaic)
    error('nMosaic (%d) exceeds number of bipolar layers (%d)\n',...
        nMosaic,length(obj.mosaic));
end

%% Account for parameters
if p.Results.newWindow; hdl = vcNewGraphWin; end

uData = [];
if nMosaic == 0
    % A plot that uses more than one mosaic.  What the layer is for.
    % We need to make some stuff up for here.
    disp('Whole layer plot options are NYI')
    return;
else
    % A plot based on one mosaic.  Call the bipolarMosaic.plot funciton.
    [hdl, uData] = obj.mosaic{nMosaic}.plot(pType,'hf',hf);
end

end

    
        