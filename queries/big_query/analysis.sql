# SUMMARY
# i had a vision that involved cool maps
# and also cool time series charts
# and it doesn't look like data studio can do what i wanted it to do??
# i might just be using it incorrectly though
# below are the SQL queries that i used to try to turn my vision into cool charts


# just the total number of listings for each city
select 'Austin' as city, count(id)
from austin.Listing
UNION ALL
select 'Portland' as city, count(id)
from portland.Listing
UNION ALL
select 'Nashville' as city, count(id)
from nashville.Listing;

# and on a similar yet more breakfasty note, 
# the total number of listings offering breakfast for each city
select 'Austin' as city, count(amenity_name) from austin.Amenity where amenity_name = 'Breakfast'
UNION ALL
select 'Portland' as city, count(amenity_name) from portland.Amenity where amenity_name = 'Breakfast'
UNION ALL
select 'Nashville' as city, count(amenity_name) from nashville.Amenity where amenity_name = 'Breakfast';

# all listings available in each city grouped by date
# i did not use this query or the one below in my charts 
# because i'm having trouble with the time series
# i just want to combine multiple time series into one chart!
# i can do that in matplotlib but can't figure it out in data studio :(
select 'Austin' as city, date, count(available) from austin.Calendar
where available = True
group by date
UNION ALL
select 'Portland' as city, date, count(available) from portland.Calendar
where available = True
group by date
UNION ALL
select 'Nashville' as city, date, count(available) from nashville.Calendar
where available = True
group by date;

# and those that have been booked
# see note above
select 'Austin' as city, date, count(available) from austin.Calendar
where available = False
group by date
UNION ALL
select 'Portland' as city, date, count(available) from portland.Calendar
where available = False
group by date
UNION ALL
select 'Nashville' as city, date, count(available) from nashville.Calendar
where available = False
group by date;

# on a related yet more breakfast themed note
# available listings offering breakfast as an amenity
# for each city, grouped by date
select 'Austin' as city, date, count(available) from austin.Calendar aC
join austin.Listing aL on aC.listing_id = aL.id
join austin.Amenity aA on aL.id = aA.listing_id
where available = True
and amenity_name = 'Breakfast'
group by date
UNION ALL
select 'Portland' as city, date, count(available) from portland.Calendar pC
join portland.Listing pL on pC.listing_id = pL.id
join portland.Amenity pA on pL.id = pA.listing_id
where available = True
and amenity_name = 'Breakfast'
group by date
UNION ALL
select 'Nashville' as city, date, count(available) from nashville.Calendar nC
join nashville.Listing nL on nC.listing_id = nL.id
join nashville.Amenity nA on nL.id = nA.listing_id
where available = True
and amenity_name = 'Breakfast'
group by date;

# and those breakfasty listings that have been booked
select 'Austin' as city, date, count(available) from austin.Calendar aC
join austin.Listing aL on aC.listing_id = aL.id
join austin.Amenity aA on aL.id = aA.listing_id
where available = False
and amenity_name = 'Breakfast'
group by date
UNION ALL
select 'Portland' as city, date, count(available) from portland.Calendar pC
join portland.Listing pL on pC.listing_id = pL.id
join portland.Amenity pA on pL.id = pA.listing_id
where available = False
and amenity_name = 'Breakfast'
group by date
UNION ALL
select 'Nashville' as city, date, count(available) from nashville.Calendar nC
join nashville.Listing nL on nC.listing_id = nL.id
join nashville.Amenity nA on nL.id = nA.listing_id
where available = False
and amenity_name = 'Breakfast'
group by date;

# i really wanted to use the Geo chart to make cool maps
# and look for clustering of breakfast listings
# this didn't work out how i wanted but i'm leaving the charts/queries in
# and considering it a learning experience
# i thought the maps would be interactive so i could zoom in more
# but basically there's no way to zoom in closer than 'state' level

# austin
select concat(cast(latitude as string), ',', cast(longitude as string)) as location
from austin.Listing aL join austin.Amenity aA on aL.id = aA.listing_id
where amenity_name = 'Breakfast';

# portland
select concat(cast(latitude as string), ',', cast(longitude as string)) as location
from portland.Listing pL join portland.Amenity pA on pL.id = pA.listing_id
where amenity_name = 'Breakfast';

# nashville
select concat(cast(latitude as string), ',', cast(longitude as string)) as location
from nashville.Listing nL join nashville.Amenity nA on nL.id = nA.listing_id
where amenity_name = 'Breakfast';

# number superhosts by city
select 'Austin' as city, count(id)
from austin.Host
where is_superhost = True
group by city
UNION ALL
select 'Nashville' as city, count(id)
from nashville.Host
where is_superhost = True
group by city
UNION ALL
select 'Portland' as city, count(id)
from portland.Host
where is_superhost = True
group by city;

# number superhosts offering breakfast by city
select 'Austin' as city, count(aH.id)
from austin.Host aH
join austin.Listing aL on aH.id = aL.host_id
join austin.Amenity aA on aL.id = aA.listing_id
where is_superhost = True
and amenity_name = 'Breakfast'
group by city
UNION ALL
select 'Nashville' as city, count(nH.id)
from nashville.Host nH
join nashville.Listing nL on nH.id = nL.host_id
join nashville.Amenity nA on nL.id = nA.listing_id
where is_superhost = True
and amenity_name = 'Breakfast'
group by city
UNION ALL
select 'Portland' as city, count(pH.id)
from portland.Host pH
join portland.Listing pL on pH.id = pL.host_id
join portland.Amenity pA on pL.id = pA.listing_id
where is_superhost = True
and amenity_name = 'Breakfast'
group by city;

# in portland 23.7% of superhosts offer breakfast
# in nashville 32.2% of superhosts offer breakfast
# in austin 14.2% of superhosts offer breakfast

