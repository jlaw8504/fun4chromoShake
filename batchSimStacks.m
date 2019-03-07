function runB2F(simFilename, srcFilename, varargin)


%% Create InputParser object
p = inputParser;

% Defaults and checks
defaultPsfFile = 'PSF.txt';
[~,basename,~] = fileparts(simFilename);
defaultXmlDir = strcat(basename, '_XML');
defaultTifDir = strcat(basename, '_tif');
defaultWidth = 100;
defaultHeight = 100;
defaultPixelSize = 64.5;
defaultVoxelDepth = 300;
defaultPlaneNum = 7;
defaultEveryNum = 213;

% Add inputs
addRequired(p, 'simFilename', @ischar);
addRequired(p, 'srcFilename', @ischar);
addParameter(p, 'psfFile', 'defaultPsfFile', @ischar);
addParameter(p, 'xmlDir', 'defaultXmlDir', @ischar);
addParameter(p, 'tifDir', 'defaultTifDir', @ischar);
addParameter(p, 'width', 'defaultWidth', @isinteger);
addParameter(p, 'height', 'defaultHeight', @isinteger);
addParameter(p, 'pixelSize', 'defaultPixelSize', @isnumeric);
addParameter(p, 'voxelDepth', 'defaultVoxelDepth', @isinteger);
addParameter(p, 'planeNumber', 'defaultPlaneNum', @isinteger);
addParameter(p, 'everyNum', 'defaultEveryNum', @isinteger);

system(sprintf(['python ParseBrownian.py -PSF %s ' ...
            '-out %s -width %d -height %d ' ...
            '-pixel_size %f -voxel_depth %d -focal_planes %d ' ... 
            '-every %d %s %s'],...
            psfFile, xmlDir, width, height, pixelSize, voxelDepth,...
            planeNumber, everyNum, srcFilename, simFilename));
        system(sprintf('python.exe BrownianXMLtoTIFF.py -green -out %s %s',...
            tifDir, xmlDir));