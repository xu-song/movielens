% %% get small dataset
% %%  =============== part 2.1:  filter by rating_count =============== 
% % output: user_list , movie_list
%clear,clc
%load('../movielens/ml-10M-processed/tags.mat');
ratings = load('../movielens/ml-10M-processed/ap_rating_oldID.dat');
user_list = unique(user);
movie_list = unique(movie);
for i=1:size(user_list,1)  
    index = ratings(:,1)==user_list(i);
    count = sum(index);
    if count<20
        ratings(index,:) = [];
    end
        
    
end

for i=1:size(movie_list,1)
    index = ratings(:,2)==movie_list(i);
    count = sum(index);
    if count<20
        ratings(index,:) = [];
    end
        
    
end

user_list = unique(ratings(:,1));
movie_list = unique(ratings(:,2));
% 
% %%  =============== part 2.2:  filter by corpus_count =============== 
% 
% % 
% 
lia1 = ismember(user,user_list);
lia2 = ismember(movie,movie_list);

words(~(lia1 & lia2),:) = [];    % caution:: ratings has changed here
user(~(lia1 & lia2),:) = [];    % caution:: ratings has changed here
movie(~(lia1 & lia2),:) = [];    % caution:: ratings has changed here
tag(~(lia1 & lia2),:) = [];    % caution:: ratings has changed here

user_list = unique(user);  % caution:: list has changed here
movie_list = unique(movie); % caution:: list has changed here

less = 0;
temp = size(user_list,1);
for i=1:temp
    corpus = [];
    % get corpus_i
    userID = user_list(i-less);
    index =find(user==userID);
    for j=1:size(index,1)
        corpus = [corpus;tag{index(j)}];
    end
    
    % get count
    count = size(corpus,1);
    %if (count < 10 || count>200)   % -------------main parameter---------------
    if (count < 1 || count>500)   % -------------middle---------------
        user_list(find(user_list==userID))=[]; 
        
        words(index) = [];    % caution:: ratings has changed here
        user(index) = [];    % caution:: ratings has changed here
        movie(index) = [];    % caution:: ratings has changed here
        tag(index) = [];    % caution:: ratings has changed here
        less=less+1;
    end
end

user_list = unique(user); 
movie_list = unique(movie);

less = 0;
temp = size(movie_list,1);
for i=1:temp
    corpus = [];
    % get corpus_i
    movieID = movie_list(i-less);
    index =find(movie==movieID);
    for j=1:size(index,1)
        corpus = [corpus;tag{index(j)}];
    end
    
    % get count
    count = size(corpus,1);
    %if (count < 10 || count>300)    % -------------main parameter---------------
    if (count < 1 || count>500)    % -------------middle---------------
        movie_list(find(movie_list==movieID))=[]; 
        
        words(index) = [];    % caution:: ratings has changed here
        user(index) = [];    % caution:: ratings has changed here
        movie(index) = [];    % caution:: ratings has changed here
        tag(index) = [];    % caution:: ratings has changed here
        less=less+1;
    end
end

user_list = unique(user); 
movie_list = unique(movie);

save('../movielens/ml-10M-processed/middle_tags.mat','user','movie','tag','words');

%%  =============== part 2.3:  get less ratings =============== 
% output: user_list, movie_list, ap_rating.dat

ratings = load('../movielens/ml-10M-processed/ap_rating_oldID.dat');

%load('../movielens/ml-10M-processed/small_tags.mat');
user_list = unique(user);
movie_list = unique(movie);

lia1 = ismember(ratings(:,1),user_list);
lia2 = ismember(ratings(:,2),movie_list);

ratings(~(lia1 & lia2),:) = [];    % caution:: ratings has changed here

user_list = unique(ratings(:,1));  % caution:: list has changed here
movie_list = unique(ratings(:,2)); % caution:: list has changed here

% write user_list file
fid = fopen('../movielens/ml-10M-processed/user_list.dat','w');
for i=1:size(user_list,1)
    fprintf(fid,'%d\n',user_list(i));
end
fclose(fid);

% write movie_list file
fid = fopen('../movielens/ml-10M-processed/movie_list.dat','w');
for i=1:size(movie_list,1)
    fprintf(fid,'%d\n',movie_list(i));
end
fclose(fid);


% write rating file
fid = fopen('../movielens/ml-10M-processed/ap_rating_oldID.dat','w');
for i=1:size(ratings,1)
    fprintf(fid,'%d\t%d\t%3.1f\n',ratings(i,1),ratings(i,2),ratings(i,3));
end
fclose(fid);

fid = fopen('../movielens/ml-10M-processed/ap_rating.dat','w');
for i=1:size(ratings,1)
    newid_user = find(user_list==ratings(i,1));
    newid_movie = find(movie_list==ratings(i,2));
    fprintf(fid,'%d\t%d\t%3.1f\n',newid_user,newid_movie,ratings(i,3));
end
fclose(fid);


fid = fopen('../movielens/ml-10M-processed/words.dat','w');
for i=1:size(words,1)
    fprintf(fid,'%s\n',words{i});
end
fclose(fid);

