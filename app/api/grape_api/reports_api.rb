class GrapeApi
  class ReportsApi < Grape::API
    format :json
    # Перевести на другой класс
    namespace :reports do
      params do
        optional :count, type: Integer, desc: 'Количество vm в отчёте'
      end        
      get do 
        ReportsApi::added_at_queue
        present status: "Отправленно в работу. Проверяйте http://localhost:3000/api/reports/result"
      end

      def added_at_queue
        connection = Bunny.new('amqp://guest:guest@rabbitmq')
        # Открываем соединение с контенйром, в котором запущен rabbitmq
        connection.start
        # Открываем новый канал, в рамках которого будем работать. AMQP поддерживает одновременную работу с мнодеством каналов
        channel = connection.create_channel
        # Определелям exhange в который будем отправлять сообщения. Exchange может иметь правила по маршрутизации сообщений (bindings)
        exchange = channel.default_exchange
        # По умолчанию exchange отправляет все сообщения в ту очередь, которой соответствует ключ маршрутизации
        queue_name = 'vm.control'
        exchange.publish(ReportsApi::form_Ord.to_json, routing_key: queue_name)
      end

      def form_Ord
        orders = Order.all
        all_cost = {}
        orders.each { |order| all_cost[order.id] = order.cost}
        return all_cost
      end

      route_param :result, type: String do
        get do
          # test = []
          # Order.all.each {|o| test.push(o.class)}
          # present test
          present Order.all, with: GrapeApi::Entities::Report
        end
      end

    end
  end
end
