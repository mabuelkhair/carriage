class User < ApplicationRecord
  # == Constants ============================================================
  enum role: { admin: 'admin', member: 'member' }

  # == Attributes ===========================================================

  # == Extensions ===========================================================
  has_secure_password

  # == Relationships ========================================================
  has_many :owned_lists, :foreign_key => 'owner_id', :class_name => 'List'
  has_and_belongs_to_many :lists
  # == Validations ==========================================================
  validates_presence_of     :email
  validates_presence_of     :username
  validates_uniqueness_of   :email
  validates_uniqueness_of   :username
  validates_length_of :password, maximum: 72, minimum: 8, allow_nil: false, allow_blank: false
  validates_format_of :email, 
  :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Methods ========================================================
  before_validation { 
        (self.email = self.email.to_s.downcase) && (self.username = self.username.to_s.downcase) 
    }
end
