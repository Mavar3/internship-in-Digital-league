class GrapeApi
    class UsersApi < Grape::API # rubocop:disable Metrics/ClassLength
      format :json
  
      namespace :users do    
        
        


        desc 'Список пользователей',
            success: GrapeApi::Entities::User,
            is_array: true 
        params do
          optional :ballance, type: Integer, desc: 'Баланс пользователя'
        end
        get do
          users = params[:ballance].present? ? User.where('ballance >= :ballance', ballance: params[:ballance]) : User.all
          present users, with: GrapeApi::Entities::User
        end
        
        desc 'Просмотр пользователя',
            success: GrapeApi::Entities::User,
            failure: [{ code: 404, message: 'Пользователь не найдена' }]
        params do
          optional :detail, type: Boolean, desc: 'Подробная информация о пользователях'
        end
        get do
          user = User.find_by_id(params[:id])
          error!({ message: 'Пользователь не найден' }, 404) unless user
          present user, with: GrapeApi::Entities::User, detail: params[:detail]
        end




































#         params do
#           optional :ballance, type: Integer
#         end
#         get do
#           users = if params[:ballance].present?
#             User.where('ballance >= :ballance', ballance: params[:ballance])
#           else
#             User.all
#           end
#           present users
#         end
#        
#        
#
#         route_param :id, type: Integer do
#           params do
#             optional :detail, type: Boolean, desc: 'Подробная информация о пользователях'
#           end
#           get do
#             user = User.find_by_id(params[:id])
#             error!({ message: 'Пользователь не найден' }, 404) unless user
#             present user, with: GrapeApi::Entities::User, detail: params[:detail]
#           end
#         end

        
      end

      #Перевести на другой класс
      namespace :orders do
        desc 'Заказ',
          success: GrapeApi::Entities::Order,
          is_array: true 
        route_param :id, type: Integer do
          get do
            order = Order.find_by_id(params[:id])
            error!({ message: 'Заказ не найден' }, 404) unless order
            present order
          end
          #upgrate and another
        end
        desc 'Проверка по Статусу'
        params do
          optional :status, type: Integer
        end
        get do
          users = if params[:status].present?
            Order.where('status >= :status', status: params[:status])
          else
            Order.all
          end
          present users
        end
      end

      
    end
  end
  