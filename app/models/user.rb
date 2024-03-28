class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :phone, presence: true
  validates :username, presence: true

  has_many :events
  has_many :bookings
  has_many :tickets, through: :bookings, dependent: :destroy


  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

  def admin?
    role == "admin"
  end

  def organizer?
    role == "organizer"
  end

  def customer?
    role == "customer"
  end

end
