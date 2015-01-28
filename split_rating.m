ratings = load('../movielens/ml-10M-processed/ap_rating.dat');
train = [];
test = [];
user_list = unique(ratings(:,1));
movie_list = unique(ratings(:,2));
n_user = size(user_list,1);
n_movie = size(movie_list,1);

for i=1:n_user
    index = ratings(:,1)==user_list(i);
    r =  ratings(index,:);
    count = size(r,1);
    p = randperm(count);
    n_test = floor(3*count/10);
    test = [test; r(p(1:n_test),:)];
    train = [train; r(p(n_test+1:count),:)];
    
end

fid = fopen('../movielens/ml-10M-processed/ap_rating_train.dat','w');
for i=1:size(train,1)
    fprintf(fid,'%d\t%d\t%3.1f\n',train(i,1),train(i,2),train(i,3));
end
fclose(fid);

fid = fopen('../movielens/ml-10M-processed/ap_rating_test.dat','w');
for i=1:size(test,1)
    fprintf(fid,'%d\t%d\t%3.1f\n',test(i,1),test(i,2),test(i,3));
end
fclose(fid);

