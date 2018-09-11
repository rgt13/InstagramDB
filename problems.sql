--FIND THE 5 OLDEST USERS
SELECT * FROM users 
ORDER BY created_at ASC LIMIT 5;


--DAY OF THE WEEK IN WHICH MOST USERS REGISTERED
SELECT DAYNAME(created_at) as day_created, COUNT(DAYOFWEEK(created_at)) as amount 
FROM users 
GROUP BY day_created 
ORDER BY amount DESC;


--FIND USER WHO NEVER POSTED A PHOTO
SELECT username, photos.id 
FROM users 
LEFT JOIN photos ON users.id = photos.user_id 
WHERE photos.id IS NULL;


--FIND MOST LIKES ON SINGLE PHOTO
SELECT photos.image_url, username, photos.id, COUNT(likes.photo_id) as total_likes FROM photos
LEFT JOIN likes ON photos.id = likes.photo_id
INNER JOIN users ON users.id = photos.user_id
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 1;


--FIND HOW MANY TIMES AVERAGE USER POSTS
SELECT  (SELECT COUNT(*) 
            FROM photos) / (SELECT COUNT(*) 
                                FROM users) as avg_posts;
                                
                                

--FIND MOST COMMON HASHTAGS
SELECT tags.id, tags.tag_name, COUNT(photo_tags.tag_id) as num_times_used FROM tags
INNER JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY num_times_used DESC
LIMIT 5;


--FIND USERS WHO'VE LIKED EVERY PHOTO ON THE SITE
SELECT username, COUNT(likes.user_id) AS likes_num FROM users
LEFT JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING likes_num = (SELECT COUNT(*) FROM photos);

