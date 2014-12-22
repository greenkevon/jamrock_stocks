require 'rspec'
require 'spec_helper'

describe 'Stock' do
  it 'should retrieve all stocks' do
    stocks = StockClient.stocks
    expect(stocks).not_to be_empty
    expect(stocks.count).to eq(60)
    expect(%w(BRG CBNY CAR CCC) - stocks.map{ |s| s.symbol } ).to be_empty
  end
end
