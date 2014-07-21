yelp4rails
==========
[![Gem Version](https://badge.fury.io/rb/yelp4rails.png)](http://badge.fury.io/rb/yelp4rails)
[![Build Status](https://travis-ci.org/parabuzzle/yelp4rails.png?branch=master)](https://travis-ci.org/parabuzzle/yelp4rails)

A gem that provides and ActiveRecord like object for interacting with the yelp V2 api

Why Yelp4Rails?
---
Because working with an api should be no different that working with a database.

NOTICE!
---
Version 2 now supports the new Rails 4 style of query using the ```find_by(params_hash)``` method. This version is
backward compatible with Version 1.x.x but future versions will drop the ```search_by_term_and_location(:term, :location)```
meta programming style methods handling. 


**Consider Yourself Warned!**


Usage
---
	require 'yelp4rails'
	
	keys = {consumer_key: 'key', consumer_secret: 'secret', token: 'token', token_secret: 'tsecret'}
	yelp = YelpApi.new(keys)
	
	## Search like its an active record model ##
		
	#search with term and location
	yelp.find_by(term: 'bar', location: 'San Francisco, CA')
	
	#search with term, location, and sort
	yelp.find_by(term: 'restaurant', location: 'San Francisco, CA', sort: '2')
	
	#search by business id
	yelp.find_by(business_id: 123)
	
	... you get the idea ;)
	

supported search_by queries
---
 * key, value, required?
 * term, string, optional
 * limit, number, optional
 * offset, number, optional
 * sort, string, optional
   * Sort mode: 0=Best matched (default), 1=Distance, 2=Highest Rated.
 * category_filter, string, optional
 * radius_filter, number, optional
 * deals_filter, bool, optional  

