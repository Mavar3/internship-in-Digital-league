class PossibleOrdersService
    class LoginError < RuntimeError
    end
    class ServerConectionError < RuntimeError
    end
    attr_reader :session
    def initialize(session)
      @session = session
    end

    def possible_orders(link = 'http://possible_orders.srv.w55.ru/')
        puts "session login: #{session[:login]}"
        raise LoginError if session[:login] == nil
        
        client = HTTPClient.new
        response = client.request(:get, link)
        result = JSON.parse(response.body)
    rescue LoginError
        raise LoginError
    rescue
        raise ServerConectionError
    end
end