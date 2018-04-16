# FOR Q1
create index superhost_idx on host(is_superhost);

# FOR Q2
create index name_idx on host(name);
create index amenity_name_idx on amenity(amenity_name);

# FOR Q3
create index neighborhood_idx on listing(neighborhood);

# FOR Q4
drop index amenity_name_idx;
create index amenity_name_idx on amenity(amenity_name);
create index listing_name_idx on listing(name);
drop index listing_name_idx;

# FOR Q5
drop index amenity_name_idx;
drop index superhost_idx;
create index amenity_name_idx on amenity(amenity_name);
create index superhost_idx on host(is_superhost);

# FOR Q6
create index date_available_idx on calendar(date, available);



