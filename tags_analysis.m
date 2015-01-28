%% first part:  tag-rate analysis

A1 = A(A(:,3)==2,:);

load('../movielens/ml-10M-processed/middle_tags')
tag = cell(0);
fid = fopen('tag_analysis_for_rate2.txt','w');
for i=1:size(A1,1)
    is_exist = user==A1(i,1) & movie == A1(i,2);
    seleted = words(is_exist);
    if(~isempty(seleted))
        tag = [tag;seleted];
        fprintf(fid,'%d::%d::%s\n',A1(i,1),A1(i,2),seleted{1});
    end
    
end
fclose(fid)


A1 = A(A(:,3)==3,:);

tag = cell(0);
fid = fopen('tag_analysis_for_rate3.txt','w');
for i=1:size(A1,1)
    is_exist = user==A1(i,1) & movie == A1(i,2);
    seleted = words(is_exist);
    if(~isempty(seleted))
        tag = [tag;seleted];
        fprintf(fid,'%d::%d::%s\n',A1(i,1),A1(i,2),seleted{1});
    end
    
end
fclose(fid)


A1 = A(A(:,3)==4,:);

tag = cell(0);
fid = fopen('tag_analysis_for_rate4.txt','w');
for i=1:size(A1,1)
    is_exist = user==A1(i,1) & movie == A1(i,2);
    seleted = words(is_exist);
    if(~isempty(seleted))
        tag = [tag;seleted];
        fprintf(fid,'%d::%d::%s\n',A1(i,1),A1(i,2),seleted{1});
    end
    
end
fclose(fid)



A1 = A(A(:,3)==5,:);

tag = cell(0);
fid = fopen('tag_analysis_for_rate5.txt','w');
for i=1:size(A1,1)
    is_exist = user==A1(i,1) & movie == A1(i,2);
    seleted = words(is_exist);
    if(~isempty(seleted))
        tag = [tag;seleted];
        fprintf(fid,'%d::%d::%s\n',A1(i,1),A1(i,2),seleted{1});
    end
    
end
fclose(fid)

%% second part----tag_number-rmse analysis

% read rating file
% clear,clc
% rating = load('../movielens/ml-10M-processed/ap_rating.dat');
% 
% %test = load('../movielens/ml-10M-processed/ap_rating_test1.dat');
% 
% % get frequency
% user = rating(:,1)';
% count = hist(user,max(user));
% 
% 
% % 1.1 analysis user_count  rating_count
% % user = rating(:,1)';
% % count = hist(user,max(user));
% % 
% % count = sort(count,'ascend');
% % cum_count = cumsum(count);
% % 
% % sum(count(count<50))
% % sum(count>=800 & count<1245)
% 
% 
% % 1.2 analysis movie_count  rating_count
% movie = rating(:,2)';
% count = hist(movie,max(movie));
% 
% count = sort(count,'ascend');
% cum_count = cumsum(count);
% 
% sum(count(count<50))
% sum(count>=800 & count<1245)
% 
% % 2. get rating file
% 
% 
% low = [20,50,100,150,200,250,350,450,600,800];
% high = [50,100,150,200,250,350,450,600,800,1246];
% 
% for n = 1:size(low,2)
% 
%     fname = ['ap_rating_tag_',num2str(low(n)),'-',num2str(high(n)),'.dat'];
%     fid = fopen(fname,'w');
% 
% %     for i = 1:size(test,1)
% %         userId = test(i,1);
% %         if(count(userId) >= low(n) & count(userId) < high(n))
% %             fprintf(fid,'%d\t%d\t%3.1f\n',test(i,1),test(i,2),test(i,3));
% %         end
% % 
% %     end
%     
%     for i = 1:size(rating,1)
%         userId = rating(i,1);
%         if(count(userId) >= low(n) & count(userId) < high(n))
%             fprintf(fid,'%d\t%d\t%3.1f\n',rating(i,1),rating(i,2),rating(i,3));
%         end
% 
%     end    
%     
%     
%     fclose(fid);
% 
% end

rating = load('../movielens/ml-10M-processed/ap_rating.dat');
load('../movielens/ml-10M-processed/middle_tags');
num_user_tag = hist(user,max(user));
num_user_rate = hist(rating(:,1),max(rating(:,1)));





num_movietag = hist(user,max(movie));


%





