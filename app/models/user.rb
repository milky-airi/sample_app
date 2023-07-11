class User < ApplicationRecord
  before_save { self.email =  email.downcase }
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # わたさえrた文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                 BCript::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end

