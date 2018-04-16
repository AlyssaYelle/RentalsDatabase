# Convert Host.response_rate to numeric type (remove % and update N/A to NULL)
# Split Host.location into 3 fields: Host.city, Host.state, Host.country
# remove Host.location


# create the new columns
alter table Host
add column city varchar,
add column state varchar,
add column country varchar;



# change data type for response_rate
update Host set response_rate = NULL where response_rate = 'N/A';
update Host set response_rate = split_part(response_rate::varchar(90), '%', 1);
update Host set response_rate = replace(response_rate::varchar(90), ',', '')::numeric;


# populate new columns
update host set city = split_part(location, ',', 1);
update host set state = split_part(location, ',', 2);
update host set country = split_part(location, ',', 3);

# drop location
alter table Host 
drop column location;

