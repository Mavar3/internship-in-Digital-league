class GrapeApi
    module Entities
      class User < Grape::Entity
        expose :id
        expose :full_name
        expose :ballance, if: lambda { |object, options| options[:detail] == true }   
        expose :id, documentation: { type: 'integer', desc: 'Идентификатор пользователя', required: true }
        expose :full_name, documentation: { type: 'string', desc: 'Полное имя пользователя', required: true }
        expose :ballance, if: lambda { |object, options| options[:detail] == true } 
      

        def full_name
          "#{object.name} #{object.last_name}"
        end
      end
    end
  end
  