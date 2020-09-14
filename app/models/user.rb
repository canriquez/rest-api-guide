class User < ApplicationRecord
    validates_presence_of :username, :password
    has_many :facts
end
