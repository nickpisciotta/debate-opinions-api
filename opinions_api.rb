require 'sinatra/base' 
require 'json'
require './opinions_scraper.rb'

class OpinionsApi < Sinatra::Base
  post "/" do 
    content_type :json
    urls = JSON.parse(request.body.read)["urls"]
    if urls.empty? 
      status 422
    else 
      status 200
    end 
  end 
end