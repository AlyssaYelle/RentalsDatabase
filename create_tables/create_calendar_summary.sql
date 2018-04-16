# create a new Calendar_Summary table that summarizes 
# the availability of a listing over 30,60,90 days
# should contain following fields from Listings table:
#	id
#	calendar_updated
#	calendar_last_scraped
#	availability_30
#	availability_60
#	availability_90
# id field should be renamed listing_id
# calendar_last_scraped should be renamed from_date
# PK should be combination of listing_id and from_date
# should reference the Listings table via the FK listing_id
# drop copied fields from Listings table (except listing_id)




# create Calendar_Summary table
create table Calendar_Summary 
as select id as listing_id, 
calendar_updated as calendar_updated,
calendar_last_scraped as from_date,
availability_30 as availability_30,
availability_60 as availability_60,
availability_90 as availability_90 
from Listing;

# add primary key
alter table Calendar_Summary add primary key(listing_id, from_date);

# add foreign key
alter table Calendar_Summary add foreign key(listing_id) references Listing(id);























