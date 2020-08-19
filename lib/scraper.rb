require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

     scraped_students = []

    doc.css(".student-card").each do |student|
      scraped_students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: "#{student.css("a").attribute("href").value}"
      }
    end
    scraped_students
  end


  def self.scrape_profile_page(profile_url)
    
    doc = Nokogiri::HTML(open(profile_url))
  #   scraped_student = {}

  #   doc.css(".social-icon-container a").each do |link|
  #     normalized_link = link.attribute("href").text

  #     scraped_student[:twitter] = normalized_link if normalized_link.include?("twitter")
  #     scraped_student[:linkedin] = normalized_link if normalized_link.include?("linkedin")
  #     scraped_student[:github] = normalized_link if normalized_link.include?("github")
  #     scraped_student[:blog] = normalized_link if link.css("img").attribute("src").text.include?("rss")
  #   end

  #   scraped_student[:profile_quote] = doc.css(".profile-quote").text
  #   scraped_student[:bio] = doc.css("bio-content .description-holder p").text

  #   scraped_student
  
  # end


social_icons = doc.css("div.social-icon-container a").collect {|x| x.attribute("href").value}
    social_icons.each do |social_icon|
      if social_icon.include?("linkedin")
        student[:linkedin] = social_icon
      elsif social_icon.include?("github")
        student[:github] = social_icon
      elsif social_icon.include?("twitter")
        student[:twitter] = social_icon
      else
        student[:blog] = social_icon
      end
    end
    # if doc.css("div.bio-content.content-holder div.description-holder p")
      student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text
    # end
    # if doc.css(".profile-quote")
      student[:profile_quote] = doc.css(".profile-quote").text
    # end
    student
  end
end

