class GrapeApi
  class ReportsApi < Grape::API
    format :json
    # Перевести на другой класс
    namespace :reports do
      desc 'Получение отчета о виртуальных пользователя',
        failure: [{ code: 404, message: 'Пользователь с заказами не найден' }]
      params do
        optional :count, type: Integer, desc: 'Количество vm в отчёте'
        optional :usr, type: Integer, desc: 'Формирование по определённому юзеру.'
      end        
      get do
        user = User.find_by_id(params[:usr])
        error!({ message: 'Пользователь с заказами не найден' }, 404) unless user
        ReportWorker.perform_async(params[:usr].to_i, params[:count].to_i)
        present user.report
      end

      route_param :result, type: String do
        get do
          present Order.all.order(:cost)
        end
      end

    end
  end
end
