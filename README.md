之前有的代码放在服务器，有的放在本地，搞得乱七八糟，在这里作一下整理
# 简介 #

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


# MovieLens 10M 的分析 #

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
![user_count_per_movie2](raw/master/image/user_count_per_movie_statistic.png)
![user_count_per_movie3](raw/master/image/user_count_per_movie_statistic_log.png)

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

![movie_count_per_user](raw/master/image/movie_count_per_user.png)
![movie_count_per_user2](raw/master/image/movie_count_per_user_statistic.png)
![movie_count_per_user3](raw/master/image/movie_count_per_user_statistic_loglog.jpg)

## 4. rating distribution ##

* 说明评分较多的是3，4分，总体来说更加偏向高分，也就是用户一般更倾向于对自己喜欢的电影进行评分。并计算得到平均评分是3.5124

![rating_distribution](raw/master/image/rating_distribution.png)

## tag分析 ##

有些user有tag没rating。有些user有rating没tag。