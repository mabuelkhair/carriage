class CardSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :comments
    def comments
        first_three_comments = object.try(:comments).limit(3)
        ActiveModelSerializers::SerializableResource.new(first_three_comments, each_serializer: CommentSerializer)
    end
end