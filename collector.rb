#!/usr/bin/env ruby

# See JMA terms of service:
# https://www.jma.go.jp/jma/kishou/info/coment.html

require 'open-uri'

JMA_FORECAST_INDEX_URI = 'https://www.jma.go.jp/jp/yoho/'.freeze
JMA_FORECAST_BASE_URI  = 'https://www.jma.go.jp/jp/yoho/'.freeze

def extract_prefecture_forecast_urls
  html = open(JMA_FORECAST_INDEX_URI).read
  html[/<form name="fukenlist">(.+)<\/form>/m, 1]
    .scan(/value="(\d+)"/)
    .map { |e| e[0] }
    .map { |fuken_id| "#{JMA_FORECAST_BASE_URI}#{fuken_id}.html" }
end

urls = extract_prefecture_forecast_urls

# urls.each { |url|
#   html = open(url).read
#   filename = "./html/#{url[/.+\/(.+)/, 1]}"
#   File.write(filename, html)
#   puts filename
# }
