class JmaForecastParser
  WEATHER = /晴れ|くもり|雨|雪|降る|霧|を伴う|一時|時々|後/
  TIMING = /未明|明け方|朝|昼前|昼過ぎ|夕方|夜のはじめ頃|夜|夜遅く|から|まで|朝晩/

  # FREQUENCY = /一時|時々|後/
  SPOT = /所により/
  MODIFIER = /雷を伴い|非常に|激しく|雷/

  def self.parse(forecast)
    if forecast =~ /(.+(?:風|強く))　(.+)/
      return { wind: $1, weather: JmaForecastParser.parse_weather($2) }
    end
    nil
  end

  def self.parse_timing(timing)
    timing_map = { '未明' => 0, '明け方' => 3, '朝' => 6, '昼前' => 9,
                   '昼過ぎ' => 12, '夕方' => 15, '夜のはじめ頃' => 18, '夜遅く' => 21,
                   '夜' => [18,21], '朝晩' => [0,3,6,18,21], '朝夕' => [0,3,6,15] }

    if timing == ''
      return (0..21).step(3).to_a
    elsif timing =~ /(.+)から(.+)/
      from = timing_map[$1]
      to   = timing_map[$2]
      return (from..to).step(3).to_a
    elsif timing =~ /(.+)から/
      from = timing_map[$1]
      return (from..21).step(3).to_a
    elsif timing =~ /(.+)まで/
      to   = timing_map[$1]
      return (0..to).step(3).to_a
    else
      return [timing_map[timing]].flatten
    end
  end

  def self.parse_weather(weather)
    forecasts = Hash[*[(0..21).step(3).to_a, Array.new(8).map{''}].transpose.flatten]
    # => {0=>"", 3=>"", 6=>"", 9=>"", 12=>"", 15=>"", 18=>"", 21=>""}

    items = weather.split(/　/)

    weather = ''
    timing = ''
    frequency = ''
    spot = ''
    modifier = ''

    items.each_with_index { |e, i|
      if e =~ WEATHER
        weather += e

        # 先読み
        next if items[i+1] =~ WEATHER

        timings = parse_timing(timing)
        timings.each { |t|
          if frequency == '' && spot == ''
            forecasts[t] = ''
          end
          forecasts[t] += "#{frequency}#{spot}#{modifier}#{weather}"
        }

        weather = ''
        timing = ''
        frequency = ''
        spot = ''
        modifier = ''
      end

      timing += e if e =~ TIMING
      # frequency += e if e =~ FREQUENCY
      spot += e if e =~ SPOT
      modifier += e if e =~ MODIFIER
    }

    forecasts
  end
end
