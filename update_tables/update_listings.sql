# city, state, zip, and country values should be removed from street field
# remove dollar signs and commas from fields
#	price
#	weekly_price
#	monthly_price
#	security_deposit
#	cleaning_fee
# convert data type from price/fee fields from varchar to numeric

alter table listings rename to listing;
alter table summary_listings rename to summary_listing;

update Listing set price = split_part(price::varchar(90), '$', 2);
update Listing set price = replace(price::varchar(90), ',', '')::numeric;
update Listing set weekly_price = split_part(price::varchar(90), '$', 2);
update Listing set weekly_price = replace(price::varchar(90), ',', '')::numeric;
update Listing set monthly_price = split_part(price::varchar(90), '$', 2);
update Listing set monthly_price = replace(price::varchar(90), ',', '')::numeric;
update Listing set security_deposit = split_part(price::varchar(90), '$', 2);
update Listing set security_deposit = replace(price::varchar(90), ',', '')::numeric;
update Listing set cleaning_fee = split_part(price::varchar(90), '$', 2);
update Listing set cleaning_fee = replace(price::varchar(90), ',', '')::numeric;

update Listing set street = split_part(street::varchar(90), ',',1);

alter table Listing 
drop column host_url,
drop column host_name,
drop column host_since,
drop column host_location,
drop column host_about,
drop column host_response_time,
drop column host_response_rate,
drop column host_acceptance_rate,
drop column host_is_superhost,
drop column host_thumbnail_url,
drop column host_picture_url,
drop column host_neighbourhood,
drop column host_listings_count,
drop column host_verifications,
drop column host_has_profile_pic,
drop column host_identity_verified;


alter table Listing
drop column calendar_updated,
drop column calendar_last_scraped,
drop column availability_30,
drop column availability_60,
drop column availability_90;

alter table listing rename column neighbourhood to neighborhood;
alter table summary_listing rename column neighbourhood to zipcode;



alter table listing add foreign key(host_id) references host(id);
alter table listing add foreign key(neighbourhood,zipcode) references neighborhood(neighborhood_name,zipcode);
























