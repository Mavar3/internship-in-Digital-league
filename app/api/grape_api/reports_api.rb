class GrapeApi
  class ReportsApi < Grape::API
    format :json
    # Перевести на другой класс
    namespace :reports do
#      get do 
#        connection = Bunny.new('amqp://guest:guest@rabbitmq')
#
#        # Открываем соединение с контенйром, в котором запущен rabbitmq
#        connection.start
#
#        # Открываем новый канал, в рамках которого будем работать. AMQP поддерживает одновременную работу с мнодеством каналов
#        channel = connection.create_channel
#
#        # Определелям exhange в который будем отправлять сообщения. Exchange может иметь правила по маршрутизации сообщений (bindings)
#        # В данном примере мы используем exchange по умолчанию, который маршрутизирует сообщение во все очереди.
#        exchange = channel.default_exchange
#
#        # По умолчанию exchange отправляет все сообщения в ту очередь, которой соответствует ключ маршрутизации
#        queue_name = 'vm.control'
#        exchange.publish({ vm_id: "simple test", signal: :start }.to_json, routing_key: queue_name)
#      end
    end
  end
end
