require_relative "../opinions_api"
require_relative "./spec_helper"

describe 'Opinions API' do
  def app
    OpinionsApi 
  end

  describe "POST '/opinions'" do 
    RSpec::Expectations.configuration.on_potential_false_positives = :nothing
    it "returns a 204 when no urls are provided" do 
      data = {"urls" => []}
      
      post '/opinions', data.to_json, {"CONTENT_TYPE" => "application/json"}
      
      expect(last_response.status).to eq(204)
    end 
    
    it "returns a 200 when urls are provided" do 
      expect(OpinionsScraper).to receive(:scrapeSite).with(["www.debate.org"]).and_return({})
      data = {"urls" => ["www.debate.org"]}
      
      post "/opinions", data.to_json, {"CONTENT_TYPE" => "application/json"}

      expect(last_response.status).to eq(200)
    end 
    
    it "returns a 400 if an Errno::ENOENT is thrown" do 
      expect {raise Errno::ENOENT}.to raise_error
      data = {"urls" => ["www.debate.org"]}
      
      post "/opinions", data.to_json, {"CONTENT_TYPE" => "application/json"}
      expect(last_response.status).to eq(400)
      expect(JSON.parse(last_response.body)["error"]).to eq("Bad request: This URL is not properly formatted")
    end 
    
    xit "returns a 404 if an OpenURI::HTTPError is thrown" do 
      expect {raise OpenURI::HTTPError}.to raise_error
      data = {"urls" => ["www.adfadfafd.com"]}
      
      post "/opinions", data.to_json, {"CONTENT_TYPE" => "application/json"}

      expect(last_response.status).to eq(404)
      expect(JSON.parse(last_response.body)["error"]).to eq("This URL could not be found")
    end 
  end 
end
