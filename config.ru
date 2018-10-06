require 'sinatra' 
require_relative './opinions_api.rb' 

class OpinionsApi <  Sinatra::Base
    configure do
      set :raise_errors, true
      set :show_exceptions, true
      set :show_exceptions, :after_handler 
    end
end 

run OpinionsApi
