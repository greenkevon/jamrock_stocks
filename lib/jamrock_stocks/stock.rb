module JamrockStocks
  class Stock

    attr_reader :symbol, :price, :change, :volume, :previous_price, :updated_at

    def initialize(symbol:, price:, change: 0.0, volume: 0, updated_at:)
      @symbol = symbol.to_str.upcase
      @price  = price.to_f
      @change = change.to_f
      @volume = volume.to_int
      @previous_price = @price - (@change)
      @updated_at = updated_at
    end

    def percentage_change
      (@change / @previous_price) * 100
    end
  end
end
