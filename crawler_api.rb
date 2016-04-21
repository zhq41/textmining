require 'nokogiri'
require 'rubygems'
require 'open-uri'
require 'json'
require 'net/http' 
 
offset = 10 
url = "http://gnews.id/api/article?keywordId=42&keyword=ahok&limit=20&offset="
no = 1
times = 50
#source = 'http://localhost:3000/qwerty/give_json.json'
(offset..times).each do |a|
  b = url+"#{offset}"
  resp = Net::HTTP.get_response(URI.parse(url))
  fJson = File.open("file#{no}.json","w")
  fJson.write(resp)
  fJson.close
  puts "ok for #{no}"
  offset = offset+20
  no=no+1
end
 
