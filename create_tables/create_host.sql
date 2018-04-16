# create new host table that stores distinct host records
# should contain the following fields from Listings table:
#	host_id
#	host_url
#	host_name
#	host_since
#	host_location
#	host_about
#	host_response_time
#	host_response_rate
#	host_acceptance_rate
#	host_is_superhost
#	host_thumbnail_url
#	host_picture_url
#	host_neighbourhood
#	host_listings_count
#	host_verifications
#	host_has_profile_pic
#	host_identity_verified
#	calculated_host_listings_count
# drop host_ from field names
# drop host fields other than host_id from Listings table
# make id PK
# Listings table should reference Host table via FK host_id


# create the Host table
create table Host 
as select distinct host_id as id, 
host_url as url, 
host_name as name,
host_since as since,
host_location as location,
host_about as about,
host_response_rate as response_rate,
host_response_time as response_time,
host_acceptance_rate as acceptance_rate,
host_is_superhost as is_superhost,
host_thumbnail_url as thumbnail_url,
host_picture_url as picture_url,
host_neighbourhood as neighborhood,
host_listings_count as listings_count,
host_verifications as verifications,
host_has_profile_pic as has_profile_pic,
host_identity_verified as identity_verified,
calculated_host_listings_count as calulated_listings_count
from Listing;

# make id the primary key
alter table Host add primary key(id);






















