class Comment < ApplicationRecord

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================
  belongs_to :card
  belongs_to :owner ,:class_name=>'User'
  has_many :replies, class_name: "Comment",
                          foreign_key: "comment_id"
 
  belongs_to :comment, class_name: "Comment", optional: true

  # == Validations ==========================================================
  validates_length_of :content, maximum: 500, allow_nil: false, allow_blank: false

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Methods ========================================================
end
