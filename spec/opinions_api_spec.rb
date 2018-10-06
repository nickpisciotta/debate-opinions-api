require_relative "../opinions_api"
require_relative "./spec_helper"

describe 'Opinions API' do
  def app
    OpinionsApi 
  end

  describe "POST '/opinions'" do 
    it "returns a 422 when no urls are provided" do 
      post = {"urls" => []}
      post '/opinions', post.to_json, {"CONTENT_TYPE" => "application/json"}
      
      expect(last_response.status).to eq(422)
    end 
    
    it "returns a 200 when urls are provided" do 
      expect(OpinionsScraper).to receive(:scrapeSite).with(["www.debate.org"]).and_return({})
      data = {"urls" => ["www.debate.org"]}
      post "/opinions", data.to_json, {"CONTENT_TYPE" => "application/json"}

      expect(last_response.status).to eq(200)
    end     
  end 
end
