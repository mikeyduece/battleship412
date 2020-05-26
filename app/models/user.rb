class User < ApplicationRecord
  include Authentication::Doorkeeper

  belongs_to :game, optional: true

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true, case_sensitive: false
end
