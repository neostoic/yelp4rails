# Tests the yelp api integration
# 
# Is this an integration of functional or unit test?


require 'test_helper'

class YelpApiTest < ActiveSupport::TestCase
  
  def setup
    @search = YelpApi.new.search_by_location_and_term("95008", "bar")
    @bad_search = YelpApi.new.search_by_term("bar")
  end
  
  
  def test_search_response
    assert_equal @search.businesses.length, 20
    assert_equal @search.region.center.latitude.to_i, 37
    assert_equal @search.region.center.longitude.to_i, -121
    assert_equal @search.businesses.first.rating.class, Float
    assert_nil @search['error']
    assert_equal @bad_search.error.id, "UNSPECIFIED_LOCATION"
    assert_nil @bad_search['businesses']
  end
  
end