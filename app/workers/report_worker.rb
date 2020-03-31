class ReportWorker
  include Sidekiq::Worker

  def perform(user_id, counter)
    create_report(user_id, counter)
  end

  private
 
  def create_report(user_id, counter)
    orders = Order.all
    report = Report.new(user_id: user_id)
    sort_orders = orders.order(:cost)
    sort_orders = sort_orders.where(user_id: user_id)
    sort_ram_orders = orders.order(:options['ram']) #Он не совсем коректно сортирует, вернее вообще не сортирует
    sort_ram_orders = sort_ram_orders.where(user_id: user_id)
    sort_hdd_capcity_orders = order.order(:options['hdd_capacity']) #Надо как-то подобраться к [:options]['hdd_capacity']
    sort_hdd_capcity_orders = sort_hdd_capcity_orders.where(user_id: user_id)
    report.max_cost = sort_orders.last(counter)
    report.min_cost = sort_orders.first(counter)
    report.max_count_ram = sort_ram_orders.first(counter)
    report.max_additional_hdd = sort_hdd_capcity_orders.first(counter)
    report.save
  end
end
