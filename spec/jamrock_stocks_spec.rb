require 'rspec'
require 'spec_helper'

describe 'Stock' do

  it 'should not retrieve an invalid stock' do
    result = StockClient.fetch_stocks symbols:['MILSS']
    expect(result[:stocks]).to be_empty
    expect(result[:stocks].count).to eq(0)
  end

  it 'should retrieve a single stock' do
    result = StockClient.fetch_stocks symbols:['MIL']
    expect(result[:stocks]).not_to be_empty
    expect(result[:stocks].count).to eq(1)
    expect(result[:stocks].first.symbol).to eq('MIL')
    expect(result[:stocks].first.symbol).to eq('MIL')
  end

  it 'should retrieve 3 stocks' do
    result = StockClient.fetch_stocks symbols:['MIL','BRG', 'BPOW', 'PEMP']
    expect(result[:stocks]).not_to be_empty
    expect(result[:stocks].count).to eq(3)
    expect(result[:stocks].last.symbol).to eq('BPOW')
  end

  it 'should retrieve all stocks' do
    result = StockClient.fetch_stocks
    expect(result[:stocks]).not_to be_empty
    expect(%w(BRG CBNY CAR CCC) - result[:stocks].map{ |s| s.symbol } ).to be_empty
  end
end
