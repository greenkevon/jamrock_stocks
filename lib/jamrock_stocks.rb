require 'jamrock_stocks/version'
require 'jamrock_stocks/stock'
require 'jamrock_stocks/stock_config'
require 'jamrock_stocks/stock_parser'
require 'pry'
require 'nokogiri'
require 'open-uri'

module JamrockStocks
  class StockClient
      COLON = ':'
      REGEXP_DOLLAR_SIGN = /\$/


      def self.fetch_stocks
        StockParser.new.fetch_stocks
      end

      def self.fetch_trades
        StockParser.new.fetch_trades
        # trades = []
        # parsed_stocks = StockParser.new.parse_trades
        # binding.pry
        #
        # trades_time = parsed_stocks.trades[1].text.gsub(REGEXP_NON_BREAKING_SPACE,' ').strip.split(' ', 6 )[3..4]
        # binding.pry
        #
        # parsed_stocks.trades[2..-1].map { |s| s.text.gsub(REGEXP_NON_BREAKING_SPACE,' ').strip.split }.each do |trade_detail|
        #   trades << Stock.new(symbol: trade_detail[0],
        #                       volume: trade_detail[1],
        #                       price: trade_detail[3].gsub(REGEXP_DOLLAR_SIGN, StockParser::STRING_NO_SPACE),
        #                       change: trade_detail[4].gsub(REGEXP_DOLLAR_SIGN, StockParser::STRING_NO_SPACE))
        # end
        # binding.pry
        # [trades.freeze, trades_time]
      end

    end
end
