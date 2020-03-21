class LoginEror < RuntimeError
end
class ServerConection < RuntimeError
end
class IncorrectParams < RuntimeError
end









class OrdersController < ApplicationController
  # Обнуление сессии, подходит для api
  protect_from_forgery with: :null_session


  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # rescue_from RuntimeError do
    # redirect_to :login, notice: '401 Unauthorized'
  # end 
  rescue_from LoginEror do
    render json: { result: false, error: '401 Unauthorized' }, status: 401
  end 
  rescue_from ServerConection do
    render json: { result: false, error: '503 Service Unavailable' }, status: 503
  end
  rescue_from IncorrectParams do
    render json: { result: false, error: '406 Not Acceptable' }, status: 406
  end
  def approve
    render json: params
  end
  def clacs
    render json: rand(100)
  end
  def index
    @orders = Order.all
    puts "params: #{params.inspect}"
  end

  def check
    #Проверяем возможные заказы
    possible_orders_service = PossibleOrdersService.new(session)
    if possible_orders_service.possible_orders == nil
      raise ServerConection 
      # return render json: {result: false, error: '503 Service Unavailable'}, status: 503
    end
    
    #Берём параметры, из квери и проверяем их
    vm_get = VmGetService.new(params)
    if vm_get.proverka(possible_orders_service.possible_orders['specs']) == nil
      # return render json: {result: false, error: '406 Not Acceptable'}, status: 406
      raise IncorrectParams
    else
      vm_par = vm_get.proverka(possible_orders_service.possible_orders['specs'])
    end

    #Запрашиваем цену, у ресурса стороннего. Нужно проверить соединение с ним.
    price_serv = PriceService.new(vm_par)
    if price_serv.get_price == nil
      raise ServerConection 
      # return render json: {result: false, error: '503 Service Unavailable'}, status: 503
    else
      price_vm = price_serv.get_price
    end


    # Проверяем баланс клиента, если его не существует, то вывести
    balan_check = BalanceCheckService.new(session, price_vm)
    if balan_check.start == nil
      raise ServerConection
      # return render json: {result: false, error: '503 Service Unavailable'}, status: 503
    end
    render json: balan_check.start 
  end


  # GET /orders
  # GET /orders.json
  #def index
  #  @orders = Order.all
  #end
  def first
    @order = Order.first
    render :show
  end  

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    #byebug
  
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:name, :status, :cost)
    end
end