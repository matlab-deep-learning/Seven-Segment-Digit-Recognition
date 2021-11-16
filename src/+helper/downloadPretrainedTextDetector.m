function model = downloadPretrainedTextDetector()
% The downloadPretrainedCRAFT function downloads the pretrained
% text detector.
%
% Copyright 2021 The MathWorks, Inc.

dataPath = 'model';
modelName = 'craftModel';
netFileFullPath = fullfile(dataPath, modelName);

% Add '.zip' extension to the data.
netFileFull = [netFileFullPath,'.zip'];

if ~exist(netFileFull,'file')
    fprintf(['Downloading pretrained Text Detector.\n']);
    fprintf('This can take several minutes to download...\n');
    url = 'https://ssd.mathworks.com/supportfiles/vision/deeplearning/models/TextDetection/craftModel.zip';
    websave (netFileFullPath,url);
    unzip(netFileFullPath, dataPath);
    model = load([dataPath, '/craftNet.mat']);
else
    fprintf('Pretrained Text Detector already exists.\n\n');
    unzip(netFileFullPath, dataPath);
    model = load([dataPath, '/craftNet.mat']);
end
end
