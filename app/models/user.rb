class User < ApplicationRecord
    validates_presence_of :username, :password
    validates :username, uniqueness: true
    has_many :facts
    has_secure_password
end
