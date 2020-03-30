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
    report.max_cost = sort_orders.first(counter)
    report.min_cost = sort_orders.last(counter)
    report.save
  end
end
