require 'minitest/autorun'
require './parser.rb'

# The weather forecasts used in the tests
# were previously announced by the Japan Meteorological Agency.
class TestParser < MiniTest::Unit::TestCase
  def validate(input, expected)
    assert_equal expected, JmaForecastParser.parse(input)
  end

  def test_1
    validate(
      '北の風　２３区西部　では　北の風　やや強く　雨',
      {:wind=>"北の風　２３区西部　では　北の風　やや強く",
       :weather=>
       {0=>"雨", 3=>"雨", 6=>"雨", 9=>"雨", 12=>"雨", 15=>"雨", 18=>"雨", 21=>"雨"}}
    )
  end

  def test_2
    validate(
      '北の風　後　南の風　２３区西部　では　南の風　やや強く　雨　昼前　から　くもり　所により　明け方　から　朝　雷を伴い　激しく　降る',
      {:wind=>"北の風　後　南の風　２３区西部　では　南の風　やや強く",
       :weather=>
       {0=>"雨",
        3=>"雨所により雷を伴い激しく降る",
        6=>"雨所により雷を伴い激しく降る",
        9=>"くもり",
        12=>"くもり",
        15=>"くもり",
        18=>"くもり",
        21=>"くもり"}}
    )
  end

  def test_3
    validate(
      '北東の風　やや強く　くもり　夜　雨　所により　夜遅く　雷　を伴う',
      {:wind=>"北東の風　やや強く",
       :weather=>
       {0=>"くもり",
        3=>"くもり",
        6=>"くもり",
        9=>"くもり",
        12=>"くもり",
        15=>"くもり",
        18=>"雨",
        21=>"雨所により雷を伴う"}}
    )
  end

  def test_4
    validate(
      '北東の風　後　北の風　海上　では　南の風　やや強く　くもり　時々　雨　所により　昼前　から　昼過ぎ　雷を伴い　激しく　降る',
      {:wind=>"北東の風　後　北の風　海上　では　南の風　やや強く",
       :weather=>
       {0=>"くもり時々雨",
        3=>"くもり時々雨",
        6=>"くもり時々雨",
        9=>"くもり時々雨所により雷を伴い激しく降る",
        12=>"くもり時々雨所により雷を伴い激しく降る",
        15=>"くもり時々雨",
        18=>"くもり時々雨",
        21=>"くもり時々雨"}}
    )
  end

  def test_5
    validate(
      '北の風　晴れ',
      {:wind=>"北の風",
       :weather=>
       {0=>"晴れ", 3=>"晴れ", 6=>"晴れ", 9=>"晴れ", 12=>"晴れ", 15=>"晴れ", 18=>"晴れ", 21=>"晴れ"}}
    )
  end

  def test_6
    validate(
      '東の風　後　北西の風　海上　では　はじめ　東の風　強く　くもり　時々　雨　所により　明け方　まで　雷を伴い　非常に　激しく　降る',
      {:wind=>"東の風　後　北西の風　海上　では　はじめ　東の風　強く",
       :weather=>
       {0=>"くもり時々雨所により雷を伴い非常に激しく降る",
        3=>"くもり時々雨所により雷を伴い非常に激しく降る",
        6=>"くもり時々雨",
        9=>"くもり時々雨",
        12=>"くもり時々雨",
        15=>"くもり時々雨",
        18=>"くもり時々雨",
        21=>"くもり時々雨"}}
    )
  end

  def test_7
    validate(
      '南東の風　日中　北東の風　晴れ　夕方　から　くもり　所により　昼前　まで　霧',
      {:wind=>"南東の風　日中　北東の風",
       :weather=>
       {0=>"晴れ所により霧",
        3=>"晴れ所により霧",
        6=>"晴れ所により霧",
        9=>"晴れ所により霧",
        12=>"晴れ",
        15=>"くもり",
        18=>"くもり",
        21=>"くもり"}}
    )
  end
end
