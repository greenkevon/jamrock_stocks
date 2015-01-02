module JamrockStocks
  class Mayberry
    attr_reader :page, :change_and_volume, :stock_prices, :stock_symbols

    STRING_NO_SPACE           = ''
    REGEXP_DOLLAR_SIGN        = /\$/
    REGEXP_NON_BREAKING_SPACE = /\u00a0/

    STOCKS_URL = 'https://www.mayberryinv.com/PhysicalPages/Ticker/TickerDataSource.aspx'
    TRADES_URL = 'https://www.mayberryinv.com/PhysicalPages/Ticker/TickerTradeDataSource.aspx'
    BASE_HTML_PATH              = 'span#TickerSpan > table > tr > td > table > tr > td > table >'
    SYMBOLS_HTML_PATH           = "#{BASE_HTML_PATH} tr[2] > td > strong > span[1]"
    PRICE_HTML_PATH             = "#{BASE_HTML_PATH} tr[2] > td > strong > span[2]"
    CHANGE_AND_VOLUME_HTML_PATH = "#{BASE_HTML_PATH} tr[4] > td > strong"
    TIME_HTML_PATH              = 'span#TickerSpan > table > tr > td > table > tr > td[2] > span#LabelSummaryTime'
    TRADES_HTML_PATH            = 'span#TickerTradeDataSpan > table > tr > td'


    def stocks
      @stocks ||= fetch_stocks
    end

    def clear_stocks
      @stocks = nil
    end

    def clear_page
      @pate = nil
    end

    def reset
      clear_stocks
      clear_page
    end

    def fetch_stocks
      reset
      stocks = []
      stock_symbols.count.times do |index|
        stocks << Stock.new(symbol: stock_symbols[index],
                            price:  stock_prices[index].to_f,
                            change: change_and_volume[index][0].to_f,
                            volume: change_and_volume[index][1].to_i,
                            updated_at: updated_at)
      end
      stocks
    end


    private

    def page
      @page ||=  Nokogiri::HTML(open(STOCKS_URL))
    end

    def updated_at
      date, time = page.css(TIME_HTML_PATH).map { |dt| dt.text.gsub(REGEXP_NON_BREAKING_SPACE, ' ').split[0..1] }.flatten
      Time.parse("#{date} #{time}")
    end

    def stock_symbols
      @stock_symbols ||= page.css(SYMBOLS_HTML_PATH).map { |s| s.text.strip.upcase }.compact
    end

    def stock_prices
      @stock_prices ||= page.css(PRICE_HTML_PATH).map { |p| p.text.strip.gsub(REGEXP_DOLLAR_SIGN, Mayberry::STRING_NO_SPACE) }
    end

    def change_and_volume
      @change_and_volume ||= page.css(CHANGE_AND_VOLUME_HTML_PATH).
          map { |cv| cv.text.gsub!(REGEXP_NON_BREAKING_SPACE, ' ').
          sub(/\s/, Mayberry::STRING_NO_SPACE).
          sub('CHG:$', Mayberry::STRING_NO_SPACE).
          sub('VOL:', Mayberry::STRING_NO_SPACE).
          sub(',', Mayberry::STRING_NO_SPACE).split(/\s\s/) }
    end
  end
end

