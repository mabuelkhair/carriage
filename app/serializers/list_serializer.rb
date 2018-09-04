class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :cards
  has_many :cards, each_serializer: CardSerializer
end