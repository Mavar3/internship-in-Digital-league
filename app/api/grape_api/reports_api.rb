class GrapeApi
  class ReportsApi < Grape::API
    format :json
    # Перевести на другой класс
    namespace :reports do
      desc 'Получение отчета о виртуальных пользователя',
        failure: [{ code: 404, message: 'Пользователь с заказами не найден' }]
        # failure: [{ code: 406, message: '`Счётчик не может быть < 1' }]
      params do
        optional :count, type: Integer, desc: 'Количество vm в отчёте'
        optional :usr, type: Integer, desc: 'Формирование по определённому юзеру.'
      end        
      get do
        user = User.find_by_id(params[:usr])
        error!({ message: 'Пользователь с заказами не найден' }, 404) unless user
        # error!({ message: 'Счётчик не может быть < 1' }, 406) unless params[:count] > 0
        # orders = Order.find_by(user_id: params[:usr].to_i)

        ReportWorker.perform_async(params[:usr].to_i, params[:count].to_i)
        present user.report
        # present Order.where(user_id: params[:usr]).order(:cost)
      end

      route_param :result, type: String do
        get do
          present Order.all.order(:cost)
          # present Order.all #, with: GrapeApi::Entities::Report
        end
      end

    end
  end
end
