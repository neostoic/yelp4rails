# Yelp4Rails
# - for working with the yelp api like its an active record model
#
# originated by Mike Heijmans
#
#   Apache License
#   Version 2.0, January 2004
#   http://www.apache.org/licenses/
#   Copyright 2013 Michael Heijmans

# Hack F*$#ery
$LOAD_PATH.concat(["#{Dir.pwd}/", "#{Dir.pwd}/lib"])
$LOAD_PATH.reverse!

# Define local lib base to override the installed version
# Without this, the installed libs will be loaded
# Thank you ruby for not providing load order... :-/ ~facepalm
$LIB_BASE_DIR = "#{Dir.pwd}"

# Require the libraries and test/unit
require 'test/unit'
require 'yaml'
require "#{$LIB_BASE_DIR}/lib/yelp4rails"

class YelpApiTest < Test::Unit::TestCase
  
  def setup
    yaml = YAML.load_file("#{$LIB_BASE_DIR}/test/fixture.yml")['api_keys']
    keys = {:consumer_key=>yaml['consumer_key'], 
            :consumer_secret=>yaml['consumer_secret'], 
            :token=>yaml['token'], 
            :token_secret=>yaml['token_secret']}
    @search = YelpApi.new(keys).search_by_location_and_term("95008", "bar")
    @bad_search = YelpApi.new(keys).search_by_term("bar")
  end
  
  
  def test_search_response
    assert_equal @search['businesses'].length, 20
    assert_equal @search['region']['center']['latitude'].to_i, 37
    assert_equal @search['region']['center']['longitude'].to_i, -121
    assert_equal @search['businesses'].first['rating'].class, Float
    assert_nil @search['error']
    assert_equal @bad_search['error']['id'], "UNSPECIFIED_LOCATION"
    assert_nil @bad_search['businesses']
  end
  
end