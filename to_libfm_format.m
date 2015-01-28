% convert to libfm
function to_libfm_format(outFile, inFile, uCount, vCount)

%% input
% 1. 'movielens' 
uCount = 1033; vCount = 1996; 
partion = '40%_train/';  % partion = [], '20%_train/', '30%_train/'
ftrain = ['../delicious/data_processed/mid/',partion,'ap_User_URL_mid_train.dat']; train = read_doc(ftrain);
ftest = ['../delicious/data_processed/mid/',partion,'ap_User_URL_mid_test.dat'];   test = read_doc(ftest);
fall = '../delicious/data_processed/mid/ap_User_URL_mid.dat';

% 2. 'DBLP'
% uCount = 27704; vCount = 2144; 
% ftrain = '../DBLP_tangjie/data_processed/ap_AuPub_train.dat'; train = read_dat(ftrain);
% ftest = '../DBLP_tangjie/data_processed/ap_AuPub_test.dat';   test = read_dat(ftest);
% fall = '../DBLP_tangjie/data_processed/ap_AuPub.dat';



%% train
% 1. positive => train
fid1_in = fopen(ftrain);
fid1_out = fopen([ftrain, '.libfm'], 'w');
while 1
    tline = fgetl(fid1_in);
    if ~ischar(tline), break, end
    str = regexp(tline, ' ', 'split');
    ID = regexp(str{1}, '\|', 'split');
    uID = str2num(ID{1});
    vID = str2num(ID{2});    
    
    fprintf(fid1_out, '1 %d:1 %d:1',uID, vID + uCount); % label/score id:value
    
    for i = 3:size(str,2)
        feature = regexp(str{i}, ':', 'split');
        word = str2num(feature{1});
        count = str2num(feature{2});
        fprintf(fid1_out, ' %d:%d', word + uCount + vCount, count);
    end
    fprintf(fid1_out, '\n');
end
fclose(fid1_in);

% 2. negative => train
positive = [train; test];
negative = get_negative(positive);
num_negative = size(negative,1);
index = randperm(num_negative);
for i = 1:size(train,1)*2
    fprintf(fid1_out,'0 %d:1 %d:1\n',negative(index(i),1), negative(index(i),2) + uCount);
end
fclose(fid1_out);

%% test (just positive => test)
% fid2_in = fopen(ftest);
% fid2_out = fopen([ftest, '.libfm'], 'w');
% while 1
%     tline = fgetl(fid2_in);
%     if ~ischar(tline), break, end
%     str = regexp(tline, ' ', 'split');
%     ID = regexp(str{1}, '\|', 'split');
%     uID = str2num(ID{1});
%     vID = str2num(ID{2});    
%     
%     fprintf(fid2_out, '1 %d:1 %d:1',uID, vID + uCount); % label/score id:value
%     
%     for i = 3:size(str,2)
%         feature = regexp(str{i}, ':', 'split');
%         word = str2num(feature{1});
%         count = str2num(feature{2});
%         fprintf(fid2_out, ' %d:%d', word + uCount + vCount, count);
%     end
%     fprintf(fid2_out, '\n');
% end
% fclose(fid2_in);
% fclose(fid2_out);

%% 3. all (just output the result） no_word in test_doc
fid3_in = fopen(fall);
fid3_out = fopen([ftest, '.libfm'], 'w');

tline = fgetl(fid3_in);
str = regexp(tline, ' ', 'split');
ID = regexp(str{1}, '\|', 'split'); uID = str2num(ID{1}); vID = str2num(ID{2});

for u = 0:uCount-1
    for v = 0:vCount-1
        % 1. [u，v] --- positive
        if u == uID && v == vID
            fprintf(fid3_out, '1 %d:1 %d:1',u, v + uCount); % label/score id:value         
            index = two_ismember([u,v], test);
            % 1.1 not in test 
            if(sum(index) == 0) 
                for i = 3:size(str,2)
                    feature = regexp(str{i}, ':', 'split');
                    word = str2num(feature{1});
                    count = str2num(feature{2});
                    fprintf(fid3_out, ' %d:%d', word + uCount + vCount, count);
                end
            else % not all text
                for i = 3: min(size(str,2), 3)
                    feature = regexp(str{i}, ':', 'split');
                    word = str2num(feature{1});
                    count = str2num(feature{2});
                    fprintf(fid3_out, ' %d:%d', word + uCount + vCount, count);
                end
            end
            fprintf(fid3_out, '\n');

            % next positive
            tline = fgetl(fid3_in);
            if ischar(tline)
                str = regexp(tline, ' ', 'split');
                ID = regexp(str{1}, '\|', 'split'); uID = str2num(ID{1}); vID = str2num(ID{2});
            end
        % 2. [u，v] --- negative
        else
            fprintf(fid3_out, '0 %d:1 %d:1\n',u, v + uCount); 
        end          
    end
end
fclose(fid3_in);
fclose(fid3_out);



end





function negative = get_negative(positive)
% get full_matrix
n_user = max(positive(:,1)) + 1;
n_item = max(positive(:,2)) + 1;
index = 0:n_user*n_item-1; index = index';
full = [floor(index/n_item), mod(index, n_item)];

% get index = full == positive
index = two_ismember(full, positive);

% full=full-all
negative = full(~index,:);  % confirm_positive = full(index,:);
end


% two dimension ismember (both full and part start from 0)
function index = two_ismember(full, part)
% join id
max_value = max(full(:,2));
scale = 10^(ceil(log10(max_value)));
part_join = [part(:,1)*scale + part(:,2)];
full_join = [full(:,1)*scale + full(:,2)];

% get index
[index, loc] = ismember(full_join, part_join);
end


