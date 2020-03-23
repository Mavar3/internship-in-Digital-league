class BalanceCheckService
  attr_reader :session, :vm_cost
  
  def initialize(session, vm_cost)
    @session, @vm_cost = session, vm_cost
  end

  def start
    puts session[:credits]
    raise LoginError if session[:credits] == nil
    raise IncorrectParams unless session[:credits] >= vm_cost
    answer = {result: true, total: vm_cost, balance: session[:credits], 
      balance_after_transaction: session[:credits] - vm_cost}
  end
end
