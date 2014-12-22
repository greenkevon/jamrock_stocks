require 'jamrock_stocks/version'
require 'jamrock_stocks/stock'
# require 'jamrock_stocks/mayberry'
require 'pry'
require 'time'
require 'nokogiri'
require 'open-uri'

# Brokers are automatically loaded
brokers_paths = File.join(File.dirname(__FILE__), 'jamrock_stocks', 'brokers', '*.rb')
Dir[brokers_paths].each { |file| require file }

module JamrockStocks
  class StockClient

      def self.stocks
        Mayberry.new.stocks
      end

    end
end
