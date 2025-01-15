# Class: User
# -----------
# Description: Create a user with a valid email and password
class User < ApplicationRecord

  enum role: [:admin, :organization]
  after_initialize :set_default_role, :if => :new_record?

  belongs_to :organization, optional: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_presence_of :email
  validates_length_of :email, minimum: 1, maximum: 255, on: :create
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates_uniqueness_of :email, case_sensitive: false
  validates_presence_of :password, on: :create
  validates_length_of :password, minimum: 7, maximum: 255, on: :create

# Class Definition: set_default_role
# ----------------------------------
# Sets the default role of the user to “organization”
#
# @return [Symbol] the default role of the user
  def set_default_role
    self.role ||= :organization
  end

# Class Definition: to_s
# -----------------------
# Modifies the built in function to_s to return the email associated
#
# @return [String] the email of the user
  def to_s
    email
  end

end
