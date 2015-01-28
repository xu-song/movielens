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
最大的movieID 是65133，实际电影数10677
前第90部电影都等于其ID，第91部电影实际的ID是92
为什么实际有10677部电影，少了4部电影？？经过对比ratings.dat和movies.dat两个文件，发现movies.dat中的“25942::Louisiana Story (1948)::Drama”没有用户评分。另外三部电影就没有找了。

## 2. user分析 ##
最大的userID是71567，
Rating.dat实际的user数目是69878,
Tags.dat 
有些user有tag没rating。有些user有rating没tag。

![default_128.jpg](https://bitbucket.org/repo/nAExB5/images/3132788616-default_128.jpg)

![图片2.jpg](https://bitbucket.org/repo/nAExB5/images/3014536092-%E5%9B%BE%E7%89%872.jpg)
