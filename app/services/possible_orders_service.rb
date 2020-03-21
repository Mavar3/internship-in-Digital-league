class PossibleOrdersService
    attr_reader :session
    def initialize(session)
        @session = session
    end

    def possible_orders
        if session[:login] == nil
            raise LoginError
        end
        client = HTTPClient.new
        response = client.request(:get, 'http://possible_orders.srv.w55.ru/')
        result = JSON.parse(response.body)
    rescue
        raise ServerConection
    end
end