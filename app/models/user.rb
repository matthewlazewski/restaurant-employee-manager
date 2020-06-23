class User < ActiveRecord::Base 
    belongs_to :job 
    has_many :posts 
    has_secure_password 

    enum role: [:employee, :manager]

    def self.set_default_role 
        self.role ||= :manager 
    end 
end 