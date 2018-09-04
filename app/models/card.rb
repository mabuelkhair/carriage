class Card < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================
  belongs_to :owner ,:class_name=>'User'
  belongs_to :list
  has_many :comments
  # == Validations ==========================================================
  validates_length_of :title, maximum: 100, allow_nil: false, allow_blank: false
  validates_length_of :description, maximum: 400, allow_nil: false, allow_blank: false
  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Methods ========================================================
end
