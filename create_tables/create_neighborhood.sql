# Create a new Neighborhood table which stores
# distinct neighborhood and zip code pairs
# field neighborhood shoudl be renamed neighborhood_name in niehgborhood table
# records with NULL neighborhood_name should be deleted from table
# records with NULL zipcodes should be deleted from table
# PK combination of neighborhood_name and zipcode
# neighborhood_cleansed and neighborhood_group_cleansed should be removed from Listings 
# neighborhood_group should be removed from Summary_Listings table
# drop old Neighbourhoods table
# renamed field neighbourhood to neighborhood in Listings table
# Listings table should reference Niehgborhood on FK neighborhood and zipcode
# field neighbourhood should be renamed to zipcode in Summary_Listings table



# create the tables
# by selecting the neighbourhood and neighbourhood_cleansed fields in Listings
create table Neighborhood 
as select distinct neighbourhood as neighborhood_name, zipcode as zipcode 
from listing;

# delete NULL neighborhood_name
delete from Neighborhood where neighborhood_name is null;

# delete NULL zipcode
delete from Neighborhood where zipcode is null;

# joint primary key
alter table Neighborhood add primary key(neighborhood_name, zipcode);
















