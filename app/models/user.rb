class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, presence: true
  validates :password, presence: true, length: {minimum: 8, maximum: 32}
  validates :phone, presence: true, numericality: { only_integer: true }, length: { is: 10 }
  validates :username, presence: true

  has_many :users
  has_many :bookings, dependent: :destroy
  has_many :tickets, through: :bookings, dependent: :destroy


  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

  def admin?
    self.role == "admin"
  end

  def organizer?
    self.role == "organizer"
  end

  def customer?
    self.role == "customer"
  end

end
