module JamrockStocks
  class Stock

    attr_reader :symbol, :price, :change, :volume

    def initialize(symbol:, price:, change: 0.0, volume: 0)
      @symbol = symbol.to_str.upcase
      @price = price.to_f
      @change = change.to_f
      @volume = volume.to_int
    end
  end
end
