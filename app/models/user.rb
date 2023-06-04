class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :cart_items, dependent: :destroy
  has_one :user_info
  has_one :payment_info

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
validates :first_name, presence: true
validates :last_name, presence: true

end
