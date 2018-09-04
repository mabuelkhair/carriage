class CardSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :comments
    def comments
        object.try(:comments).limit(3)
    end
end