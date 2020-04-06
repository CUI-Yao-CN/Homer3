function Homer3(groupDirs, inputFileFormat)

%  Syntax:
%       Homer3(groupDirs, inputFileFormat)
%   
%  Examples:
%
%       Homer3({'.'}, '.snirf')
%       Homer3({'.'}, '.nirs')
%

global logger

logger = Logger('Homer3');

logger.CurrTime();

if nargin==0
    groupDirs = convertToStandardPath(pwd);
end
if nargin<2
    inputFileFormat='snirf';
elseif nargin==1 && isempty(inputFileFormat)
    inputFileFormat='snirf';
end
cfg = ConfigFileClass();

if strcmp(cfg.GetValue('Logging'), 'off')
    logger.SetDebugLevel(logger.Null());
end

PrintSystemInfo(logger);

logger.Write(sprintf('Opened application config file %s\n', cfg.filename))
gdir = cfg.GetValue('Last Group Folder');
if isempty(gdir)
    if isdeployed()
        groupDirs = {[getAppDir(), 'SubjDataSample']};
    end
end
MainGUI(groupDirs, inputFileFormat, 'userargs');

