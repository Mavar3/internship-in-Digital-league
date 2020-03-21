class BalanceCheckService
  attr_reader :session, :vm_cost
  
  def initialize(session, vm_cost)
    @session, @vm_cost = session, vm_cost
  end

  def start
    puts session[:credits]
    if session[:credits] == nil
      raise LoginError
    end
    if session[:credits] >= vm_cost
      answer = {result: true, total: vm_cost, balance: session[:credits], 
        balance_after_transaction: session[:credits] - vm_cost}
    else
      raise IncorrectParams
    end
  end
end
