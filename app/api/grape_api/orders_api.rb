# frozen_string_literal: true

class GrapeApi
  class OrdersApi < Grape::API
    format :json
    # Перевести на другой класс
    namespace :orders do
      route_param :id, type: Integer do
        desc 'Заказ',
          success: GrapeApi::Entities::Order,
          is_array: true
        get do
          order = Order.find_by_id(params[:id])
          error!({ message: 'Заказ не найден' }, 404) unless order
          present order with: GrapeApi::Entities::Order, detail: params[:detail]
        end
        # upgrate and another
      end
      desc 'Проверка по Статусу'
      params do
        optional :status, type: Integer
      end
      get do
        orders = if params[:status].present?
                  Order.where('status >= :status', status: params[:status])
                else
                  Order.all
        end
        present orders
      end
    end
  end
end
