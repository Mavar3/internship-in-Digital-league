# frozen_string_literal: true

class GrapeApi
  class OrdersApi < Grape::API
    format :json
    # Перевести на другой класс
    namespace :orders do
      route_param :id, type: Integer do
        desc 'Заказ',
          success: GrapeApi::Entities::Order,
          failure: [{ code: 404, message: 'Заказ не найдена' }]
        get do
          order = Order.find_by_id(params[:id])
          error!({ message: 'Заказ не найден' }, 404) unless order
          present order with: GrapeApi::Entities::Order
        end
      end
      desc 'Проверка по Статусу',
        success: GrapeApi::Entities::Order,
        is_array: true 
      params do
        optional :status, type: Integer
      end
      get do
        orders = params[:status].present? ? Order.where('status >= :status', status: params[:status]) : Order.all
        present orders
      end
    end
  end
end
