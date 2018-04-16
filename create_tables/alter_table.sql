alter table Reviews add foreign key 
(listing_id) references Listings(id);
alter table Reviews add foreign key
(listing_id) references Listings(id);
alter table Calendar add foreign key
(listing_id) references Listings(id);
alter table Summary_reviews add foreign key
(listing_id) references Listings(id);
alter table Listings add foreign key
(neighbourhood_cleansed) references Neighbourhoods(neighbourhood);