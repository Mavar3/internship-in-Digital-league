class ReportWorker
  include Sidekiq::Worker

  def perform(user_id, counter)
    # really_slow_task(orders, user_id, counter)
    orders = Order.all
    report = Report.new(user_id: user_id)
    sort_orders = orders.order(:cost)
    sort_orders = sort_orders.where(user_id: user_id)  
    report.max_cost = sort_orders.first(counter)
    report.min_cost = sort_orders.last(counter)
    report.save
  end

  # private

  # def really_slow_task(orders, user_id, counter)
    # report = Report.new(user_id: user_id)
    # sort_orders = orders.order(:cost)
    # report.max_cost = sort_orders.first(counter)
    # report.min_cost = sort_orders.last(counter)
    # report.save
  # end

  # def form_ord(orders)
    # all_cost = {}
    # orders.each { |order| all_cost[order.id] = order.cost}
    # return all_cost
  # end
end
