之前有的代码放在服务器，有的放在本地，搞得乱七八糟，在这里作一下整理
# 一、简介 #

* MovieLens 100k - Consists of 100,000 ratings from 1000 users on 1700 movies. （rating最少的user的评分个数是20。Movie最少的评分是1）
* MovieLens 1M - Consists of 1 million ratings from 6000 users on 4000 movies.
* MovieLens 10M - Consists of 10 million ratings and 100,000 tag applications applied to 10,000 movies by 72,000 users.


# Ratings Data File Structure #

All ratings are contained in the file ratings.dat. Each line of this file represents one rating of one movie by one user, and has the following format:

    UserID::MovieID::Rating::Timestamp

The lines within this file are ordered first by UserID, then, within user, by MovieID.
Ratings are made on a 5-star scale, with half-star increments.

Timestamps represent seconds since midnight Coordinated Universal Time (UTC) of January 1, 1970.

# Tags Data File Structure #

All tags are contained in the file tags.dat. Each line of this file represents one tag applied to one movie by one user, and has the following format:

    UserID::MovieID::Tag::Timestamp

The lines within this file are ordered first by UserID, then, within user, by MovieID.

Tags are user generated metadata about movies. Each tag is typically a single word, or short phrase. The meaning, value and purpose of a particular tag is determined by each user.

Timestamps represent seconds since midnight Coordinated Universal Time (UTC) of January 1, 1970.

-------

# 二、MovieLens 10M 的分析 #

This data set contains 10000054 ratings and 95580 tags applied to 10681 movies by 71567 users 。All users selected had rated at least 20 movies.




## 1.  movie分析 ##

* 最大的movieID 是65133，实际电影数10677
* 前第90部电影都等于其ID，第91部电影实际的ID是92
* 为什么实际有10677部电影，少了4部电影？？经过对比ratings.dat和movies.dat两个文件，发现movies.dat中的“25942::Louisiana Story (1948)::Drama”没有用户评分。另外三部电影就没有找了。
* user count per movie
* 竟然有很多电影没评分？？原因是，movie_ID本身就不是连续的，最大的movieID 是65133，实际电影数10677，因此会出现空档。
* 最少的评分记录是1次，有100部电影的评分数目是1
* 最高点是（256,34864），也就是movie_ID是296的电影，被评价过最多。（即296::Pulp Fiction (1994)::Comedy|Crime|Drama）

![user_count_per_movie1](raw/master/image/user_count_per_movie.png)
![user_count_per_movie2](raw/master/image/movierating-num-all.png)


## 2. user分析 ##
* 最大的userID是71567
* Rating.dat实际的user数目是69878,
* Movie count per user
* 71567用户的评分电影数目，user-id :account，x轴1:71567.
* 比如其中纵坐标最大的点是(59269,7359)，表示user59269总共对7359个评分记录，(不重复评分的话就等价于评分过7359部电影)。
* 纵轴最小的值（除0外）就是20，就是说用户至少有20个评分记录。
* X轴1:7357，最大点（7359，1），表示给7359个电影评分过的user只有一个。
* Y轴0：inf，最大（20,1902），表示给20部电影评分过的user有1902个
* 说明绝大多数的用户只评论了少部分电影，只有少部分用户评论了较多电影

![movie_count_per_user1](raw/master/image/movie_count_per_user.png)
![movie_count_per_user2](raw/master/image/userrating-num-all.png)

## 4. rating distribution ##

* 说明评分较多的是3，4分，总体来说更加偏向高分，也就是用户一般更倾向于对自己喜欢的电影进行评分。并计算得到平均评分是3.5124

![rating_distribution](raw/master/image/rating-distribution.png)


## tag分析 ##

* 有些user有tag没rating。有些user有rating没tag。
* 低分tag
* 高分tag

## 5. 待统计 ##
* 分时间段，一个movie在不同时间段的popular程度（是否被选择）变化，以及平均评分变化（是否被好评）情况。

-------

# 三、数据清洗 #
1.1. 4009个user有过标注，10677部电影中共7601个movie有过标注

1.2.做词典

tag做词典，单个word有意义，整个tag也有意义，因此这两者可以都考虑。但是当tag和word都考虑的时候，每个word和整个tag具有相同的重要性权重，因此如果存在tag的话，可以强化tag的权重，弱化word的权重。

1.3．做词典后，去除没有单词的user，movie，剩下3878个user，7545个movie； 对rating进行选取，剩余2250个user，7468个movie，885142个rating。

1.4 利用删减的user，movie重新做词典
剩余与user，movie相关的tag共55656个（见words.dat）。由于删掉的是tag文件中的行，同时user，movie的list也会减少。剩余2250个user，6238个movie，55656个tag

2.重新做文集
2250个user，6238个movie，859778个rating, 55656个tag。利用part 2.2:  get less tags 
更新tags.mat

2.1从Large数据集做小数据集，input：large文件夹数据，output：small文件夹数据集(Small_dataset.m)

2.2从Large数据集做小数据集，input：large文件夹数据，output：small文件夹数据集(Small_dataset.m)

去掉tag中的一些低频词(<5)，还剩19673个tag,1072个user，2202个movie（index2mat.mat）。

2,3,4之间通过依次调用Index2mat.m，small_dataset.m, java来实现的，最终得到数据集4
User：1033
User	Movie	Tag	Rating		
1033	1996	17552	323546