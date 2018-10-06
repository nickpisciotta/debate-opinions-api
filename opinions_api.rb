require 'sinatra/base' 
require 'json'
require 'pry'
require './opinions_scraper.rb'

class OpinionsApi < Sinatra::Base  
  post "/opinions" do 
    content_type :json
    urls = JSON.parse(request.body.read)["urls"]
    if urls.empty? 
      status 422
    else 
      status 200
      OpinionsScraper.scrapeSite(urls)
    end 
  end 
end