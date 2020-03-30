# frozen_string_literal: true

def really_slow_task(payload)
  puts 'Starting really slow task!'

  10.times do
    putc '.'
   sleep 1
  end
  puts '.'
  puts "Payload 1: #{payload}"
  puts "Payload: #{payload.class}"
  puts 'Slow task finished'
end


require 'eventmachine'
require 'bunny'

EventMachine.run do
  connection = Bunny.new('amqp://guest:guest@rabbitmq')
  connection.start

  channel = connection.create_channel # Открытие канала для сообщения
  queue = channel.queue('vm.control', auto_delete: true) # Подписывем обрабочик на получения сообщений для добавления в очередь

  queue.subscribe do |_delivery_info, _metadata, payload| # Принимает блок, который выполняется каждый раз, когда приходит сообщение в очередь
    really_slow_task(payload)
  end

  Signal.trap('INT') do
    puts 'exiting INT'
    connection.close { EventMachine.stop }
  end

  Signal.trap('TERM') do
    puts 'killing TERM'
    connection.close { EventMachine.stop }
  end
end
