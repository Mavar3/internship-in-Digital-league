class GrapeApi
  class ReportsApi < Grape::API
    format :json
    # Перевести на другой класс
    namespace :reports do
      route_param :start, type: String do
        params do
          optional :count, type: Integer, desc: 'Количество vm в отчёте'
          optional :type, type: String, desc: 'Тип по которому будет выводиться n максимальных vm'
        end        
        get do 
          ReportsApi::asa
          present status: true
        end

        def asa
          connection = Bunny.new('amqp://guest:guest@rabbitmq')
          # Открываем соединение с контенйром, в котором запущен rabbitmq
          connection.start
          # Открываем новый канал, в рамках которого будем работать. AMQP поддерживает одновременную работу с мнодеством каналов
          channel = connection.create_channel
          # Определелям exhange в который будем отправлять сообщения. Exchange может иметь правила по маршрутизации сообщений (bindings)
          exchange = channel.default_exchange
          # По умолчанию exchange отправляет все сообщения в ту очередь, которой соответствует ключ маршрутизации
          queue_name = 'vm.control'
          exchange.publish({ vm_id: "simple test", signal: :start }.to_json, routing_key: queue_name)
        end
      end

    end
  end
end
