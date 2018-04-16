#simple SQL queries to explore airbnb database

# QUERY 1
#find all listings (their names and prices) in [78702] 
#sort by price

select l.name, l.price
from Listings l join Neighbourhoods n on l.neighbourhood_cleansed = n.neighbourhood
where n.neighbourhood = '78702'
order by l.price;

# QUERY 2
#select distinct dates that have an available listing in [78702]
#order by date

select distinct c.date
from Calendar c join Listings l on c.listing_id = l.id 
where l.neighbourhood_cleansed = '78702' and c.available = 'TRUE'
order by c.date;

# QUERY 3
#select everything in summary reviews

select *
from Summary_reviews;

# QUERY 4
#select all listings and their entire summary that are located in the 78701 neighbourhood
#order by host's id
#limit to 30

select *
from Summary_listings sl right outer join Neighbourhoods n on sl.neighbourhood = n.neighbourhood
where n.neighbourhood = '78701'
order by sl.host_id
limit 30;

# QUERY 5
#select reviewers, their comments, and the listings they commented on in the 78702 neighbourhood
#take only the first 30
#ordered by reviewer name

select r.reviewer_name, r.comments, l.name
from Reviews r left outer join Listings l on r.listing_id = l.id
where l.neighbourhood_cleansed = '78702'
order by r.reviewer_name
limit 30;


# QUERY 6
#select first 50 listings, ordered by name, that have no reviews
#return their name, neighbourhood, and price

select l.name, l.neighbourhood_cleansed, l.price
from Listings l left join Reviews r on l.id = r.listing_id
where r.listing_id is null 
order by l.name
limit 50;

# QUERY 7
#select all from Summary_Listings table in the 78705 neighbourhood
#return only first 50, sorted by price
select * 
from Summary_listings sl join Neighbourhoods n on sl.neighbourhood = n.neighbourhood
where n.neighbourhood = '78705'
order by sl.name
limit 50;


# QUERY 8
#select house rules from listings in the 78702 neighbourhood
#where house rules entity is not null
select l.house_rules
from Listings l join Neighbourhoods n on l.neighbourhood_cleansed = n.neighbourhood
where n.neighbourhood = '78702' and l.house_rules is not null;



# QUERY 9
#select dates that have an avaiable listing where the host is a superhost
#order by price
#return date, listing name, listing price, host id

select c.date, l.name, l.price, l.host_id
from Calendar c join Listings l on c.listing_id = l.id
where l.host_is_superhost = 'TRUE'
order by price;


# QUERY 10
#select listings available within a range of dates
#return first 20 ordered by date
SELECT ls.name, cl.date
FROM listings ls 
JOIN calendar cl ON ls.id = cl.listing_id
WHERE cl.available = 'TRUE' and cl.date BETWEEN '2017-11-21' AND '2017-12-31'
ORDER BY ls.name
LIMIT 20;


# QUERY 11
#look for reviewers named Michael who have reviewed airbnb locations
#return listing name and comments

SELECT ls.name, rev.comments
FROM listings ls
JOIN Reviews rev ON ls.id = rev.listing_id
WHERE rev.reviewer_name = 'Michael'
LIMIT 20;



# QUERY 12
#find listings with no reviews

SELECT ls.name
FROM listings ls 
LEFT OUTER JOIN Reviews rev on rev.listing_id = ls.id
WHERE rev.listing_id is null
LIMIT 10;


















