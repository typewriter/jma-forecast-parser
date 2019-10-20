# JMA Forecast Parser

[![Build Status](https://travis-ci.org/typewriter/jma-forecast-parser.svg?branch=master)](https://travis-ci.org/typewriter/jma-forecast-parser)

## Requirement

- Ruby (>= 2.5)
- minitest

## Usage

```bash
$ ./runner.rb
天気予報を入力: 北の風　晴れ
解析結果:
{:wind=>"北の風",
 :weather=>
  {0=>"晴れ", 3=>"晴れ", 6=>"晴れ", 9=>"晴れ", 12=>"晴れ", 15=>"晴れ", 18=>"晴れ", 21=>"晴れ"}}

天気予報を入力: 北東の風　後　東の風　やや強く　くもり　昼過ぎ　から　雨　所により　夜　雷を伴い　激しく　降る
解析結果:
{:wind=>"北東の風　後　東の風　やや強く",
 :weather=>
  {0=>"くもり",
   3=>"くもり",
   6=>"くもり",
   9=>"くもり",
   12=>"雨",
   15=>"雨",
   18=>"雨所により雷を伴い激しく降る",
   21=>"雨所により雷を伴い激しく降る"}}
```

## License

MIT License

