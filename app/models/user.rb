class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :registerable,
         :database_authenticatable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self
end