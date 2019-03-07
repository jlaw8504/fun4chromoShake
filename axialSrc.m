function axialSrc(outFilename, srcFilename)
%%axialSrc Extract the MassColor section from a bottle-brush simulation
%%outfile and convert the axial beads, labeled as 1(red), to 4 and all
%%other beads to 0. The converted integer list is written as a txt file.

%   inputs :
%       outFilename : A string containing the name of the simulation
%       outfile to parse.
%
%       srcFilename : A string containing the name of the src file you want
%       write to.

%% Open outfile and src file for writing
fid = fopen(outFilename, 'r');
fid2 = fopen(srcFilename, 'w');
%% Set counters and toggles
iscolor = false;

%% Loop through lines of outfile
while ~feof(fid)
    tline = fgetl(fid);
    if strcmp('MassColors', strip(tline))
        iscolor = true;
    end
    if iscolor  && ~isempty(strip(tline))
        if str2double(strip(tline)) == 1
            fprintf(fid2, '4\n');
        else
            fprintf(fid2, '0\n');
        end
    elseif iscolor  && isempty(strip(tline))
        break;
    end        
end
%% Close files
fclose(fid);
fclose(fid2);