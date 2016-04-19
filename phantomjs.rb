require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist
Capybara.run_server = false
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {js_errors: false})
end

module GetPrice
  class WebScraper
    include Capybara::DSL

    def get_detail(url)
      visit(url) 
      execute_script('window.scroll(0,100);') 
      execute_script('window.scroll(0,1000);')
      execute_script('window.scroll(0,10000);')
      execute_script('window.scroll(0,100000);')
      doc = Nokogiri::HTML(page.html)
      url_date = doc.css('span')
      title = doc.css('p strong')
      hasil = Array.new
      p = 2
      (0..title.length-1).each do |pos|
        hasil.push("#{pos+1} #{title[pos].text}")
        if pos == 0
           hasil.push(url_date[0].text)
           hasil.push(url_date[1].text)
        else
           hasil.push(url_date[p].text)
           hasil.push(url_date[p+1].text)
           p = p + 2
        end
      end
      return hasil
    end
  end
end

link = "http://gnews.id/keyword/42/politik"
scraper = GetPrice::WebScraper.new
puts scraper.get_detail(link)
#puts scraper.get_page_data(link).map(&:text).inspect
