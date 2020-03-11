class OrderService
    attr_reader :session
  
    def initialize(session)
      @session = session
    end

    def message
      # raise if session[:login] == nil
  
      client = HTTPClient.new
      response = client.request(:get, 'http://possible_orders.srv.w55.ru/')
      result = JSON.parse(response.body)
      # render json: result
    end
  end
  