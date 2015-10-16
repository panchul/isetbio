
% s_rgc
% 
% This script builds scene, sensor, outersegment and rgc objects in isetbio
% and computes the RGC responses. The RGC responses are stored in the rgc
% mosaic object and can be viewed as a movie by running the command on the
% last line.
% 
% isetbio
% 9/2015 JRG

clear

%% build scene
params.image_size = 96;
params.meanLuminance = 100;
params.nsteps = 30;
params.fov = 0.6;
[scene, display] = sceneHorwitzHassWhiteNoise(params);

% vcAddObject(scene); sceneWindow

% displayClose;

% % build optical image
oi  = oiCreate('wvf human');

%% build sensor for white noise
sensor = sensorHorwitzHassShortWhiteNoise(params, scene, oi, display);

%% build outersegment
identityOS = osCreate('identity');

sceneRGB = sceneHorwitzHassWhiteNoiseRGB(params);
% sceneRGB = sceneHorwitzHassBarRGB(params);
% sceneRGB = 0.5*ones(params.image_size, params.image_size, params.nsteps, 3);

% for frame = 1:params.nsteps
%     params.freq =  [5 ]; % spatial frequencies of 1 and 5
%     params.contrast = [0.6]; % contrast of the two frequencies
%     params.ang  = [0,]; % orientations
%     params.ph  = [0 ]; % phase
%     sharmonic = sceneCreate('harmonic',params);
%     sceneRGB(:,:,frame,:) = sceneGet(sharmonic,'rgb');
% end
 
identityOS = osSet(identityOS, 'rgbData', sceneRGB);

%% build rgc

% rgc1 = rgcLinear(scene, sensor, osIdentity, 'right', 3.75, 180);
% rgc1 = rgcLNP(scene, sensor, osIdentity, 'right', 3.75, 180);
rgc1 = rgcGLM(scene, sensor, identityOS, 'right', 3.0, 180);
% rgc1 = rgcSubunit(scene, sensor, identityOS, 'right', 3.0, 180);

%% compute rgc

% % % tic
rgc1 = rgcCompute(rgc1, identityOS);
% % toc

% % tic
rgcPlot(rgc1, 'spikeResponse');
rgcPlot(rgc1, 'rasterResponse');
% % % toc
%% With linear cone response

linearOS = osCreate('linear');
linearOS = osCompute(linearOS, sensor);

rgc1 = rgcGLM(scene, sensor, linearOS, 'right', 3.0, 180);
% rgc1 = rgcCreate('rgcGLM',scene, sensor, linearOS, 'right', 3.0, 180);

rgc1 = rgcCompute(rgc1, linearOS);

rgcPlot(rgc1, sensor, linearOS);
%% build movie
% 
rgcMovie(rgc1, identityOS);