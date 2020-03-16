class OrderService
    attr_reader :session, :request
  
    def initialize(session, request)
      @session = session
      @request = request
    end

    def message
      raise if session[:login] == nil
      # render status: 400
      client = HTTPClient.new
      response = client.request(:get, 'http://possible_orders.srv.w55.ru/')
      result = JSON.parse(response.body)
      # render json: result
    end

    def get_query
      request.query_parameters
    end
  end
  