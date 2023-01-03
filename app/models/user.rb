class User < ApplicationRecord
  has_secure_password

  devise :database_authenticatable,
         :timeoutable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :omniauthable,
         omniauth_providers: [:google_oauth2]
end
