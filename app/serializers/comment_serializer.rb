class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :replies
  has_many :replies , each_serializer: CommentSerializer
end