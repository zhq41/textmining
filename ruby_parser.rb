require 'nokogiri'
require 'rubygems'
require 'open-uri'
      
 doc = Nokogiri::HTML(open("http://localhost/sampleApp/coba.html"))
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

  puts hasil
