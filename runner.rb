#!/usr/bin/env ruby

require './parser.rb'

loop {
  print "天気予報を入力: "
  forecast = STDIN.readline
  puts "解析結果:"
  pp JmaForecastParser.parse(forecast)
  puts
}

