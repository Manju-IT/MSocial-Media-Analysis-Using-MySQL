# SOCIAL MEDIA ANALYSIS 
-- Designed and implemented a MySQL-based social media analysis project, 
-- leveraging relational database capabilities to efficiently 
-- store, retrieve, and analyze extensive social media data. 
-- Developed features including user profiles, post storage, s
-- entiment analysis, and trend tracking to provide 
-- aluable insights into user behavior and trending topics. 
-- Demonstrated proficiency in database management for 
-- effective data organization and retrieval, showcasing 
-- a keen understanding of scalable and well-structured MySQL systems

use social_media;
select * from post;
select * from users;
select * from login ;
select * from comments;


#task 1 :- Display location of the user 
select distinct location from post;

# task 2 :- total post 
select count(*) from post;

# task 3 :-  total user from table 
select count(*) from users;
# there are 50 users 

-- TASK 4 :- avg per user post 
select round(count(post_id)/ 
count(distinct user_id)) as
avgpost from post;

# task 5  display the  user who posted 5 and more than 5 

select p1.user_id,username,count(*) AS more_than from post p1
inner join users u1
on p1.user_id=u1.user_id
group by user_ID  
HAVING more_than>=5;

# by using sub query 
SELECT username FROM users WHERE 
user_id IN (SELECT user_id FROM (SELECT user_id,count(*) AS total 
FROM post
GROUP BY user_id
HAVING total>=5) p1);


#by using with 
with cte as ( select user_id,count(*) as total from post 
group by user_id 
having total>=5)
select username,user_id from users where user_id in 
(select user_id from cte);

-- total 4 user are posted 5 or more than 5 post 

# task 6 I want user who have not posted any posted

select * from users
where user_id not in 
(select distinct user_id from post );


select * from users
where user_id not in 
(select distinct user_id from comments );

-- there is only one user raj gupta who havn't comment 


#display user who dont follow anyone 

select username,user_id from users
where user_id not in (select follower_id from follows);

# task 9  find inactive users

select * from users
where user_id not in 
(select distinct user_id from post );


# task 10 :- check for bot ,
-- user who commented on every post

#task 11 :- user who like every psot(bot)

use social_media;
#task 12 display most liked post 
select post_id,user_id,caption from post
 where post_id IN (SELECT post_id FROM (select post_id,count(*) as count_all from post_likes
group by post_id
order by count_all desc
limit 5) p1);


#task 12 

use social_media;
select username,count(*) as num_comments
from users u1
inner join comments c1 
on u1.user_id=c1.user_id
group by u1.user_id
order by num_comments desc
limit 1;


#TASK 13 FIND WHO LIKE EVERY POST 
 select username,count(*) as count_1
 from users u1 
 inner join post_likes p1
 on u1.user_id=p1.user_id
 group by u1.user_id
 having count_1=(select count(distinct post_id)from post_likes);
 
 select user_id ,username,created_at
 from users
 order by created_at
 limit 5;
 
#TASK 13
-- FIND LONGEST  CAPTION 
select user_id,length(caption) as len,caption from post
order by len desc
limit 1;


#TASK 14 FIND FOLLOWER IS ABOVE >40

SELECT followee_ID ,COUNT(FOLLOWER_ID) AS follow_count 
from follows
group by followee_id
having follow_count>40
order by 2 desc
limit 2;

#TASK 15 
-- find the most commonly use hastag 
 select h.hashtag_name ,count(h.hashtag_name) as count_hash,hashtag_name 
 from hashtags h
 inner join post_tags ph
 on h.hashtag_id=ph.hashtag_id
 group by h.hashtag_name
 order by count_hash desc 
 limit 5;
 
 select * from hashtag_follow;
 
 SELECT h.hashtag_name,
Count(h.hashtag_name) AS 'Most Followed hashtags'
FROM hashtags h
inner JOIN hashtag_follow ph
ON h.hashtag_id = ph.hashtag_id
GROUP BY h.hashtag_name
ORDER BY Count(h.hashtag_name) desc
LIMIT 5;
 
