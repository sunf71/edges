clear;
%% load pre-trained edge detection model and set opts (see edgesDemo.m)
model=load('models/forest/modelBsds'); model=model.model;
model.opts.multiscale=0; model.opts.sharpen=2; model.opts.nThreads=4;

%% set up opts for edgeBoxes (see edgeBoxes.m)
opts = edgeBoxes;
opts.alpha = .65;     % step size of sliding window search
opts.beta  = .75;     % nms threshold for object proposals
opts.minScore = .01;  % min score of boxes to detect
opts.maxBoxes = 1e4;  % max number of boxes to detect

%% detect Edge Box bounding box proposals (see edgeBoxes.m)
I = imread('0005.jpg');

%% show evaluation results (using pre-defined or interactive boxes)
% gt=[122 248 92 65; 193 82 71 53; 410 237 101 81; 204 160 114 95; ...
%   9 185 86 90; 389 93 120 117; 253 103 107 57; 81 140 91 63];

gt = load('box.txt');
gt = gt(:,2:5);
size(gt)
[E,O]=edgesDetect(I,model);
bbs = mEdgeBoxesMex(E,O,opts.alpha,opts.beta,opts.eta,opts.minScore,opts.maxBoxes,...
  opts.edgeMinMag,opts.edgeMergeThr,opts.clusterMinMag,...
  opts.maxAspectRatio,opts.minBoxArea,opts.gamma,opts.kappa,size(gt,1),gt);