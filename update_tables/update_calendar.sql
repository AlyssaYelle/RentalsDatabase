# convert Calendar.price to numeric type

update Calendar set price = split_part(price::varchar(20), '$', 2);
update Calendar set price = replace(price::varchar(20), ',', '')::numeric;