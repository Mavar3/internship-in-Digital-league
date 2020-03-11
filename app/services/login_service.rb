class LoginService
    attr_reader :login, :password, :session
  
    def initialize(login, password, session)
      @login, @password, @session = login, password, session
    end
  
    def message
      raise if password != '123'
  
      session[:login] = login
      session[:credits] ||= 1000
      #orders_controller = OrdersController.new()
      #session[:test] = orders_controller.check
      "#{login}, вы вошли в #{Time.now}"
    end
  end
  