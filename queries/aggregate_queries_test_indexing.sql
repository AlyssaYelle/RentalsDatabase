# AGGREGATE QUERIES FOR INDEXING


# QUERY 1
# return listing name with its host response rate
# do not drop any null values
# order by response rate
explain analyze
select l.zipcode, count(h.is_superhost)
from listing l join host h on l.host_id = h.id
where h.is_superhost = TRUE
group by l.zipcode
order by count(h.is_superhost) desc
limit 50;


# QUERY 2
# return the names of hosts and their neighborhoods
# if the host has a listing that offers breakfast as an amenity
# order by neighborhood
explain analyze
select l.neighborhood, count(h.name)
from host h join listing l on h.id = l.host_id
join amenity a on l.id = a.listing_id
where amenity_name = 'Breakfast'
group by l.neighborhood;

# QUERY 3
# count the number of listings for each neighborhood
explain analyze
select neighborhood, count(*)
from listing
where neighborhood is not NULL
group by neighborhood
having count(*) >= 100;

# QUERY 4
# select names of listings that offer more than 6 amenities
explain analyze
select l.name, count(a.amenity_name)
from amenity a join listing l on l.id = a.listing_id
group by l.name
having count(amenity_name) > 6;

# QUERY 5
# returns how many hosts offer breakfast based upon whether they are a superhost or not
explain analyze
select h.is_superhost, count(a.amenity_name)
from host h join listing l on h.id = l.host_id
join amenity a on l.id = a.listing_id
where amenity_name= 'Breakfast'
group by is_superhost;

# QUERY 6
# returns # listings available by date
explain analyze
select c.date, count(c.available)
from calendar c
where c.available = TRUE
group by c.date;
