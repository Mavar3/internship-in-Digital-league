class ReportWorker
  include Sidekiq::Worker

  def perform(orders, user_id, counter)
    really_slow_task(orders, user_id)
  end

  private

  def really_slow_task(orders, user_id)
    report = Report.new(user_id: user_id)
    sort_orders = order.sort_by(:cost)
    # sort_orders = form_ord(orders).sort_by {|k, v| v}
    # report.max_cost = 
  end

  # def form_ord(orders)
    # all_cost = {}
    # orders.each { |order| all_cost[order.id] = order.cost}
    # return all_cost
  # end
end
