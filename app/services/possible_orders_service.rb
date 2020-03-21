class PossibleOrdersService
    attr_reader :session
    def initialize(session)
      @session = session
    end

    def possible_orders(link = 'http://possible_orders.srv.w55.ru/')
        puts "session login: #{session[:login]}"
        if session[:login] == nil
            raise LoginError
        end

        client = HTTPClient.new
        response = client.request(:get, link)
        result = JSON.parse(response.body)
    rescue LoginError
        raise LoginError
    rescue
        raise ServerConection
    end
end