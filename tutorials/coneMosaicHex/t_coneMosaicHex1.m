%% t_coneMosaicHex1
%
% Shows how to generate a default hexagonal mosaic, and how to customize it (FOV, resamplingFactor).
%
% NPC ISETBIO Team, Copyright 2016

%% Initialize
ieInit; clear; close all;
    
rng('default'); rng(219347);

%% Unit test 1: generate a hex mosaic using defaults params of the superclass (coneMosaic)
% Mosaic Parameters
mosaicParams = struct(...
      'resamplingFactor', 3 ...   % this is the only required initializer parameter
  );
theHexMosaic = coneMosaicHex(mosaicParams.resamplingFactor);


%% Unit test 2: generate a custom hex mosaic
commandwindow;
fprintf('\n<strong>Hit enter to generate a customized hex mosaic based on an 11x16 rect mosaic with equal LMS proportions\n</strong>');
fprintf('<strong>Here we use a high resamplingFactor (10) to get a near perfect hex grid\n</strong>'); pause
% Mosaic Parameters
mosaicParams = struct(...
      'resamplingFactor', 10, ...
                  'size', [11 16], ...          % generate from a rectangular mosaic of 16 x 16 cones
        'spatialDensity', [0 1/3 1/3 1/3]...    % with a LMS density of of 0.33:0.33:0.33
    );
theHexMosaic = coneMosaicHex(mosaicParams.resamplingFactor, ...
                   'name', 'the hex mosaic', ...
                   'size', mosaicParams.size, ...
         'spatialDensity', mosaicParams.spatialDensity ...
    );
theHexMosaic.displayInfo();

%% Unit test 3: change the field of view to 0.4 x 0.4 deg
newFOV = [0.4 0.4];
commandwindow
fprintf('\n<strong>Hit enter to change FOV to [%2.2f, %2.2f]\n</strong>', newFOV(1), newFOV(2)); pause
theHexMosaic.setSizeToFOVForHexMosaic(newFOV);
theHexMosaic.displayInfo();

%% Unit test 3: change the field of view to 0.2 x 0.4 deg
newFOV = [0.2 0.4];
commandwindow
fprintf('\n<strong>Hit enter to change FOV to [%2.2f, %2.2f]\n</strong>', newFOV(1), newFOV(2)); pause
theHexMosaic.setSizeToFOVForHexMosaic(newFOV);
theHexMosaic.displayInfo();