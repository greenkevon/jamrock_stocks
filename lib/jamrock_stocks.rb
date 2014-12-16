require 'jamrock_stocks/version'
require 'jamrock_stocks/stock'
require 'jamrock_stocks/stock_config'
require 'jamrock_stocks/stock_parser'
require 'pry'
require 'nokogiri'
require 'open-uri'

module JamrockStocks
  class StockClient

      def self.fetch_stocks
        StockParser.new.fetch_stocks
      end

    end
end
