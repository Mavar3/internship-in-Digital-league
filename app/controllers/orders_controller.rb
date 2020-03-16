class LoginEror < RuntimeError
end
class ServerConection < RuntimeError
end









class OrdersController < ApplicationController
  # Обнуление сессии, подходит для api
  protect_from_forgery with: :null_session


  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # rescue_from RuntimeError do
    # redirect_to :login, notice: '401 Unauthorized'
  # end 
  rescue_from LoginEror do
    answer = { result: false, error: '401 Unauthorized' }
    puts answer[:error].class 
    # render json: { result: false }, status :401
    # redirect_to :login, notice: '401 Unauthorized'
  end 
  rescue_from ServerConection do

    # redirect_to :orders, notice: '503 Service Unavailable'
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







  def proverka(order)
    all_what_i_need = Hash.new
    order.each do |pos_order|
      all_what_i_need.clear
      pos_order['os'][0] == params['os'] ?  nil : next
      pos_order['cpu'].each {|el| el == params['cpu'].to_i ? all_what_i_need['cpu'] = el : next}
      pos_order['ram'].each {|el| el == params['ram'].to_i ? all_what_i_need['ram'] = el : next}
      pos_order['hdd_type'].each {|el| el == params['hdd_type'] ? all_what_i_need['hdd_type'] = el : next}
      pos_order['hdd_type'].each {|el|}
      # pos_order['cpu'].each { |value| value == params['cpu'] ? nil }
      
    end
  end






  def check
    puts "I'am alive"
    possible_orders_service = PossibleOrdersService.new(session)
    if possible_orders_service.possible_orders == nil
      return render json: {result: false}, status: 503
    end
    proverka(possible_orders_service.possible_orders['specs'])
    puts possible_orders_service.possible_orders['specs'][0].each { |key, value| puts "Key: #{key} Value: #{value} "}
    puts params
    
    
    

    
    
    
    
    
    
    
    render json: {result: true}






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