function write_tag_csv
clear,clc

% load middle_tags and rating
load('../movielens/ml-10M-processed/user_movie_tags_tagcoding');
ratings = load('../movielens/ml-10M-processed/ap_rating.dat');

% load user-movie
usermap = load('../movielens/ml-10M-processed/user_list.dat');
moviemap = load('../movielens/ml-10M-processed/movie_list.dat');
mov_name = get_mov_name('../movielens/ml-10M-processed/movie_name.dat');


% write file
fid = fopen('../movielens/ml-10M-processed/tag.csv','w');
fprintf(fid,'userID,movieID,tag,,,original_UID,original_MID,movie_name,rating,tag_coding\n')
for i = 1:size(mov,1)
    fprintf(fid,'%d,%d,%s,,,%d,%d,"%s",',user(i),mov(i),words{i},usermap(user(i)),moviemap(mov(i)),mov_name{mov(i)});
    
    rating_i = ratings(ratings(:,1) == user(i) & ratings(:,2) == mov(i), :);
    if(~isempty(rating_i))
        fprintf(fid,'%3.1f,',rating_i(3));
    else
        fprintf(fid,',');
    end
    
    
    tag_coding = tag{i};
    for j=1:size(tag_coding,1)
        fprintf(fid,'%d ',tag_coding(j));
    end
    fprintf(fid,'\n');
end
fclose(fid);


function mov_name = get_mov_name(fname)

mov_name= cell(0);
fid=fopen(fname);
while 1
    tline = fgetl(fid);
    if ~ischar(tline), break, end
    mov_name = [mov_name;tline];
end
fclose(fid);