class PriceService
    attr_reader :session
    def initialize(session)
        @session = session
    end
    def get_price(sorce = 'http://lockalhost:8080')
        client = HTTPClient.new
        #В post запросе необходимо передать, а в гет принять
    end
end
  