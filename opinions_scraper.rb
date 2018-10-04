require 'open-uri'
require 'nokogiri'
require 'json'

module OpionionsScraper
    def self.scrapeSite(urls)
        urls.map do |url| 
            doc = Nokogiri::HTML(open(url))

            opinion_title = doc.search('.q-title').text
            percentage_yes = doc.search('.yes-text').text.split()[0]
            percentage_no = doc.search('.no-text').text.split()[0]
            all_opinions = doc.search('#debate li.hasData')

            opinions = []
            all_opinions.map do |opinion| 
                opinions.push(
                    comment: opinion.search('h2').text.strip() + " " + opinion.search('p').text.strip(),
                    author: opinion.search('cite a').text
                )
            end

            number_of_comments = all_opinions.count
            related_opinions = doc.search('.related-opinion-page li').map do |opinion| 
                opinion.text 
            end 

            final_debate = {
                title: opinion_title,
                percentage_yes: percentage_yes,
                percentage_no: percentage_no,
                opinions: opinions,
                total_opinions: number_of_comments,
                related_topics: related_opinions
            }
        end.to_json
    end 
end 

#Try and handle any exceptions that may arise

#API tests 

