yelp4rails
==========

A gem that provides and ActiveRecord like object for interacting with the yelp V2 api

Usage
---
	require 'yelp4rails'
	
	keys = {:consumer_key=>"key", :consumer_secret=>"secret", :token=>"token", :token_secret=>"tsecret"}
	yelp = YelpApi.new(keys)
	
	## Search like its an active record model ##
	
	#search by term
	yelp.search_by_term("restaurant")
	
	#search with term and location
	yelp.search_by_term_and_location("bar", "San Francisco, CA")
	
	#search with term, location, and sort
	yelp.search_by_term_and_location_and_sort("restaurant", "San Francisco, CA", "2")
	
	#search by business id
	yelp.search_by_business_id(123)
	
	... you get the idea ;)
	

supported search_by queries
---
# key, value, required?
# term, string, optional
# limit, number, optional
# offset, number, optional
# sort, string, optional
## Sort mode: 0=Best matched (default), 1=Distance, 2=Highest Rated.
# category_filter, string, optional
# radius_filter, number, optional
# deals_filter, bool, optional  

