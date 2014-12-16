module JamrockStocks
  module StockConfig
    STOCKS_URL = 'https://www.mayberryinv.com/PhysicalPages/Ticker/TickerDataSource.aspx'
    TRADES_URL = 'https://www.mayberryinv.com/PhysicalPages/Ticker/TickerTradeDataSource.aspx'

    BASE_HTML_PATH              = 'span#TickerSpan > table > tr > td > table > tr > td > table >'
    SYMBOLS_HTML_PATH           = "#{BASE_HTML_PATH} tr[2] > td > strong > span[1]"
    PRICE_HTML_PATH             = "#{BASE_HTML_PATH} tr[2] > td > strong > span[2]"
    CHANGE_AND_VOLUME_HTML_PATH = "#{BASE_HTML_PATH} tr[4] > td > strong"
    TIME_HTML_PATH              = 'span#TickerSpan > table > tr > td > table > tr > td[2] > span#LabelSummaryTime'

    TRADES_HTML_PATH            = 'span#TickerTradeDataSpan > table > tr > td'
  end
end
