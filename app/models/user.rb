class User < ActiveRecord::Base 
    belongs_to :job 
    has_many :posts 
    has_secure_password 
end 