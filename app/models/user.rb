class User < ActiveRecord::Base
    has_many :reviews

    before_save { self.email = email.downcase }
    validates :first_name, presence: true, length: { maximum: 50 }
    validates :last_name, presence: true, length: { maximum: 50 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    validates :password_confirmation, presence: true

    def self.authenticate_with_credentials(email, password)
        user = User.find_by(email: email.downcase)
        user &&= (user.authenticate(password) ? user : nil)
    end
end
