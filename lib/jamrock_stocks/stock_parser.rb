module JamrockStocks
  class StockParser

    include JamrockStocks::StockConfig

    STRING_NO_SPACE           = ''
    REGEXP_DOLLAR_SIGN        = /\$/
    REGEXP_NON_BREAKING_SPACE = /\u00a0/

    def fetch_stocks
      stocks            = []
      page              = Nokogiri::HTML(open(StockConfig::STOCKS_URL))
      stocks_symbols    = page.css(StockConfig::SYMBOLS_HTML_PATH).map { |s| s.text.strip.upcase }
      date, time        = page.css(StockConfig::TIME_HTML_PATH).map { |dt| dt.text.gsub(REGEXP_NON_BREAKING_SPACE, ' ').split[0..1] }.flatten
      stocks_prices     = page.css(StockConfig::PRICE_HTML_PATH).map { |p| p.text.strip.gsub(REGEXP_DOLLAR_SIGN, StockParser::STRING_NO_SPACE) }
      change_and_volume = page.css(StockConfig::CHANGE_AND_VOLUME_HTML_PATH).map { |cv| cv.text.gsub!(REGEXP_NON_BREAKING_SPACE, ' ').
                                                                                                sub(/\s/, StockParser::STRING_NO_SPACE).
                                                                                                sub('CHG:$', StockParser::STRING_NO_SPACE).
                                                                                                sub('VOL:', StockParser::STRING_NO_SPACE).
                                                                                                sub(',', StockParser::STRING_NO_SPACE).split(/\s\s/) }

      (stocks_symbols.count - 1).times do |index|
        stocks << Stock.new(symbol: stocks_symbols[index].to_s,
                            price:  stocks_prices[index].to_f,
                            change: change_and_volume[index][0].to_f,
                            volume: change_and_volume[index][1].to_i)
      end
      { stocks: stocks.freeze, date: date.freeze, time: time.freeze }
    end
  end
end

