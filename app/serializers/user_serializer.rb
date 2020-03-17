# app/serializsers/user_serializer.rb
class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name

  def full_name
    "#{object.last_name} #{object.name}"
  end

end
