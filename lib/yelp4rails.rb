# Yelp4Rails
# - for working with the yelp api like its an active record model
#
# originated by Mike Heijmans
#
#   Apache License
#   Version 2.0, January 2004
#   http://www.apache.org/licenses/
#   Copyright 2013 Michael Heijmans
#
# Class for working with Yelp API
# Should resemble a database model as much as possible

require 'oauth'
require 'json'

class YelpApi
  
  attr_accessor :auth_keys, :consumer_key, :consumer_secret, :token, :token_secret, :base_url, :access_token
  attr_reader :yelp_client, :consumer
  
  def initialize(auth_keys)
    @consumer_key = auth_keys[:consumer_key]
    @consumer_secret = auth_keys[:consumer_secret]
    @token = auth_keys[:token]
    @token_secret = auth_keys[:token_secret]
    @base_url = "http://api.yelp.com"
    setup_consumer
    setup_access_token
  end
  
  def log(message, level=:info)
    if defined? Rails.logger
      if level == :info
        Rails.logger.info message
      elsif level == :error
        Rails.logger.error message
      end
    else
      puts "#{level}: #{message}"
    end
  end
  
  def setup_consumer
    @consumer = OAuth::Consumer.new(@consumer_key, @consumer_secret, :site=>@base_url)
  end
  
  def setup_access_token
    @access_token = OAuth::AccessToken.new(@consumer)
    @access_token.token = @token
    @access_token.secret = @token_secret
  end

  def find_by(params)
    if params.include? :business_id
      search_by_business_id(params[:business_id])
    else
      queryparams = []
      params.each do |key, value|
        queryparams << "#{key}=#{value.gsub(" ", "+")}"
      end
      uri = "/v2/search?#{queryparams.join("&")}"
      fetch_uri(uri)
    end
  end
  
  def fetch_uri(uri)
    log "Fetching from Yelp: #{uri}"
    result = @access_token.get(uri)
    return JSON.parse(result.body)
  end
  
  def search_by_business_id(bid)
    return fetch_uri("/v2/business/#{bid}")
  end
  
  
  # Make it model like ;)
  def method_missing(meth, *args, &block)
    if meth.to_s =~ /^search_by_(.+)$/
      run_search_by_method($1, *args, &block)
    else
      super # You *must* call super if you don't handle the
            # method, otherwise you'll mess up Ruby's method
            # lookup.
    end
  end
  
  def run_search_by_method(attrs, *args, &block)
    # Make an array of attribute names
    attrs = attrs.split('_and_')
    # #transpose will zip the two arrays together like so:
    #   [[:a, :b, :c], [1, 2, 3]].transpose
    #   # => [[:a, 1], [:b, 2], [:c, 3]]
    attrs_with_args = [attrs, args].transpose       
    queryparams=[]
    attrs_with_args.each do |key, value|
      queryparams << "#{key}=#{value.gsub(" ", "+")}"
    end       
    #{OAuth::Helper.escape(query)}
    uri = "/v2/search?#{queryparams.join("&")}"
    #puts uri       
    return fetch_uri(uri)
  end
end


