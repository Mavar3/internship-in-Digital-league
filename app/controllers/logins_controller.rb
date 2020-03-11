class LoginsController < ApplicationController
    def show
    end
    rescue_from RuntimeError do
        redirect_to :login, notice: 'Неверный пароль'
    end    
    # def create
    #     raise if params[:password] != '123'
    
    #     session[:login] = params[:login]
    #     redirect_to :login, notice: 'Вы вошли'
    #     rescue_from RuntimeError do
    #         redirect_to :login, notice: 'Неверный пароль'
    #     end    
    # end  
    #def create
    #  if params[:password] == '123'
    #    session[:login] = params[:login]
    #    redirect_to :login, notice: 'Вы вошли'
    #    session[:balance] = 1000
    #  else
    #    redirect_to :login, notice: 'Неверный пароль'
    #  end
    #end
    def create
        login_service = LoginService.new(params[:login], params[:password], session)
        redirect_to :login, notice: login_service.message
    end
    
  
    def destroy
      session.delete(:login)
      redirect_to :login, notice: 'Вы вышли'
      session.delete(:credits)
    end
end
  