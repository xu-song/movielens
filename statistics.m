%%  2013/03/15
% 1. read rating file
clear,clc,close all;
fid = fopen('../movielens/ml-10M/ratings.dat');
% fid=fopen('1.m');
% a=fgetl(fid);

A = fscanf(fid,'%d::%d::%f::%d',[4 inf]);  
A=A';
fclose(fid);
%formatA



%% 2. movie count per user
% 2.1
% X: user id
% Y: rating(movie) count per user
N_user=max(A(:,1));  % 71567 users
count_user=zeros(N_user,1);

% too time consuming, can be replaced by hist or tab..
% for i=1:N_user
%     count_user(i,1)=sum(A(:,1)==i);
% end
count_user = hist(A(:,1),max(A(:,1)))';  % only when mainA(:,1)) = 1 it works

figure
plot(1:N_user,count_user,'.')
xlabel('user id'),ylabel('movie count per user')
%set(gcf,'Position',[100 100 500 320]);
set(gcf, 'Units', 'Inches', 'Position', [0 0 3 2])
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 3 2]);
print(gcf, '-dpng', 'image/movie_count_per_user.png');
%saveas(gcf,'image/movie_count_per_user','png');

% 2.2
max_count=max(count_user); % max_count = 7359
count_user(count_user==0) = 0;
table = tabulate(count_user);

% plot
figure
subplot(1,2,1), plot(table(:,1),table(:,2),'.')  % max_count = 7359
xlabel('Number of User Ratings'),ylabel('Number of Users');

% log plot
subplot(1,2,2), loglog(table(:,1),table(:,2),'.');
xlabel('Number of User Ratings'),ylabel('Number of Users');
%set(gcf,'Position',[100 100 800 320]);
set(gcf, 'Units', 'Inches', 'Position', [0 0 5 2])
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 5 2]);
%print(gcf, '-depsc2','-loose', 'userrating-num-all.eps');
print(gcf, '-dpng', 'image/userrating-num-all.png');



%%  3. user count per movie
% 3.1
% X: movie id
% Y: rating(user) count per movie

% movie_ID=unique(A(:,2));
% N_movie=size(movie_ID,1);
N_movie = max(A(:,2));
count_movie = hist(A(:,2),max(A(:,2)))';  % only when mainA(:,2)) = 1 it works
figure
plot(1:N_movie,count_movie,'.')
xlabel('movie id'),ylabel('user count per movie');
%set(gcf,'Position',[100 100 500 320]);
set(gcf, 'Units', 'Inches', 'Position', [0 0 3 2])
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 3 2]);
print(gcf, '-dpng', 'image/user_count_per_movie.png');

% 3.2
max_count=max(count_movie);
count_movie(count_movie==0) = [];
table = tabulate(count_movie);

% plot
figure
subplot(1,2,1), plot(table(:,1),table(:,2),'.')  % max_count = 7359
xlabel('Number of Movie Ratings'),ylabel('Number of Movies');

% log plot
% figure,semilogy(1:max_count,movies,'.');
subplot(1,2,2), loglog(table(:,1),table(:,2),'.');
xlabel('Number of Movie Ratings'),ylabel('Number of Movies');
%set(gcf,'Position',[100 100 800 320]);
set(gcf, 'Units', 'Inches', 'Position', [0 0 5 2])
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 5 2]);
print(gcf, '-dpng', 'image/movierating-num-all.png');


%% rating hist
% Ratings are made on a 5-star scale, with half-star increments.

rating_count=zeros(9,1);
rating=1:0.5:5;

for i=1:9
    rating_count(i)=sum(A(:,3)==rating(i));
end

figure
bar(1:0.5:5,rating_count)
set(gcf, 'Units', 'Inches', 'Position', [0 0 3 2])
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 3 2]);
% set(gcf,'Position',[100 100 500 320]);
print(gcf, '-dpng', 'image/rating-distribution.png');

average_rating=mean(A(:,3));


%% is there one user rates one movie twice?
%  function istwice()
% num=zeros(N_user,1);
% for i=1:N_user
%     index=find(A(:,1)==i);
%     movie_i=A(index,2);
%     
%     temp=unique(movie_i);
%     
%     if(size(movie_i,1)~=size(temp,1))
%         num(i)=num(i)+1;
%     end
%     
% end


