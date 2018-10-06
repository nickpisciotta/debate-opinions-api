require 'open-uri'
require 'nokogiri'
require 'json'

module OpinionsScraper
    def self.scrapeSite(urls)
        urls.map do |url| 
            doc = Nokogiri::HTML(open(url))
            final_debate = Hash.new
            final_debate[:title] = doc.search('.q-title').text
            final_debate[:percentage_yes] = doc.search('.yes-text').text.split()[0]
            final_debate[:percentage_no] = doc.search('.no-text').text.split()[0]
            all_opinions = doc.search('#debate li.hasData')
            opinions = []
            all_opinions.each do |opinion| 
                opinions.push(
                    comment: opinion.search('h2').text.strip() + " " + opinion.search('p').text.strip(),
                    author: opinion.search('cite a').text
                    )
                end
            final_debate[:opinons] = opinions 
            final_debate[:total_opinions] = all_opinions.count
            final_debate[:related_topics] = doc.search('.related-opinion-page li').map do |opinion| 
                opinion.text 
            end 
        
            final_debate
        end.to_json
    end 
end 

#Try and handle any exceptions that may arise

#API tests 

