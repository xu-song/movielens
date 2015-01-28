%% =============== part:1  read original tags =============== 
% % output: original_tags.mat
% clear,clc
% fid = fopen('../movielens/ml-10M/tags.dat');
% user = []; mov = []; words = cell(0,0);
% dic = cell(0,0);
% while ~feof(fid)
%     l = fgetl(fid);
%     S = regexp(l, '::', 'split');
%     user = [user;str2num(S{1})];
%     mov = [mov;str2num(S{2})];
%     words = [words;S{3}];
% end
% fclose(fid);
% save( 'user_movie_tags_original','user','mov','words');

%%  =============== read processed tags =============== 










