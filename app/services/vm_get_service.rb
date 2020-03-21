class VmGetService
    attr_reader :params
    def initialize(params)
        @params = params
    end
    def proverka(orders)
        all = Hash.new
        orders.each do |order|
            #Проверка на наличие ошибки.
            #Проверяем ОС на совпадение с одним из параметров
            os = params['os'].downcase
            unless order['os'][0] == os
                all.clear
                next
            end
            #Проверяем память на совпадение
            ram = params['ram'].to_i
            if order['ram'].each { |el| el == ram }
                all['ram'] = ram
            else
                all.clear
                next
            end
            #Проверяем процессор
            cpu = params['cpu'].to_i
            if order['cpu'].each { |el| el == cpu }
                all['cpu'] = cpu
            else
                all.clear
                next
            end
            #Проверяем типы
            if order['hdd_type'].each { |el| el == params['hdd_type']}
                all['hdd_type'] = params['hdd_type']
            else
                all.clear
                next
            end
            #Т.к. тип проверили, то нет необходимости проверять его снова
            hdd_capacity = params['hdd_capacity'].to_i
            # raise IncorrectParams unless order['hdd_capacity'][ params['hdd_type'] ]['from'] <= hdd_capacity && order['hdd_capacity'][ params['hdd_type'] ]['to'] >= hdd_capacity
            if order['hdd_capacity'][ params['hdd_type'] ]['from'] <= hdd_capacity && order['hdd_capacity'][ params['hdd_type'] ]['to'] >= hdd_capacity
                all['hdd_capacity'] = hdd_capacity
                return all
            else
                all.clear
                next
            end
        end
        raise IncorrectParams    
    rescue
        raise IncorrectParams
    end
end