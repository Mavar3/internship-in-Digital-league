class PossibleOrdersService
    attr_reader :session
    def initialize(session)
        @session = session
    end

    def possible_orders
        raise if session[:login] == nil
        client = HTTPClient.new
        response = client.request(:get, 'http://possible_orders.srv.w55.ru/')
        result = JSON.parse(response.body)
    rescue
        return nil
    end
end