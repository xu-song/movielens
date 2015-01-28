function data = read_doc(fname)
fid = fopen(fname);

data = [];
while 1
    tline = fgetl(fid);
    if ~ischar(tline), break, end
    %f = sscanf(tline,'%d|%d',2);
    data = [data, f];

    
end
data = data';


fclose(fid);

end