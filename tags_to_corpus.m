%% =============== part:1  read original tags =============== 
% output: tags.mat
% clear,clc
% fid = fopen('../movielens/ml-10M/tags.dat');
% user = []; movie = []; words = cell(0,0);
% dic = cell(0,0);
% while ~feof(fid)
%     l = fgetl(fid);
%     S = regexp(l, '::', 'split');
%     user = [user;str2num(S{1})];
%     movie = [movie;str2num(S{2})];
%     words = [words;S{3}];
% end
% fclose(fid);
% 
% %%  =============== read processed tags =============== 
% fid = fopen('../movielens/ml-10M-processed/words.index');
% tag = cell(0,0);
% 
% while ~feof(fid)
%     l = fgetl(fid);
%     f = sscanf(l,'%d',Inf);
%     if(~isempty(f))
%         tag = [tag; f];
%     else
%         user(size(tag,1)+1) = [];   % get less elements
%         movie(size(tag,1)+1) = [];
%         words(size(tag,1)+1) = [];
%        
%     end
% 
% end
% fclose(fid);
% 
% save('../movielens/ml-10M-processed/tags.mat','user','movie','tag','words');


%%  =============== part 2.1:  get less ratings =============== 
% output: user_list, movie_list, ap_rating.dat

% clear,clc
% fid = fopen('../movielens/ml-10M/ratings.dat');
% ratings = fscanf(fid, '%d::%d::%f::%d',[4 inf]);  % can read all the data
% ratings = ratings';
% fclose(fid);
% 
% load('../movielens/ml-10M-processed/tags.mat');
% user_list = unique(user);
% movie_list = unique(movie);
% 
% lia1 = ismember(ratings(:,1),user_list);
% lia2 = ismember(ratings(:,2),movie_list);
% 
% ratings(~(lia1 & lia2),:) = [];    % caution:: ratings has changed here
% 
% user_list = unique(ratings(:,1));  % caution:: list has changed here
% movie_list = unique(ratings(:,2)); % caution:: list has changed here
% 
% % write user_list file
% fid = fopen('../movielens/ml-10M-processed/user_list.dat','w');
% for i=1:size(user_list,1)
%     fprintf(fid,'%d\n',user_list(i));
% end
% fclose(fid);
% 
% % write movie_list file
% fid = fopen('../movielens/ml-10M-processed/movie_list.dat','w');
% for i=1:size(movie_list,1)
%     fprintf(fid,'%d\n',movie_list(i));
% end
% fclose(fid);
% 
% 
% % write rating file
% fid = fopen('../movielens/ml-10M-processed/ap_rating_oldID.dat','w');
% for i=1:size(ratings,1)
%     fprintf(fid,'%d\t%d\t%3.1f\n',ratings(i,1),ratings(i,2),ratings(i,3));
%     
% %     newid_user = find(user_list==ratings(i,1));
% %     newid_movie = find(movie_list==ratings(i,2));
% %     fprintf(fid,'%d\t%d\t%3.1f\n',newid_user,newid_movie,ratings(i,3));
% 
% 
% end
% fclose(fid);


%%  =============== part 2.2:  get less tags =============== 
% write tags words file

% clear,clc
% load('../movielens/ml-10M-processed/tags.mat');
% user_list = load('../movielens/ml-10M-processed/user_list.dat');
% movie_list = load('../movielens/ml-10M-processed/movie_list.dat');
% 
% 
% lia1 = ismember(user,user_list);
% lia2 = ismember(movie,movie_list);
% 
% words(~(lia1 & lia2),:) = [];    % caution:: ratings has changed here
% user(~(lia1 & lia2),:) = [];    % caution:: ratings has changed here
% movie(~(lia1 & lia2),:) = [];    % caution:: ratings has changed here
% 
% user_list = unique(user);  % caution:: list has changed here
% movie_list = unique(movie); % caution:: list has changed here
% 
% % write user_list file
% fid = fopen('../movielens/ml-10M-processed/user_list.dat','w');
% for i=1:size(user_list,1)
%     fprintf(fid,'%d\n',user_list(i));
% end
% fclose(fid);
% 
% % write movie_list file
% fid = fopen('../movielens/ml-10M-processed/movie_list.dat','w');
% for i=1:size(movie_list,1)
%     fprintf(fid,'%d\n',movie_list(i));
% end
% fclose(fid);
% 
% % write tags words file
% 
% fid = fopen('../movielens/ml-10M-processed/words.index');
% tag = cell(0,0);
% while ~feof(fid)
%     l = fgetl(fid);
%     f = sscanf(l,'%d',Inf);
%     tag = [tag; f];
% end
% fclose(fid);
% save('../movielens/ml-10M-processed/tags.mat','user','movie','tag','words');
% 
% 
% 
% fid = fopen('../movielens/ml-10M/words.dat','w');
% for i=1:size(words,1)
%     fprintf(fid,'%s\n',words{i});
% end
% fclose(fid);





%%  =============== part 3:  get user/movie corpus =============== 
% % input: user_list, movie_list
% % output: ap_user, ap_movie

clear,clc
user_list = load('../movielens/ml-10M-processed/user_list.dat');
movie_list = load('../movielens/ml-10M-processed/movie_list.dat');

load('../movielens/ml-10M-processed/middle_tags.mat');

% get ap_user
fid = fopen('../movielens/ml-10M-processed/ap_user.dat','w');

for i=1:size(user_list,1)
    corpus = [];
    % get corpus_i
    userID = user_list(i);
    index =find(user==userID);
    for j=1:size(index,1)
        corpus = [corpus;tag{index(j)}];
    end
    
    % get count
    words = unique(corpus);
    fprintf(fid,'%d',size(words,1));
    for j=1:size(words,1)
        word = words(j);
        count = sum(corpus == word);
        fprintf(fid,' %d:%d', word, count);
    end
    fprintf(fid,'\n');
end
fclose(fid);

% get ap_movie

fid = fopen('../movielens/ml-10M-processed/ap_movie.dat','w');

for i=1:size(movie_list,1)
    corpus = [];
    % get corpus_i
    movieID = movie_list(i);
    index =find(movie==movieID);
    for j=1:size(index,1)
        corpus = [corpus;tag{index(j)}];
    end
    
    % get count
    words = unique(corpus);
    fprintf(fid,'%d',size(words,1));
    for j=1:size(words,1)
        word = words(j);
        count = sum(corpus == word);
        fprintf(fid,' %d:%d', word, count);
    end
    fprintf(fid,'\n');
end
fclose(fid);





