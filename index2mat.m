clear,clc
% =============== read processed tags =============== 

load('../movielens/ml-10M-processed/middle_tags.mat');

fid = fopen('../movielens/ml-10M-processed/words.index');
tag = cell(0,0);
is_Nan = zeros(size(user,1),1);
i = 1;
while ~feof(fid)
    l = fgetl(fid);
    if(strcmp(l,'NaN'))
        tag = [tag; NaN];
        is_Nan(i) = 1;
    else
        f = sscanf(l,'%d',Inf);
        tag = [tag; f];
    end
    i=i+1;



end
fclose(fid);



user(is_Nan ==1) = [];
movie(is_Nan ==1) = [];
tag(is_Nan ==1) = [];
words(is_Nan ==1) = [];

save('../movielens/ml-10M-processed/middle_tags.mat','user','movie','tag','words');
