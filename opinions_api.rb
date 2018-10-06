require 'sinatra/base' 
require 'json'
require 'pry'
require './opinions_scraper.rb'

class OpinionsApi < Sinatra::Base 
  set :show_exceptions, :after_handler 
  
  post "/opinions" do 
    content_type :json
    urls = JSON.parse(request.body.read)["urls"]
    if urls.empty? 
      status 204
    else 
      status 200
      OpinionsScraper.scrapeSite(urls)
    end 
  end 

  error OpenURI::HTTPError do
    content_type :json
    status 404
    {:error =>"This URL could not be found"}.to_json 
  end 

  error Errno::ENOENT do 
    content_type :json
    status 400
    {:error => "Bad request: This URL is not properly formatted"}.to_json
  end 
end