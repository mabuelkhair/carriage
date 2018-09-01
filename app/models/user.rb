class User < ApplicationRecord
  # == Constants ============================================================
  enum role: { admin: 'admin', member: 'member' }

  # == Attributes ===========================================================

  # == Extensions ===========================================================
  has_secure_password

  # == Relationships ========================================================

  # == Validations ==========================================================
  validates_presence_of     :email
  validates_presence_of     :username
  validates_uniqueness_of   :email
  validates_uniqueness_of   :username
  validates_length_of :password, maximum: 72, minimum: 8, allow_nil: false, allow_blank: false
  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Methods ========================================================
  before_validation { 
        (self.email = self.email.to_s.downcase) && (self.username = self.username.to_s.downcase) 
    }
end
