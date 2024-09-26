class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :trackable, :omniauthable

  def self.ransackable_attributes(auth_object = nil)
    [ "email" ]
  end

  attr_accessor :first_name, :last_name
  before_save :combine_names
  validates :first_name, :last_name, :email, :password, presence: true

  private

  def combine_names
    byebug
    self.name_surname = "#{first_name} #{last_name}".strip
  end
end
