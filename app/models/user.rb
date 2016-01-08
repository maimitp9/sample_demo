class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { maximum: 6 }
  validates :password_confirmation, presence: true, length: { maximum: 6 }

  #select all microfeed which are associate with this user id
  def feed
    Micropost.where('user_id = ?',id)
  end

  # Generate new remember token when user signup
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  # Encrypt new remember token using SHA1
  def User.digest(token)
    Digest::SHA1::hexdigest(token.to_s)
  end

  private

    #create new remember_token
    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
