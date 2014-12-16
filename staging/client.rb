#
# require 'rubygems'
# require 'nokogiri'
# require 'open-uri'
# require 'pry'
# require 'zlib'
#
# module JamrockStocks
#
#   module StockConfig
#     STOCKS_URL = 'https://www.mayberryinv.com//PhysicalPages/Ticker/TickerDataSource.aspx'
#     TRADES_URL = 'https://www.mayberryinv.com//PhysicalPages/Ticker/TickerTradeDataSource.aspx'
#
#     BASE_HTML_PATH = 'span#TickerSpan > table > tr > td > table > tr > td > table >'
#     TRADES_HTML_PATH = 'span#TickerTradeDataSpan > table > tr > td'
#     SYMBOLS_HTML_PATH = "#{BASE_HTML_PATH} tr[2] > td > strong > span[1]"
#     PRICE_HTML_PATH = "#{BASE_HTML_PATH} tr[2] > td > strong > span[2]"
#     CHANGE_AND_VOLUME_HTML_PATH = "#{BASE_HTML_PATH} tr[4] > td > strong"
#     TIME_HTML_PATH = 'span#TickerSpan > table > tr > td > table > tr > td[2] > span#LabelSummaryTime'
#
#
#
#     # NEWS_URL = 'https://www.mayberryinv.com//PhysicalPages/Ticker/NewsDataSource.aspx'
#   end
#
#   class StockParser
#
#     include StockConfig
#
#     STRING_NO_SPACE = ''
#     REGEXP_NON_BREAKING_SPACE = /\u00a0/
#
#     attr_reader :stocks_symbols, :stocks_prices, :change_string, :volume_string, :trades, :date, :time
#
#     def parse_stocks
#       page = Nokogiri::HTML(open(StockConfig::STOCKS_URL))
#       @stocks_prices = page.css(StockConfig::PRICE_HTML_PATH)
#       @stocks_symbols = page.css(StockConfig::SYMBOLS_HTML_PATH)
#       market_summary_time = page.css(StockConfig::TIME_HTML_PATH)
#       stocks_change_and_volume = page.css(StockConfig::CHANGE_AND_VOLUME_HTML_PATH)
#
#       #replace non breaking space with a single white space
#       change_and_volume = stocks_change_and_volume.last.text.gsub(REGEXP_NON_BREAKING_SPACE, ' ')
#       #replace single space with no space then split on double spaces
#       @change_string, @volume_string = change_and_volume.sub(/\s/, StockParser::STRING_NO_SPACE).split( /\s\s/)
#
#       @date, @time = market_summary_time.text.gsub(REGEXP_NON_BREAKING_SPACE, ' ').split
#       self
#     end
#
#     def parse_trades
#       trades_page = Nokogiri::HTML(open(StockConfig::TRADES_URL))
#       @trades = trades_page.css(StockConfig::TRADES_HTML_PATH)
#
#       binding.pry
#
#       @date, @time = market_summary_time.text.gsub(REGEXP_NON_BREAKING_SPACE, ' ').split
#       self
#     end
#   end
#
#   class Stock
#
#     attr_reader :symbol, :price, :change, :volume
#
#     def initialize(symbol:, price:, change: 0.0, volume: 0)
#       @symbol = symbol.to_str.upcase!
#       @price = price.to_f
#       @change = change.to_f
#       @volume = volume.to_int
#     end
#
#   end
#
#   # class Trade
#   #   attr_reader :symbol, :price, :change, :volume
#   #
#   #   def initialize(symbol:, volume:, price: 0.0, change: 0)
#   #     @symbol = symbol.to_str.upcase!
#   #     @price = price.to_f
#   #     @change = change.to_f
#   #     @volume = volume.to_int
#   #   end
#   # end
#
#   class TradeSummary
#
#     attr_reader :index, :points, :change
#
#     def initialize(index:, points:, change:)
#       @index = index.to_str
#       @points = points.to_f
#       @change = change.to_f
#     end
#
#   end
#
#
#   class Client
#
#     attr_reader :stocks, :trade_summary, :trades, :trades_time
#
#     COLON = ':'
#     REGEXP_DOLLAR_SIGN = /\$/
#
#     attr_accessor :stock_parser
#
#     def parsed_stocks
#       @stock_parser ||= JamrockStocks::StockParser.new.parse
#     end
#
#     def load_stocks
#       @stocks = []
#
#       (parsed_stocks.stocks_symbols.count - 1).times.each do |index|
#         stocks << Stock.new( symbol: parsed_stocks.stocks_symbols[index].text,
#                              price: parsed_stocks.stocks_prices[index].text.gsub(REGEXP_DOLLAR_SIGN, StockParser::STRING_NO_SPACE).to_f,
#                              change: parsed_stocks.change_string.split(COLON)[1].gsub(REGEXP_DOLLAR_SIGN, StockParser::STRING_NO_SPACE).to_f,
#                              volume: parsed_stocks.volume_string.split(COLON)[1].gsub(REGEXP_DOLLAR_SIGN, StockParser::STRING_NO_SPACE).to_i )
#       end
#     end
#
#     def load_trades
#       @trades = []
#
#       @trades_time = parsed_stocks.trades[1].text.gsub(REGEXP_NON_BREAKING_SPACE,' ').strip.split(' ', 6 )[3..4]
#
#       parsed_stocks.trades[2..-1].map { |s| s.text.gsub(REGEXP_NON_BREAKING_SPACE,' ').strip.split }.each do |trade_detail|
#         @trades << Stock.new(symbol: trade_detail[0],
#                              volume: trade_detail[1],
#                              price: trade_detail[3].gsub(REGEXP_DOLLAR_SIGN, StockParser::STRING_NO_SPACE),
#                              change: trade_detail[4].gsub(REGEXP_DOLLAR_SIGN, StockParser::STRING_NO_SPACE))
#       end
#     end
#
#     # def load_trade_summary
#     #   binding.pry
#     #   parsed_stocks
#     #   binding.pry
#     #   TradeSummary.new()
#     #
#     #
#     # end
#   end
# end
