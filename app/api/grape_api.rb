# frozen_string_literal: true

class GrapeApi < Grape::API
  mount UsersApi
  mount OrdersApi
  mount ReportsApi
  add_swagger_documentation
  end
