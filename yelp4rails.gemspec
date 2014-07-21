Gem::Specification.new do |s|
  s.name        = 'yelp4rails'
  s.version     = '2.0.0'
  s.date        = '2013-09-04'
  s.summary     = "A gem that provides and activerecord like object for interacting with the yelp V2 api"
  s.description = "A gem that provides and activerecord like object for interacting with the yelp V2 api"
  s.authors     = ["Michael Heijmans"]
  s.email       = 'parabuzzle@gmail.com'
  s.files       = ["lib/yelp4rails.rb"]
  s.homepage    = "https://github.com/parabuzzle/yelp4rails"
  s.add_dependency('json')
  s.add_dependency('oauth', '>= 0.4.7')
end