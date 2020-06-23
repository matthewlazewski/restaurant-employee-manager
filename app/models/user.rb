class User < ActiveRecord::Base 
    belongs_to :job 
    has_many :posts 
    has_secure_password 

    def slug 
        username = self.username 
        slug = username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end 
end 