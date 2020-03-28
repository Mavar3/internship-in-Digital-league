# frozen_string_literal: true

class GrapeApi
  class UsersApi < Grape::API
    format :json

    namespace :users do
      desc 'Создание пользователя',
           success: GrapeApi::Entities::User
      params do
        requires :name, type: String, desc: 'Имя пользователя'
        requires :last_name, type: String, desc: 'Фамилия пользователя'
        requires :balance, type: Integer, desc: 'Балланс'
      end
      post do
        user = User.create(params)
        present user, with: GrapeApi::Entities::User, detail: true
      end

      #        desc 'Список пользователей',
      #            success: GrapeApi::Entities::User,
      #            is_array: true
      #        params do
      #          optional :ballance, type: Integer, desc: 'Баланс пользователя'
      #        end
      get do
        users = params[:ballance].present? ? User.where('balance >= :ballance', ballance: params[:ballance]) : User.all
        present users, with: GrapeApi::Entities::User
      end
      route_param :id, type: Integer do
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
      end
    end
  end
end
