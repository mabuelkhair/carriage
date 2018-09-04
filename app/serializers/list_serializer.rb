class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :cards
    def cards
        object.try(:cards)
    end
end