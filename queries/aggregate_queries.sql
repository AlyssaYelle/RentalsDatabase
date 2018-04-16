# six aggregate queries that satisfy:
# 3 have join, at least one outer join
# 2 queries have a having clause
# 2 queries have a where clause
# 2 queries have an order by clause
# span at least 5 tables


# QUERY 1
# return listing name with its host response rate
# do not drop any null values
# order by response rate
select l.zipcode, count(h.is_superhost)
from listing l join host h on l.host_id = h.id
where h.is_superhost = TRUE
group by l.zipcode
order by count(h.is_superhost) desc
limit 50;


# QUERY 2
# return the names of listings that offer breakfast as an amenity
select l.name, l.neighborhood
from listing l join amenity a on l.id = a.listing_id
where amenity_name = 'Breakfast' and neighborhood is not NULL;


# QUERY 3
# return the names of hosts and their neighborhoods
# if the host has a listing that offers breakfast as an amenity
# order by neighborhood
select l.neighborhood, count(h.name)
from host h join listing l on h.id = l.host_id
join amenity a on l.id = a.listing_id
where amenity_name = 'Breakfast'
group by l.neighborhood
limit 20;

# QUERY 4
# count the number of listings for each neighborhood
select neighborhood, count(*)
from listing
where neighborhood is not NULL
group by neighborhood
having count(*) >= 100;

# QUERY 5
# select names of listings that offer more than 6 amenities
select l.name, count(a.amenity_name)
from amenity a join listing l on l.id = a.listing_id
group by l.name
having count(amenity_name) > 6
limit 10;

# QUERY 6
# select the max price for each neighborhood name
# where there is an available listing between 21 nov 2017 and 31 dec 2017
# ignore nulls
select neighborhood_name, MAX(c.price)
from calendar c join listing l on c.listing_id = l.id
join neighborhood n on l.neighborhood = n.neighborhood_name
where c.date BETWEEN '2017-11-21' AND '2017-12-31'
and c.price is not null
group by neighborhood_name
limit 20;


select h.is_superhost, count(a.amenity_name)
from host h join listing l on h.id = l.host_id
join amenity a on l.id = a.listing_id
where amenity_name= 'Breakfast'
group by is_superhost;

select c.date, count(c.available)
from calendar c
where c.available = TRUE
group by c.date;
