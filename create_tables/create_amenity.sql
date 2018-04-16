# Listing.amenities unnested into new relation (listing_id, amenity_name)
# s.t. each amenity is stored individually with its associated listing id
# PK on Amenity.listing_id and Amenity.amenity_name
# FK on Amenity.listing_id
# Listing.amenities field removed


create table Amenity 
as select id as listing_id, 
unnest(string_to_array(amenities, ',')) as amenity_name
from Listing;

# add primary key
alter table Amenity add primary key(listing_id, amenity_name);

# add foreign key
alter table Amenity add foreign key(listing_id) references Listing(id);


alter table Listing
drop column amenities;