class OrdersController < ApplicationController
  # Обнуление сессии, подходит для api
  protect_from_forgery with: :null_session
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  def index
    @orders = Order.all
    @users = User.all
    @users.first
  end
  def approve
    render json: params
  end
  def clacs
    render json: rand(100)
  end
  def index
    @orders = Order.all
    @show = Order.select(:name, :created_at, :networks_count, :tags)
    # puts "params: #{params.inspect}"
    
    render json: {orders: @show}

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
