require 'open-uri'
require 'nokogiri'
require 'json'

module OpinionsScraper
    def self.scrapeSite(urls)
        urls.map do |url| 
            begin 
                build_opinion_response(url)    
            rescue OpenURI::HTTPError, Errno::ENOENT => e 
                raise e
            end 
        end.to_json
    end 

    def self.build_opinion_response(url) 
        page = open(url)
        doc = Nokogiri::HTML(page)
        all_opinions = doc.search('#debate li.hasData')
    
        debate_opinion = Hash.new
        debate_opinion[:title] = doc.search('.q-title').text
        debate_opinion[:percentage_yes] = doc.search('.yes-text').text.split()[0]
        debate_opinion[:percentage_no] = doc.search('.no-text').text.split()[0]
        debate_opinion[:opinions] = all_opinions.reduce([]) do |opinions, opinion| 
            opinions.push(
                comment: opinion.search('h2').text.strip() + " " + opinion.search('p').text.strip(),
                author: opinion.search('cite a').text
            )
        end 
        debate_opinion[:total_opinions] = all_opinions.count
        debate_opinion[:related_topics] = doc.search('.related-opinion-page li').map do |opinion| 
            opinion.text 
        end 

        debate_opinion
    end 

    private_class_method :build_opinion_response

end 
