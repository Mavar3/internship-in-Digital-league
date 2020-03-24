class VmGetService
  class IncorrectParams < RuntimeError
  end
  attr_reader :params
  def initialize(params)
      @params = params
  end
#    def check_os
#      #Проверяем ОС на совпадение с одним из параметров
#      os = params['os'].downcase
#      return (next all.clear) unless order['os'].include?(os)
#    end
#    def check_ram
#      #Проверяем память на совпадение
#      ram = params['ram'].to_i
#      next all.clear unless order['ram'].include?(ram)
#      all['ram'] = ram
#    end
#    def check_cpu
#      #Проверяем процессор
#      cpu = params['cpu'].to_i
#      next all.clear unless order['cpu'].include?(cpu)
#      all['cpu'] = cpu
#    end
#    def check_type
#      #Проверяем типы
#      hdd_type = params['hdd_type']
#      next all.clear unless order['hdd_type'].include?(hdd_type)
#      all['hdd_type'] = hdd_type
#    end
#    def check_hdd_capacity
#      #Т.к. тип проверили, то нет необходимости проверять его снова
#      hdd_capacity = params['hdd_capacity'].to_i
#      from = order['hdd_capacity'][ params['hdd_type'] ]['from']
#      to = order['hdd_capacity'][ params['hdd_type'] ]['to']
#      next all.clear unless from <= hdd_capacity && to >= hdd_capacity
#      all['hdd_capacity'] = hdd_capacity
#    end
  def proverka(orders)
    all = Hash.new
    orders.each do |order|
      #Проверка на наличие ошибки.
      #Проверяем ОС на совпадение с одним из параметров
      os = params['os'].downcase
      next all.clear unless order['os'].include?(os)
      #Проверяем память на совпадение
      ram = params['ram'].to_i
      next all.clear unless order['ram'].include?(ram)
      all['ram'] = ram
      #Проверяем процессор
      cpu = params['cpu'].to_i
      next all.clear unless order['cpu'].include?(cpu)
      all['cpu'] = cpu
      #Проверяем типы
      hdd_type = params['hdd_type']
      next all.clear unless order['hdd_type'].include?(hdd_type)
      all['hdd_type'] = hdd_type
      #Т.к. тип проверили, то нет необходимости проверять его снова
      hdd_capacity = params['hdd_capacity'].to_i
      from = order['hdd_capacity'][ params['hdd_type'] ]['from']
      to = order['hdd_capacity'][ params['hdd_type'] ]['to']
      next all.clear unless from <= hdd_capacity && to >= hdd_capacity
      all['hdd_capacity'] = hdd_capacity
      return all unless all['hdd_capacity'] == nil
    end
      raise IncorrectParams    
  rescue
      raise IncorrectParams
  end
end