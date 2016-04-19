require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.app_host = "http://gnews.id"
Capybara.register_driver :selenium_firefox do |app|
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 0 # <= Page Load Timeout value in seconds
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :http_client => client)
end


module MyCapybara
  class Crawler
    include Capybara::DSL
    def query
      visit("/keyword/42/politik?filter=ahok")
      pos_up = 100
      pos_bottom = 100
      times = 20

      (0..times).each do |a|
        execute_script('window.scroll(0,100000);')
        sleep(inspection_time=5) 
        execute_script('window.scroll(100,0);')
        pos_bottom = pos_bottom*2
        sleep(inspection_time=2)
        puts "putaran ke #{a+1}" 
      end
      puts "selesai"
      sleep(inspection_time=500)
      return "ok"
    end
  end
end

crawler = MyCapybara::Crawler.new
item = crawler.query()

