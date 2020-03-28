# frozen_string_literal: true

class GrapeApi < Grape::API
  mount UsersApi
  add_swagger_documentation
end