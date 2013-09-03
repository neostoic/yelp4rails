# Class for working with Yelp API
# Should resemble a database model as much as possible
#
# Michael Heijmans 09/03/2013

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
  
  def setup_consumer
    @consumer = OAuth::Consumer.new(@consumer_key, @consumer_secret, :site=>@base_url)
  end
  
  def setup_access_token
    @access_token = OAuth::AccessToken.new(@consumer)
    @access_token.token = @token
    @access_token.secret = @token_secret
  end
  
  def fetch_uri(uri)
    Rails.logger.info "Fetching from Yelp: #{uri}"
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


