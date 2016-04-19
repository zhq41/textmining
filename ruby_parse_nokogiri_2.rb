require 'nokogiri'
require 'rubygems'
require 'open-uri'
      
 doc = Nokogiri::HTML(open("http://localhost/sampleApp/coba.html"))
=begin
 url_date = doc.css('span')
 title = doc.css('p strong')
 hasil = Array.new
 p = 2
 (0..title.length-1).each do |pos|
   hasil.push("#{pos+1} #{title[pos].text}")
   if pos == 0
     #site
     hasil.push(url_date[0].text)
     #time
     hasil.push(url_date[1].text)
   else
     #title
     hasil.push(url_date[p].text)
     #deskripsi
     hasil.push(url_date[p+1].text)
     #link
     p = p + 2
   end
  end

  #title -> class card-main-> class card-action -> 
  puts hasil
=end

situs = doc.css("span[style='font-size: 13px;color: #4a4a4a;']")
time = doc.css("span[style='font-size: 11px;color: #b7b7b7;']")
link = doc.css("div[class='card-img waves-attach waves-effect'] a")
judul = doc.css("div[class='card-inner'] p strong")
desc = doc.css("div[class='card-inner'] p")

File.open("data.csv", "w+") do |f|
f << ["no","site","datetime","url","title","description"]
f << "\n"
 (0...situs.length). each do |no|
   site = situs[no].text
   #puts "site : #{site}"
   waktu = time[no].text
   #puts "time : #{waktu}"
   url = "http://gnews.id/#{link[no]['href']}"
   #puts "link : http://gnews.id#{url}"
   title = judul[no].text.gsub(/[^a-zA-Z0-9 -]/,'')
   #puts "title: #{title}"
   descr = desc[no].text.gsub(/[^a-zA-Z0-9 -]/,'')
   #puts "desc : #{descr[title.length..-4]}"
   f << [site, waktu, title, url, descr]
   f << "\n"
 end
end

