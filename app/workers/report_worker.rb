class ReportWorker
  include Sidekiq::Worker

  def perform(user_id, counter)
    create_report(user_id, counter)
  end

  private
 
  def create_report(user_id, counter, type)
    orders = Order.all
    report = Report.new(user_id: user_id)
    type = sort_by_type(type)
    sort_orders = orders.order(:cost)
    sort_orders = sort_orders.where(user_id: user_id)
    sort_type_orders = orders.order("(options ->> '#{type}')") #Я нашёл эту дичь!!!! Спасибо Stackoverflow
    sort_type_orders = sort_ram_orders.where(user_id: user_id) #https://stackoverflow.com/questions/42365091/rails-order-by-a-hash-value-attribute
    sort_hdd_capcity_orders = orders.order("(options ->> 'hdd_capacity')")
    sort_hdd_capcity_orders = sort_hdd_capcity_orders.where(user_id: user_id)
    report.max_cost = sort_orders.last(counter)
    report.min_cost = sort_orders.first(counter)
    report.max_count_type = sort_type_orders.last(counter)
    report.max_additional_hdd = sort_hdd_capcity_orders.last(counter)
    report.save
  end

  def sort_by_type(type)
    hdd_type = ['sas', 'sata', 'ssd']
    result = hdd_type.include?(type) ? hdd_capacity : type
  end
end
